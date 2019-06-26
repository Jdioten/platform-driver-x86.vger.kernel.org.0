Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D4157472
	for <lists+platform-driver-x86@lfdr.de>; Thu, 27 Jun 2019 00:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFZWjE (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Wed, 26 Jun 2019 18:39:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:10648 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfFZWjD (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Wed, 26 Jun 2019 18:39:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 15:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="313574992"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.133.109])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 15:39:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org,
        andriy.shevchenko@intel.com, corbet@lwn.net
Cc:     rjw@rjwysocki.net, alan@linux.intel.com, lenb@kernel.org,
        prarit@redhat.com, darcari@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 05/10] platform/x86: ISST: Add Intel Speed Select mmio interface
Date:   Wed, 26 Jun 2019 15:38:46 -0700
Message-Id: <20190626223851.19138-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Added MMIO interface to read/write specific offsets in PUNIT PCI device
which export core priortization. This MMIO interface can be used using
ioctl interface on /dev/isst_interface using IOCTL ISST_IF_IO_CMD.

This MMIO interface is used by the intel-speed-select tool under
tools/x86/power to enumerate and set core priority. The MMIO offsets and
semantics of the message can be checked from the source code of the tool.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel_speed_select_if/Makefile        |   1 +
 .../intel_speed_select_if/isst_if_common.c    |   6 +
 .../intel_speed_select_if/isst_if_common.h    |   2 +
 .../x86/intel_speed_select_if/isst_if_mmio.c  | 131 ++++++++++++++++++
 include/uapi/linux/isst_if.h                  |  33 +++++
 5 files changed, 173 insertions(+)
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c

diff --git a/drivers/platform/x86/intel_speed_select_if/Makefile b/drivers/platform/x86/intel_speed_select_if/Makefile
index c12687672fc9..7e94919208d3 100644
--- a/drivers/platform/x86/intel_speed_select_if/Makefile
+++ b/drivers/platform/x86/intel_speed_select_if/Makefile
@@ -5,3 +5,4 @@
 #
 
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_common.o
+obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_mmio.o
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
index 72e74d72724b..3f96a3925bc6 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
@@ -206,6 +206,7 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 {
 	void __user *argp = (void __user *)arg;
 	struct isst_if_cmd_cb cmd_cb;
+	struct isst_if_cmd_cb *cb;
 	long ret = -ENOTTY;
 
 	switch (cmd) {
@@ -218,6 +219,11 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 		cmd_cb.cmd_callback = isst_if_proc_phyid_req;
 		ret = isst_if_exec_multi_cmd(argp, &cmd_cb);
 		break;
+	case ISST_IF_IO_CMD:
+		cb = &punit_callbacks[ISST_IF_DEV_MMIO];
+		if (cb->registered)
+			ret = isst_if_exec_multi_cmd(argp, cb);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
index dade77c58b22..cdc7d019748a 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
@@ -10,6 +10,8 @@
 #ifndef __ISST_IF_COMMON_H
 #define __ISST_IF_COMMON_H
 
+#define INTEL_RAPL_PRIO_DEVID_0	0x3451
+
 /*
  * Validate maximum commands in a single request.
  * This is enough to handle command to every core in one ioctl, or all
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
new file mode 100644
index 000000000000..1c25a1235b9e
--- /dev/null
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Speed Select Interface: MMIO Interface
+ * Copyright (c) 2019, Intel Corporation.
+ * All rights reserved.
+ *
+ * Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/sched/signal.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/isst_if.h>
+
+#include "isst_if_common.h"
+
+struct isst_if_device {
+	void __iomem *punit_mmio;
+	struct mutex mutex;
+};
+
+static long isst_if_mmio_rd_wr(u8 *cmd_ptr, int *write_only, int resume)
+{
+	struct isst_if_device *punit_dev;
+	struct isst_if_io_reg *io_reg;
+	struct pci_dev *pdev;
+
+	io_reg = (struct isst_if_io_reg *)cmd_ptr;
+	if (io_reg->reg < 0x04 || io_reg->reg > 0xD0)
+		return -EINVAL;
+
+	if (io_reg->read_write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	pdev = isst_if_get_pci_dev(io_reg->logical_cpu, 0, 0, 1);
+	if (!pdev)
+		return -EINVAL;
+
+	punit_dev = pci_get_drvdata(pdev);
+	if (!punit_dev)
+		return -EINVAL;
+
+	/*
+	 * Ensure that operation is complete on a PCI device to avoid read
+	 * write race by using per PCI device mutex.
+	 */
+	mutex_lock(&punit_dev->mutex);
+	if (io_reg->read_write) {
+		writel(io_reg->value, punit_dev->punit_mmio+io_reg->reg);
+		*write_only = 1;
+	} else {
+		io_reg->value = readl(punit_dev->punit_mmio+io_reg->reg);
+		*write_only = 0;
+	}
+	mutex_unlock(&punit_dev->mutex);
+
+	return 0;
+}
+
+static const struct pci_device_id isst_if_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_RAPL_PRIO_DEVID_0)},
+	{ 0 },
+};
+MODULE_DEVICE_TABLE(pci, isst_if_ids);
+
+static int isst_if_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct isst_if_device *punit_dev;
+	struct isst_if_cmd_cb cb;
+	u32 mmio_base, pcu_base;
+	u64 base_addr;
+	int ret;
+
+	punit_dev = devm_kzalloc(&pdev->dev, sizeof(*punit_dev), GFP_KERNEL);
+	if (!punit_dev)
+		return -ENOMEM;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pci_read_config_dword(pdev, 0xD0, &mmio_base);
+	if (ret)
+		return ret;
+
+	ret = pci_read_config_dword(pdev, 0xFC, &pcu_base);
+	if (ret)
+		return ret;
+
+	pcu_base &= GENMASK(10, 0);
+	base_addr = (u64)mmio_base << 23 | (u64) pcu_base << 12;
+	punit_dev->punit_mmio = devm_ioremap(&pdev->dev, base_addr, 256);
+	if (!punit_dev->punit_mmio)
+		return -ENOMEM;
+
+	mutex_init(&punit_dev->mutex);
+	pci_set_drvdata(pdev, punit_dev);
+
+	memset(&cb, 0, sizeof(cb));
+	cb.cmd_size = sizeof(struct isst_if_io_reg);
+	cb.offset = offsetof(struct isst_if_io_regs, io_reg);
+	cb.cmd_callback = isst_if_mmio_rd_wr;
+	cb.owner = THIS_MODULE;
+	ret = isst_if_cdev_register(ISST_IF_DEV_MMIO, &cb);
+	if (ret)
+		mutex_destroy(&punit_dev->mutex);
+
+	return ret;
+}
+
+static void isst_if_remove(struct pci_dev *pdev)
+{
+	struct isst_if_device *punit_dev;
+
+	punit_dev = pci_get_drvdata(pdev);
+	isst_if_cdev_unregister(ISST_IF_DEV_MBOX);
+	mutex_destroy(&punit_dev->mutex);
+}
+
+static struct pci_driver isst_if_pci_driver = {
+	.name			= "isst_if_pci",
+	.id_table		= isst_if_ids,
+	.probe			= isst_if_probe,
+	.remove			= isst_if_remove,
+};
+
+module_pci_driver(isst_if_pci_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel speed select interface mmio driver");
diff --git a/include/uapi/linux/isst_if.h b/include/uapi/linux/isst_if.h
index 15d1f286a830..fe2492ade078 100644
--- a/include/uapi/linux/isst_if.h
+++ b/include/uapi/linux/isst_if.h
@@ -63,7 +63,40 @@ struct isst_if_cpu_maps {
 	struct isst_if_cpu_map cpu_map[1];
 };
 
+/**
+ * struct isst_if_io_reg - Read write PUNIT IO register
+ * @read_write:		Value 0: Read, 1: Write
+ * @logical_cpu:	Logical CPU number to get target PCI device.
+ * @reg:		PUNIT register offset
+ * @value:		For write operation value to write and for
+ *			for read placeholder read value
+ *
+ * Structure to specify read/write data to PUNIT registers.
+ */
+struct isst_if_io_reg {
+	__u32 read_write; /* Read:0, Write:1 */
+	__u32 logical_cpu;
+	__u32 reg;
+	__u32 value;
+};
+
+/**
+ * struct isst_if_io_regs - structure for IO register commands
+ * @cmd_count:	Number of io reg commands in io_reg[]
+ * @io_reg[]:	Holds one or more io_reg command structure
+ *
+ * This structure used with ioctl ISST_IF_IO_CMD to send
+ * one or more read/write commands to PUNIT. Here IOCTL return value
+ * indicates number of requests sent or error number if no requests have
+ * been sent.
+ */
+struct isst_if_io_regs {
+	__u32 req_count;
+	struct isst_if_io_reg io_reg[1];
+};
+
 #define ISST_IF_MAGIC			0xFE
 #define ISST_IF_GET_PLATFORM_INFO	_IOR(ISST_IF_MAGIC, 0, struct isst_if_platform_info *)
 #define ISST_IF_GET_PHY_ID		_IOWR(ISST_IF_MAGIC, 1, struct isst_if_cpu_map *)
+#define ISST_IF_IO_CMD		_IOW(ISST_IF_MAGIC, 2, struct isst_if_io_regs *)
 #endif
-- 
2.17.2

