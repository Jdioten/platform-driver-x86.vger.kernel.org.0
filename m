Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36A51522AE
	for <lists+platform-driver-x86@lfdr.de>; Wed,  5 Feb 2020 00:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgBDXE5 (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Tue, 4 Feb 2020 18:04:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:22705 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbgBDXE5 (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Tue, 4 Feb 2020 18:04:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 15:04:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="264018001"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.172])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2020 15:04:56 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v2 5/7] platform/x86: intel_pmc_core: Add an additional parameter to pmc_core_lpm_display()
Date:   Tue,  4 Feb 2020 15:01:58 -0800
Message-Id: <ae51a224fd4db156640032b63de315ae914993bd.1580848931.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580848931.git.gayatri.kammela@intel.com>
References: <cover.1580848931.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1580848931.git.gayatri.kammela@intel.com>
References: <cover.1580848931.git.gayatri.kammela@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Add a device pointer of type struct device as an additional parameter to
pmc_core_lpm_display(), so that the driver can re-use it to dump the
debug registers in resume for an S0ix failure.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index a7394cfc4906..41426d4af887 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -973,8 +973,9 @@ static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_res);
 
-static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct seq_file *s,
-				 u32 offset, const char *str,
+static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
+				 struct seq_file *s, u32 offset,
+				 const char *str,
 				 const struct pmc_bit_map **maps)
 {
 	u32 lpm_regs[ARRAY_SIZE(tgl_lpm_maps)-1];
@@ -986,11 +987,22 @@ static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct seq_file *s,
 	}
 
 	for (idx = 0; maps[idx]; idx++) {
-		seq_printf(s, "\nLPM_%s_%d:\t0x%x\n", str, idx, lpm_regs[idx]);
+		if (dev)
+			dev_dbg(dev, "\nLPM_%s_%d:\t0x%x\n", str, idx,
+				lpm_regs[idx]);
+		if (s)
+			seq_printf(s, "\nLPM_%s_%d:\t0x%x\n", str, idx,
+				   lpm_regs[idx]);
 		for (index = 0; maps[idx][index].name && index < len; index++) {
 			bit_mask = maps[idx][index].bit_mask;
-			seq_printf(s, "%-30s %-30d\n", maps[idx][index].name,
-				   lpm_regs[idx] & bit_mask ? 1 : 0);
+			if (dev)
+				dev_dbg(dev, "%-30s %-30d\n",
+					maps[idx][index].name,
+					lpm_regs[idx] & bit_mask ? 1 : 0);
+			if (s)
+				seq_printf(s, "%-30s %-30d\n",
+					   maps[idx][index].name,
+					   lpm_regs[idx] & bit_mask ? 1 : 0);
 		}
 	}
 }
@@ -1001,7 +1013,7 @@ static int pmc_core_substate_sts_regs_show(struct seq_file *s, void *unused)
 	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
 	u32 offset = pmcdev->map->lpm_status_offset;
 
-	pmc_core_lpm_display(pmcdev, s, offset, "STATUS", maps);
+	pmc_core_lpm_display(pmcdev, NULL, s, offset, "STATUS", maps);
 
 	return 0;
 }
-- 
2.17.1

