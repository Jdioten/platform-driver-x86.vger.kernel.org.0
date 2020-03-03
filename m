Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 467F4177747
	for <lists+platform-driver-x86@lfdr.de>; Tue,  3 Mar 2020 14:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgCCNgy (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Tue, 3 Mar 2020 08:36:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:26134 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbgCCNgy (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Tue, 3 Mar 2020 08:36:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 05:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="263198836"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Mar 2020 05:36:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 81022213; Tue,  3 Mar 2020 15:36:49 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/19] platform/x86: intel_scu_ipc: Move legacy SCU IPC API to a separate header
Date:   Tue,  3 Mar 2020 16:36:33 +0300
Message-Id: <20200303133649.39819-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
References: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

In preparation for introducing a new API for SCU IPC, move the legacy
API and constants to a separate header that is is subject to be removed
eventually.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel_scu_ipc.h        | 56 +------------------
 arch/x86/include/asm/intel_scu_ipc_legacy.h | 62 +++++++++++++++++++++
 2 files changed, 63 insertions(+), 55 deletions(-)
 create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index c53d18f9440b..2d0e485842fd 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -3,22 +3,6 @@
 #define  _ASM_X86_INTEL_SCU_IPC_H_
 
 #include <linux/ioport.h>
-#include <linux/notifier.h>
-
-#define IPCMSG_INDIRECT_READ	0x02
-#define IPCMSG_INDIRECT_WRITE	0x05
-
-#define IPCMSG_COLD_OFF		0x80	/* Only for Tangier */
-
-#define IPCMSG_WARM_RESET	0xF0
-#define IPCMSG_COLD_RESET	0xF1
-#define IPCMSG_SOFT_RESET	0xF2
-#define IPCMSG_COLD_BOOT	0xF3
-
-#define IPCMSG_VRTC		0xFA	 /* Set vRTC device */
-	/* Command id associated with message IPCMSG_VRTC */
-	#define IPC_CMD_VRTC_SETTIME      1 /* Set time */
-	#define IPC_CMD_VRTC_SETALARM     2 /* Set alarm */
 
 struct device;
 struct intel_scu_ipc_dev;
@@ -37,44 +21,6 @@ struct intel_scu_ipc_dev *
 intel_scu_ipc_register(struct device *parent,
 		       const struct intel_scu_ipc_data *scu_data);
 
-/* Read single register */
-int intel_scu_ipc_ioread8(u16 addr, u8 *data);
-
-/* Read a vector */
-int intel_scu_ipc_readv(u16 *addr, u8 *data, int len);
-
-/* Write single register */
-int intel_scu_ipc_iowrite8(u16 addr, u8 data);
-
-/* Write a vector */
-int intel_scu_ipc_writev(u16 *addr, u8 *data, int len);
-
-/* Update single register based on the mask */
-int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask);
-
-/* Issue commands to the SCU with or without data */
-int intel_scu_ipc_simple_command(int cmd, int sub);
-int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
-			  u32 *out, int outlen);
-
-extern struct blocking_notifier_head intel_scu_notifier;
-
-static inline void intel_scu_notifier_add(struct notifier_block *nb)
-{
-	blocking_notifier_chain_register(&intel_scu_notifier, nb);
-}
-
-static inline void intel_scu_notifier_remove(struct notifier_block *nb)
-{
-	blocking_notifier_chain_unregister(&intel_scu_notifier, nb);
-}
-
-static inline int intel_scu_notifier_post(unsigned long v, void *p)
-{
-	return blocking_notifier_call_chain(&intel_scu_notifier, v, p);
-}
-
-#define		SCU_AVAILABLE		1
-#define		SCU_DOWN		2
+#include <asm/intel_scu_ipc_legacy.h>
 
 #endif
diff --git a/arch/x86/include/asm/intel_scu_ipc_legacy.h b/arch/x86/include/asm/intel_scu_ipc_legacy.h
new file mode 100644
index 000000000000..d3a02bc07edd
--- /dev/null
+++ b/arch/x86/include/asm/intel_scu_ipc_legacy.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
+#define _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
+
+#include <linux/notifier.h>
+
+#define IPCMSG_INDIRECT_READ	0x02
+#define IPCMSG_INDIRECT_WRITE	0x05
+
+#define IPCMSG_COLD_OFF		0x80	/* Only for Tangier */
+
+#define IPCMSG_WARM_RESET	0xF0
+#define IPCMSG_COLD_RESET	0xF1
+#define IPCMSG_SOFT_RESET	0xF2
+#define IPCMSG_COLD_BOOT	0xF3
+
+#define IPCMSG_VRTC		0xFA	/* Set vRTC device */
+/* Command id associated with message IPCMSG_VRTC */
+#define IPC_CMD_VRTC_SETTIME      1	/* Set time */
+#define IPC_CMD_VRTC_SETALARM     2	/* Set alarm */
+
+/* Read single register */
+int intel_scu_ipc_ioread8(u16 addr, u8 *data);
+
+/* Read a vector */
+int intel_scu_ipc_readv(u16 *addr, u8 *data, int len);
+
+/* Write single register */
+int intel_scu_ipc_iowrite8(u16 addr, u8 data);
+
+/* Write a vector */
+int intel_scu_ipc_writev(u16 *addr, u8 *data, int len);
+
+/* Update single register based on the mask */
+int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask);
+
+/* Issue commands to the SCU with or without data */
+int intel_scu_ipc_simple_command(int cmd, int sub);
+int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
+			  u32 *out, int outlen);
+
+extern struct blocking_notifier_head intel_scu_notifier;
+
+static inline void intel_scu_notifier_add(struct notifier_block *nb)
+{
+	blocking_notifier_chain_register(&intel_scu_notifier, nb);
+}
+
+static inline void intel_scu_notifier_remove(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&intel_scu_notifier, nb);
+}
+
+static inline int intel_scu_notifier_post(unsigned long v, void *p)
+{
+	return blocking_notifier_call_chain(&intel_scu_notifier, v, p);
+}
+
+#define		SCU_AVAILABLE		1
+#define		SCU_DOWN		2
+
+#endif
-- 
2.25.1

