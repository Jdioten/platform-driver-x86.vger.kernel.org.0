Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFB71392D0
	for <lists+platform-driver-x86@lfdr.de>; Mon, 13 Jan 2020 14:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAMN6I (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 13 Jan 2020 08:58:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:54632 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbgAMN4h (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 13 Jan 2020 08:56:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 05:56:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="372269021"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2020 05:56:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D0D4E727; Mon, 13 Jan 2020 15:56:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/36] platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_simple_command() static
Date:   Mon, 13 Jan 2020 16:56:06 +0300
Message-Id: <20200113135623.56286-20-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

This function is not called outside of intel_pmc_ipc.c so we can make it
static instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel_pmc_ipc.h | 6 ------
 drivers/platform/x86/intel_pmc_ipc.c | 3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index 3b2e8b461520..b4f804877651 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -31,7 +31,6 @@
 
 #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
 
-int intel_pmc_ipc_simple_command(int cmd, int sub);
 int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
 		u32 *out, u32 outlen, u32 dptr, u32 sptr);
 int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
@@ -43,11 +42,6 @@ int intel_pmc_gcr_write(u32 offset, u32 data);
 
 #else
 
-static inline int intel_pmc_ipc_simple_command(int cmd, int sub)
-{
-	return -EINVAL;
-}
-
 static inline int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
 		u32 *out, u32 outlen, u32 dptr, u32 sptr)
 {
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 9229c7a16536..53551f5474a7 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -404,7 +404,7 @@ static int intel_pmc_ipc_check_status(void)
  *
  * Return:	an IPC error code or 0 on success.
  */
-int intel_pmc_ipc_simple_command(int cmd, int sub)
+static int intel_pmc_ipc_simple_command(int cmd, int sub)
 {
 	int ret;
 
@@ -419,7 +419,6 @@ int intel_pmc_ipc_simple_command(int cmd, int sub)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(intel_pmc_ipc_simple_command);
 
 /**
  * intel_pmc_ipc_raw_cmd() - IPC command with data and pointers
-- 
2.24.1

