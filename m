Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6BBBBED
	for <lists+platform-driver-x86@lfdr.de>; Mon, 23 Sep 2019 20:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbfIWS7K (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 23 Sep 2019 14:59:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:39237 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733156AbfIWS7J (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 23 Sep 2019 14:59:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 11:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,541,1559545200"; 
   d="scan'208";a="203187146"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2019 11:59:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] tools/power/x86/intel-speed-select: Base-freq feature auto mode
Date:   Mon, 23 Sep 2019 11:59:04 -0700
Message-Id: <20190923185906.76032-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190923185906.76032-1-srinivas.pandruvada@linux.intel.com>
References: <20190923185906.76032-1-srinivas.pandruvada@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Introduce --auto|-a option to base-freq enable feature, so that it
does in one step for users who are OK by setting all cores with higher
base frequency to be set in CLOS 0 and remaining in CLOS 3. This option
also sets corresponding clos.min to CLOS 0 and CLOS3. In this way, users
don't have to take multiple steps to enable base-freq feature. For users
who want more fine grain control, they can always use core-power feature
to set custom CLOS configuration and assignment.

Also adjust cpufreq/scaling_min_freq for higher and lower priority cores.

For example user can use:
intel-speed-select base-freq enable --auto

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 196 +++++++++++++++++-
 1 file changed, 191 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 2a9890c8395a..5da59ff47306 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -39,6 +39,7 @@ static unsigned long long fact_trl;
 static int out_format_json;
 static int cmd_help;
 static int force_online_offline;
+static int auto_mode;
 
 /* clos related */
 static int current_clos = -1;
@@ -852,6 +853,174 @@ static void dump_pbf_config(void)
 	isst_ctdp_display_information_end(outf);
 }
 
+static int set_clos_param(int cpu, int clos, int epp, int wt, int min,
+				  int max)
+{
+	struct isst_clos_config clos_config;
+	int ret;
+
+	ret = isst_pm_get_clos(cpu, clos, &clos_config);
+	if (ret) {
+		perror("isst_pm_get_clos");
+		return ret;
+	}
+	clos_config.clos_min = min;
+	clos_config.clos_max = max;
+	clos_config.epp = epp;
+	clos_config.clos_prop_prio = wt;
+	ret = isst_set_clos(cpu, clos, &clos_config);
+	if (ret) {
+		perror("isst_pm_set_clos");
+		return ret;
+	}
+
+	return 0;
+}
+
+/* No error processing as cpufreq can be absent */
+static void set_cpufreq_scaling_min(int cpu, int ratio)
+{
+	char buffer[128];
+	int fd, len;
+
+	snprintf(buffer, sizeof(buffer),
+		 "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", cpu);
+
+	fd = open(buffer, O_WRONLY);
+	if (fd < 0)
+		return;
+
+	len = snprintf(buffer, sizeof(buffer), "%d\n", ratio * 100000);
+	write(fd, buffer, len);
+	close(fd);
+}
+
+static void reset_cpufreq_scaling_min(void)
+{
+	int i;
+
+	for (i = 0; i < get_topo_max_cpus(); ++i) {
+		char buffer[128], min_freq[16];
+		int fd, len;
+
+		if (!CPU_ISSET_S(i, present_cpumask_size, present_cpumask))
+			continue;
+
+		snprintf(buffer, sizeof(buffer),
+			 "/sys/devices/system/cpu/cpu%d/cpufreq/cpuinfo_min_freq", i);
+
+		fd = open(buffer, O_RDONLY);
+		if (fd < 0)
+			break;
+
+		len = read(fd, min_freq, sizeof(min_freq));
+		close(fd);
+
+		if (len < 0)
+			break;
+
+		snprintf(buffer, sizeof(buffer),
+			 "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_min_freq", i);
+
+		fd = open(buffer, O_WRONLY);
+		if (fd < 0)
+			break;
+
+		len = strlen(min_freq);
+		write(fd, min_freq, len);
+		close(fd);
+	}
+}
+
+static int set_core_priority_and_min(int cpu, int mask_size,
+				     cpu_set_t *cpu_mask, int min_high,
+				     int min_low)
+{
+	int pkg_id, die_id, ret, i;
+
+	if (!CPU_COUNT_S(mask_size, cpu_mask))
+		return -1;
+
+	ret = set_clos_param(cpu, 0, 0, 0, min_high, 0xff);
+	if (ret)
+		return ret;
+
+	ret = set_clos_param(cpu, 1, 15, 0, min_low, 0xff);
+	if (ret)
+		return ret;
+
+	ret = set_clos_param(cpu, 2, 15, 0, min_low, 0xff);
+	if (ret)
+		return ret;
+
+	ret = set_clos_param(cpu, 3, 15, 0, min_low, 0xff);
+	if (ret)
+		return ret;
+
+	pkg_id = get_physical_package_id(cpu);
+	die_id = get_physical_die_id(cpu);
+	for (i = 0; i < get_topo_max_cpus(); ++i) {
+		int clos;
+
+		if (pkg_id != get_physical_package_id(i) ||
+		    die_id != get_physical_die_id(i))
+			continue;
+
+		if (CPU_ISSET_S(i, mask_size, cpu_mask))
+			clos = 0;
+		else
+			clos = 3;
+
+		debug_printf("Associate cpu: %d clos: %d\n", i, clos);
+		ret = isst_clos_associate(i, clos);
+		if (ret) {
+			perror("isst_clos_associate");
+			return ret;
+		}
+		set_cpufreq_scaling_min(i, min_low);
+	}
+
+	return 0;
+}
+
+static int set_pbf_core_power(int cpu)
+{
+	struct isst_pbf_info pbf_info;
+	struct isst_pkg_ctdp pkg_dev;
+	int ret;
+
+	ret = isst_get_ctdp_levels(cpu, &pkg_dev);
+	if (ret) {
+		perror("isst_get_ctdp_levels");
+		return ret;
+	}
+	debug_printf("Current_level: %d\n", pkg_dev.current_level);
+
+	ret = isst_get_pbf_info(cpu, pkg_dev.current_level, &pbf_info);
+	if (ret) {
+		perror("isst_get_pbf_info");
+		return ret;
+	}
+	debug_printf("p1_high: %d p1_low: %d\n", pbf_info.p1_high,
+		     pbf_info.p1_low);
+
+	ret = set_core_priority_and_min(cpu, pbf_info.core_cpumask_size,
+					pbf_info.core_cpumask,
+					pbf_info.p1_high, pbf_info.p1_low);
+	if (ret) {
+		perror("set_core_priority_and_min");
+		return ret;
+	}
+
+	ret = isst_pm_qos_config(cpu, 1, 1);
+	if (ret) {
+		perror("isst_pm_qos_config");
+		return ret;
+	}
+
+	return 0;
+}
+
 static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 			    void *arg4)
 {
@@ -862,12 +1031,17 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	if (ret) {
 		perror("isst_set_pbf");
 	} else {
-		if (status)
+		if (status) {
+			if (auto_mode)
+				ret = set_pbf_core_power(cpu);
 			isst_display_result(cpu, outf, "base-freq", "enable",
 					    ret);
-		else
+		} else {
+			if (auto_mode)
+				isst_pm_qos_config(cpu, 0, 0);
 			isst_display_result(cpu, outf, "base-freq", "disable",
 					    ret);
+		}
 	}
 }
 
@@ -877,7 +1051,10 @@ static void set_pbf_enable(void)
 
 	if (cmd_help) {
 		fprintf(stderr,
-			"Enable Intel Speed Select Technology base frequency feature [No command arguments are required]\n");
+			"Enable Intel Speed Select Technology base frequency feature\n");
+		fprintf(stderr,
+			"\tOptional Arguments: -a|--auto : Use priority of cores to set core-power associations\n");
+
 		exit(0);
 	}
 
@@ -897,7 +1074,9 @@ static void set_pbf_disable(void)
 
 	if (cmd_help) {
 		fprintf(stderr,
-			"Disable Intel Speed Select Technology base frequency feature [No command arguments are required]\n");
+			"Disable Intel Speed Select Technology base frequency feature\n");
+		fprintf(stderr,
+			"\tOptional Arguments: -a|--auto : Also disable core-power associations\n");
 		exit(0);
 	}
 
@@ -909,6 +1088,9 @@ static void set_pbf_disable(void)
 		for_each_online_package_in_set(set_pbf_for_cpu, NULL, NULL,
 					       NULL, &status);
 	isst_ctdp_display_information_end(outf);
+
+	if (auto_mode)
+		reset_cpufreq_scaling_min();
 }
 
 static void dump_fact_config_for_cpu(int cpu, void *arg1, void *arg2,
@@ -1417,15 +1599,19 @@ static void parse_cmd_args(int argc, int start, char **argv)
 		{ "max", required_argument, 0, 'm' },
 		{ "priority", required_argument, 0, 'p' },
 		{ "weight", required_argument, 0, 'w' },
+		{ "auto", no_argument, 0, 'a' },
 		{ 0, 0, 0, 0 }
 	};
 
 	option_index = start;
 
 	optind = start + 1;
-	while ((opt = getopt_long(argc, argv, "b:l:t:c:d:e:n:m:p:w:ho",
+	while ((opt = getopt_long(argc, argv, "b:l:t:c:d:e:n:m:p:w:hoa",
 				  long_options, &option_index)) != -1) {
 		switch (opt) {
+		case 'a':
+			auto_mode = 1;
+			break;
 		case 'b':
 			fact_bucket = atoi(optarg);
 			break;
-- 
2.17.2

