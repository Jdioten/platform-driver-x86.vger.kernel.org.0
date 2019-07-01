Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7AF283FD
	for <lists+platform-driver-x86@lfdr.de>; Thu, 23 May 2019 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfEWQl5 (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Thu, 23 May 2019 12:41:57 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39577 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730893AbfEWQl4 (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Thu, 23 May 2019 12:41:56 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 23 May 2019 19:41:54 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4NGfsQl025062;
        Thu, 23 May 2019 19:41:54 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     dvhart@infradead.org, andy.shevchenko@gmail.com
Cc:     platform-driver-x86@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v1 platform] platform/mellanox: mlxreg-hotplug: Add devm_free_irq call to remove flow
Date:   Thu, 23 May 2019 16:41:52 +0000
Message-Id: <20190523164152.21057-1-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Add devm_free_irq() call to mlxreg-hotplug remove() for clean release
of devices irq resource. Fix debugobjects warning triggered by rmmod
It prevents of use-after-free memory, related to
mlxreg_hotplug_work_handler.

Issue has been reported as debugobjects warning triggered by
'rmmod mlxtreg-hotplug' flow, while running kernel with
CONFIG_DEBUG_OBJECTS* options.

[ 2489.623551] ODEBUG: free active (active state 0) object type: work_struct hint: mlxreg_hotplug_work_handler+0x0/0x7f0 [mlxreg_hotplug]
[ 2489.637097] WARNING: CPU: 5 PID: 3924 at lib/debugobjects.c:328 debug_print_object+0xfe/0x180
[ 2489.637165] RIP: 0010:debug_print_object+0xfe/0x180
?
[ 2489.637214] Call Trace:
[ 2489.637225]  __debug_check_no_obj_freed+0x25e/0x320
[ 2489.637231]  kfree+0x82/0x110
[ 2489.637238]  release_nodes+0x33c/0x4e0
[ 2489.637242]  ? devres_remove_group+0x1b0/0x1b0
[ 2489.637247]  device_release_driver_internal+0x146/0x270
[ 2489.637251]  driver_detach+0x73/0xe0
[ 2489.637254]  bus_remove_driver+0xa1/0x170
[ 2489.637261]  __x64_sys_delete_module+0x29e/0x320
[ 2489.637265]  ? __ia32_sys_delete_module+0x320/0x320
[ 2489.637268]  ? blkcg_exit_queue+0x20/0x20
[ 2489.637273]  ? task_work_run+0x7d/0x100
[ 2489.637278]  ? exit_to_usermode_loop+0x5b/0xf0
[ 2489.637281]  do_syscall_64+0x73/0x160
[ 2489.637287]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2489.637290] RIP: 0033:0x7f95c3596fd7

The difference in release flow with and with no devm_free_irq is listed
below:

bus: 'platform': remove driver mlxreg-hotplug
 mlxreg_hotplug_remove(start)
					-> devm_free_irq (with new code)
 mlxreg_hotplug_remove (end)
 release_nodes (start)
  mlxreg-hotplug: DEVRES REL devm_hwmon_release (8 bytes)
  device: 'hwmon3': device_unregister
  PM: Removing info for No Bus:hwmon3
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (88 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (6 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (5 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (5 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (5 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (5 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (5 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (5 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (5 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (5 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (5 bytes)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (5 bytes)
  mlxreg-hotplug: DEVRES REL devm_irq_release (16 bytes) (no new code)
  mlxreg-hotplug: DEVRES REL devm_kzalloc_release (1376 bytes)
   ------------[ cut here ]------------ (no new code):
   ODEBUG: free active (active state 0) object type: work_struct hint: mlxreg_hotplug_work_handler

 release_nodes(end)
driver: 'mlxreg-hotplug': driver_release

Fixes: 1f976f6978bf ("platform/x86: Move Mellanox platform hotplug driver to platform/mellanox")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index 687ce6817d0d..f85a1b9d129b 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -694,6 +694,7 @@ static int mlxreg_hotplug_remove(struct platform_device *pdev)
 
 	/* Clean interrupts setup. */
 	mlxreg_hotplug_unset_irq(priv);
+	devm_free_irq(&pdev->dev, priv->irq, priv);
 
 	return 0;
 }
-- 
2.11.0

