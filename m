Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF6AE14417B
	for <lists+platform-driver-x86@lfdr.de>; Tue, 21 Jan 2020 17:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgAUQEK (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Tue, 21 Jan 2020 11:04:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:18395 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgAUQEI (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Tue, 21 Jan 2020 11:04:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 08:01:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="250299061"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2020 08:01:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F2A464CA; Tue, 21 Jan 2020 18:01:14 +0200 (EET)
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
        Mark Brown <broonie@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/38] platform/x86: intel_scu_ipc: Fix interrupt support
Date:   Tue, 21 Jan 2020 19:00:42 +0300
Message-Id: <20200121160114.60007-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Currently the driver has disabled interrupt support for Tangier but
actually interrupt works just fine if the command is not written twice
in a row. Also we need to ack the interrupt in the handler.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 48 ++++++----------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index b39680b53387..43eaf9400c67 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -58,24 +58,6 @@
 #define IPC_RWBUF_SIZE    20		/* IPC Read buffer Size */
 #define IPC_IOC	          0x100		/* IPC command register IOC bit */
 
-#define PCI_DEVICE_ID_PENWELL		0x080e
-#define PCI_DEVICE_ID_CLOVERVIEW	0x08ea
-#define PCI_DEVICE_ID_TANGIER		0x11a0
-
-/* intel scu ipc driver data */
-struct intel_scu_ipc_pdata_t {
-	u8 irq_mode;
-};
-
-/* Penwell and Cloverview */
-static const struct intel_scu_ipc_pdata_t intel_scu_ipc_penwell_pdata = {
-	.irq_mode = 1,
-};
-
-static const struct intel_scu_ipc_pdata_t intel_scu_ipc_tangier_pdata = {
-	.irq_mode = 0,
-};
-
 struct intel_scu_ipc_dev {
 	struct device *dev;
 	void __iomem *ipc_base;
@@ -86,6 +68,7 @@ struct intel_scu_ipc_dev {
 static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
 
 #define IPC_STATUS		0x04
+#define IPC_STATUS_IRQ		BIT(2)
 #define IPC_STATUS_ERR		BIT(1)
 #define IPC_STATUS_BUSY		BIT(0)
 
@@ -107,11 +90,8 @@ static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
  */
 static inline void ipc_command(struct intel_scu_ipc_dev *scu, u32 cmd)
 {
-	if (scu->irq_mode) {
-		reinit_completion(&scu->cmd_complete);
-		writel(cmd | IPC_IOC, scu->ipc_base);
-	}
-	writel(cmd, scu->ipc_base);
+	reinit_completion(&scu->cmd_complete);
+	writel(cmd | IPC_IOC, scu->ipc_base);
 }
 
 /*
@@ -549,9 +529,10 @@ EXPORT_SYMBOL_GPL(intel_scu_ipc_raw_command);
 static irqreturn_t ioc(int irq, void *dev_id)
 {
 	struct intel_scu_ipc_dev *scu = dev_id;
+	int status = ipc_read_status(scu);
 
-	if (scu->irq_mode)
-		complete(&scu->cmd_complete);
+	writel(status | IPC_STATUS_IRQ, scu->ipc_base + IPC_STATUS);
+	complete(&scu->cmd_complete);
 
 	return IRQ_HANDLED;
 }
@@ -568,17 +549,10 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int err;
 	struct intel_scu_ipc_dev *scu = &ipcdev;
-	struct intel_scu_ipc_pdata_t *pdata;
 
 	if (scu->dev)		/* We support only one SCU */
 		return -EBUSY;
 
-	pdata = (struct intel_scu_ipc_pdata_t *)id->driver_data;
-	if (!pdata)
-		return -ENODEV;
-
-	scu->irq_mode = pdata->irq_mode;
-
 	err = pcim_enable_device(pdev);
 	if (err)
 		return err;
@@ -605,13 +579,11 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 }
 
-#define SCU_DEVICE(id, pdata)	{PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&pdata}
-
 static const struct pci_device_id pci_ids[] = {
-	SCU_DEVICE(PCI_DEVICE_ID_PENWELL,	intel_scu_ipc_penwell_pdata),
-	SCU_DEVICE(PCI_DEVICE_ID_CLOVERVIEW,	intel_scu_ipc_penwell_pdata),
-	SCU_DEVICE(PCI_DEVICE_ID_TANGIER,	intel_scu_ipc_tangier_pdata),
-	{}
+	{ PCI_VDEVICE(INTEL, 0x080e) },
+	{ PCI_VDEVICE(INTEL, 0x08ea) },
+	{ PCI_VDEVICE(INTEL, 0x11a0) },
+	{ }
 };
 
 static struct pci_driver ipc_driver = {
-- 
2.24.1

