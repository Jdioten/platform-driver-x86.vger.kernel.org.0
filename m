Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42028FCB4B
	for <lists+platform-driver-x86@lfdr.de>; Thu, 14 Nov 2019 18:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKNRBh (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Thu, 14 Nov 2019 12:01:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:50122 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbfKNRBh (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Thu, 14 Nov 2019 12:01:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 09:01:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="257506336"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.161])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2019 09:01:35 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     vishwanath.somayaji@intel.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 3/7] x86/intel_pmc_core: Create platform dependent pmc bitmap structs
Date:   Thu, 14 Nov 2019 09:01:16 -0800
Message-Id: <1aa97ccfa05ba76c88bce1d71d64e7fcb9ec1d43.1573750525.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573750525.git.gayatri.kammela@intel.com>
References: <cover.1573750525.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1573750525.git.gayatri.kammela@intel.com>
References: <cover.1573750525.git.gayatri.kammela@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

The current implementation of pmc_core driver allows to reuse, but does
not reflect the exact number and names of IPs for a newer platform which
does not necessarily support all the IPs in the entries. The names and
number of these IPs might differ from its previous platforms. The number
of PCH IPs per platform is calculated based on PPFEAR_NUM_ENTRIES
defined, where each entry represents a bucket (8 bits). The platform can
support 'n' entries, but not necessarily all 'n*8' IPs.

Create platform dependent bitmap structures to specify the exact number,
names of IPs while reusing the existing IPs.

The changes in this patch are preparatory to accommodate future SoCs
that might reuse the CNL/ICL PCH IPs, and to reflect the exact number of
IPs with its names.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 46 ++++++++++++++++++++-------
 drivers/platform/x86/intel_pmc_core.h |  2 +-
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 3c07a0172764..a945a0081ebe 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -116,6 +116,11 @@ static const struct pmc_bit_map spt_pfear_map[] = {
 	{}
 };
 
+static const struct pmc_bit_map *ext_spt_pfear_map[] = {
+	spt_pfear_map,
+	NULL
+};
+
 static const struct pmc_bit_map spt_ltr_show_map[] = {
 	{"SOUTHPORT_A",		SPT_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		SPT_PMC_LTR_SPB},
@@ -142,7 +147,7 @@ static const struct pmc_bit_map spt_ltr_show_map[] = {
 };
 
 static const struct pmc_reg_map spt_reg_map = {
-	.pfear_sts = spt_pfear_map,
+	.pfear_sts = ext_spt_pfear_map,
 	.mphy_sts = spt_mphy_map,
 	.pll_sts = spt_pll_map,
 	.ltr_show_sts = spt_ltr_show_map,
@@ -233,7 +238,15 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"PSF6",		BIT(5)},
 	{"PSF7",		BIT(6)},
 	{"PSF8",		BIT(7)},
+	{}
+};
+
+static const struct pmc_bit_map *ext_cnp_pfear_map[] = {
+	cnp_pfear_map,
+	NULL
+};
 
+static const struct pmc_bit_map icl_pfear_map[] = {
 	/* Ice Lake generation onwards only */
 	{"RES_65",		BIT(0)},
 	{"RES_66",		BIT(1)},
@@ -246,6 +259,12 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{}
 };
 
+static const struct pmc_bit_map *ext_icl_pfear_map[] = {
+	cnp_pfear_map,
+	icl_pfear_map,
+	NULL
+};
+
 static const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
 	{"AUDIO_D3",		BIT(0)},
 	{"OTG_D3",		BIT(1)},
@@ -333,7 +352,7 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
 };
 
 static const struct pmc_reg_map cnp_reg_map = {
-	.pfear_sts = cnp_pfear_map,
+	.pfear_sts = ext_cnp_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slps0_dbg_maps = cnp_slps0_dbg_maps,
 	.ltr_show_sts = cnp_ltr_show_map,
@@ -349,7 +368,7 @@ static const struct pmc_reg_map cnp_reg_map = {
 };
 
 static const struct pmc_reg_map icl_reg_map = {
-	.pfear_sts = cnp_pfear_map,
+	.pfear_sts = ext_icl_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slps0_dbg_maps = cnp_slps0_dbg_maps,
 	.ltr_show_sts = cnp_ltr_show_map,
@@ -411,20 +430,20 @@ static int pmc_core_check_read_lock_bit(void)
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 static bool slps0_dbg_latch;
 
-static void pmc_core_display_map(struct seq_file *s, int index,
-				 u8 pf_reg, const struct pmc_bit_map *pf_map)
+static void pmc_core_display_map(struct seq_file *s, int index, int idx, int ip,
+				 u8 pf_reg, const struct pmc_bit_map **pf_map)
 {
 	seq_printf(s, "PCH IP: %-2d - %-32s\tState: %s\n",
-		   index, pf_map[index].name,
-		   pf_map[index].bit_mask & pf_reg ? "Off" : "On");
+		   ip, pf_map[idx][index].name,
+		   pf_map[idx][index].bit_mask & pf_reg ? "Off" : "On");
 }
 
 static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	const struct pmc_bit_map *map = pmcdev->map->pfear_sts;
+	const struct pmc_bit_map **maps = pmcdev->map->pfear_sts;
 	u8 pf_regs[PPFEAR_MAX_NUM_ENTRIES];
-	int index, iter;
+	int index, iter, idx, ip = 0;
 
 	iter = pmcdev->map->ppfear0_offset;
 
@@ -432,9 +451,12 @@ static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 	     index < PPFEAR_MAX_NUM_ENTRIES; index++, iter++)
 		pf_regs[index] = pmc_core_reg_read_byte(pmcdev, iter);
 
-	for (index = 0; map[index].name &&
-	     index < pmcdev->map->ppfear_buckets * 8; index++)
-		pmc_core_display_map(s, index, pf_regs[index / 8], map);
+	for (idx = 0; maps[idx]; idx++) {
+		for (index = 0; maps[idx][index].name &&
+		     index < pmcdev->map->ppfear_buckets * 8; ip++, index++)
+			pmc_core_display_map(s, index, idx, ip,
+					     pf_regs[index / 8], maps);
+	}
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index fdee5772e532..4b9f9ad6b692 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -213,7 +213,7 @@ struct pmc_bit_map {
  * captures them to have a common implementation.
  */
 struct pmc_reg_map {
-	const struct pmc_bit_map *pfear_sts;
+	const struct pmc_bit_map **pfear_sts;
 	const struct pmc_bit_map *mphy_sts;
 	const struct pmc_bit_map *pll_sts;
 	const struct pmc_bit_map **slps0_dbg_maps;
-- 
2.17.1

