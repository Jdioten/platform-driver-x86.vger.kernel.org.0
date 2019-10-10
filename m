Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEAD3245
	for <lists+platform-driver-x86@lfdr.de>; Thu, 10 Oct 2019 22:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfJJUaL (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Thu, 10 Oct 2019 16:30:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:30902 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfJJU37 (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Thu, 10 Oct 2019 16:29:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 13:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; 
   d="scan'208";a="277902043"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2019 13:29:51 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RESEND][PATCH 10/10] tools/power/x86/intel-speed-select: Implement base-freq commands on CascadeLake-N
Date:   Thu, 10 Oct 2019 13:29:45 -0700
Message-Id: <20191010202945.73616-11-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
References: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

Add functionality for base-freq info|enable|disable info on CascadeLake-N.

Sample output:
Intel(R) Speed Select Technology
Executing on CPU model:85[0x55]
 package-0
  die-0
    cpu-0
      speed-select-base-freq
        high-priority-base-frequency(MHz):2700000
        high-priority-cpu-mask:00000000,0000e8c0
        high-priority-cpu-list:6,7,11,13,14,15
        low-priority-base-frequency(MHz):2100000
 package-1
  die-0
    cpu-20
      speed-select-base-freq
        high-priority-base-frequency(MHz):2700000
        high-priority-cpu-mask:0000000e,8c000000
        high-priority-cpu-list:26,27,31,33,34,35
        low-priority-base-frequency(MHz):2100000

The enable command always returns success, and the disable command always
returns failed because SST-BF cannot be enabled or disabled from the OS on
CascadeLake-N.

Enable command also have support for --auto|-a option, which sets cpufreq
scaling_min to max, so that the high priority base frequency can be the
required minimum for high priority cores. Disable command with -a/--auto
option reset the setting back to the min frequency.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 51 +++++++++++++++++--
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 3c0eb4240df4..1c20048b42e7 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1005,6 +1005,26 @@ static void set_tdp_level(int arg)
 	isst_ctdp_display_information_end(outf);
 }
 
+static void clx_n_dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2,
+				       void *arg3, void *arg4)
+{
+	int ret;
+
+	ret = clx_n_config(cpu);
+	if (ret) {
+		perror("isst_get_process_ctdp");
+	} else {
+		struct isst_pkg_ctdp_level_info *ctdp_level;
+		struct isst_pbf_info *pbf_info;
+
+		ctdp_level = &clx_n_pkg_dev.ctdp_level[0];
+		pbf_info = &ctdp_level->pbf_info;
+		isst_pbf_display_information(cpu, outf, tdp_level, pbf_info);
+		free_cpu_set(ctdp_level->core_cpumask);
+		free_cpu_set(pbf_info->core_cpumask);
+	}
+}
+
 static void dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 				    void *arg4)
 {
@@ -1022,6 +1042,8 @@ static void dump_pbf_config_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 
 static void dump_pbf_config(int arg)
 {
+	void *fn;
+
 	if (cmd_help) {
 		fprintf(stderr,
 			"Print Intel(R) Speed Select Technology base frequency configuration for a TDP level\n");
@@ -1035,13 +1057,18 @@ static void dump_pbf_config(int arg)
 		exit(1);
 	}
 
+	if (!is_clx_n_platform())
+		fn = dump_pbf_config_for_cpu;
+	else
+		fn = clx_n_dump_pbf_config_for_cpu;
+
 	isst_ctdp_display_information_start(outf);
+
 	if (max_target_cpus)
-		for_each_online_target_cpu_in_set(dump_pbf_config_for_cpu, NULL,
-						  NULL, NULL, NULL);
+		for_each_online_target_cpu_in_set(fn, NULL, NULL, NULL, NULL);
 	else
-		for_each_online_package_in_set(dump_pbf_config_for_cpu, NULL,
-					       NULL, NULL, NULL);
+		for_each_online_package_in_set(fn, NULL, NULL, NULL, NULL);
+
 	isst_ctdp_display_information_end(outf);
 }
 
@@ -1235,6 +1262,19 @@ static void set_pbf_for_cpu(int cpu, void *arg1, void *arg2, void *arg3,
 	int ret;
 	int status = *(int *)arg4;
 
+	if (is_clx_n_platform()) {
+		if (status == 0) {
+			ret = -1;
+			if (auto_mode)
+				set_scaling_min_to_cpuinfo_min(cpu);
+		} else {
+			ret = 0;
+			if (auto_mode)
+				set_scaling_min_to_cpuinfo_max(cpu);
+		}
+		goto disp_result;
+	}
+
 	if (auto_mode) {
 		if (status) {
 			ret = set_pbf_core_power(cpu);
@@ -1763,6 +1803,9 @@ static void get_clos_assoc(int arg)
 
 static struct process_cmd_struct clx_n_cmds[] = {
 	{ "perf-profile", "info", dump_isst_config, 0 },
+	{ "base-freq", "info", dump_pbf_config, 0 },
+	{ "base-freq", "enable", set_pbf_enable, 1 },
+	{ "base-freq", "disable", set_pbf_enable, 0 },
 	{ NULL, NULL, NULL, 0 }
 };
 
-- 
2.17.2

