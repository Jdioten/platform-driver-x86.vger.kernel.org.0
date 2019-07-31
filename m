Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D907C1F4
	for <lists+platform-driver-x86@lfdr.de>; Wed, 31 Jul 2019 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfGaMoY (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Wed, 31 Jul 2019 08:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388055AbfGaMoV (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B412089E;
        Wed, 31 Jul 2019 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577060;
        bh=aQIf4vVZX+H6cS8o4sG55uCLuDksr6xmUzh8BYSCx/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZEmMe59qpAGyZT3/9u4H0VSjvaPvJP54cRteRdT7XTTJpNYypcbAFV7wEx9477Av
         mpTUw42pxEjBfOZ5ojr8sGAvvrDKIWEjprJsRm1RtLCCPpad+N7BX4q1v0Pzgqx7Wh
         28FiG7a8kxYf3po7Rd4YR7Oaa8HA6Gl17tZ+DovM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 07/10] platform: x86: hp-wmi: convert platform driver to use dev_groups
Date:   Wed, 31 Jul 2019 14:43:46 +0200
Message-Id: <20190731124349.4474-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124349.4474-1-gregkh@linuxfoundation.org>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a bunch of sysfs files.

Cc: Darren Hart <dvhart@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: platform-driver-x86@vger.kernel.org
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/hp-wmi.c | 47 +++++++++--------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 2521e45280b8..6bcbbb375401 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -502,6 +502,17 @@ static DEVICE_ATTR_RO(dock);
 static DEVICE_ATTR_RO(tablet);
 static DEVICE_ATTR_RW(postcode);
 
+static struct attribute *hp_wmi_attrs[] = {
+	&dev_attr_display.attr,
+	&dev_attr_hddtemp.attr,
+	&dev_attr_als.attr,
+	&dev_attr_dock.attr,
+	&dev_attr_tablet.attr,
+	&dev_attr_postcode.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(hp_wmi);
+
 static void hp_wmi_notify(u32 value, void *context)
 {
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -678,16 +689,6 @@ static void hp_wmi_input_destroy(void)
 	input_unregister_device(hp_wmi_input_dev);
 }
 
-static void cleanup_sysfs(struct platform_device *device)
-{
-	device_remove_file(&device->dev, &dev_attr_display);
-	device_remove_file(&device->dev, &dev_attr_hddtemp);
-	device_remove_file(&device->dev, &dev_attr_als);
-	device_remove_file(&device->dev, &dev_attr_dock);
-	device_remove_file(&device->dev, &dev_attr_tablet);
-	device_remove_file(&device->dev, &dev_attr_postcode);
-}
-
 static int __init hp_wmi_rfkill_setup(struct platform_device *device)
 {
 	int err, wireless;
@@ -858,8 +859,6 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
 
 static int __init hp_wmi_bios_setup(struct platform_device *device)
 {
-	int err;
-
 	/* clear detected rfkill devices */
 	wifi_rfkill = NULL;
 	bluetooth_rfkill = NULL;
@@ -869,35 +868,12 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (hp_wmi_rfkill_setup(device))
 		hp_wmi_rfkill2_setup(device);
 
-	err = device_create_file(&device->dev, &dev_attr_display);
-	if (err)
-		goto add_sysfs_error;
-	err = device_create_file(&device->dev, &dev_attr_hddtemp);
-	if (err)
-		goto add_sysfs_error;
-	err = device_create_file(&device->dev, &dev_attr_als);
-	if (err)
-		goto add_sysfs_error;
-	err = device_create_file(&device->dev, &dev_attr_dock);
-	if (err)
-		goto add_sysfs_error;
-	err = device_create_file(&device->dev, &dev_attr_tablet);
-	if (err)
-		goto add_sysfs_error;
-	err = device_create_file(&device->dev, &dev_attr_postcode);
-	if (err)
-		goto add_sysfs_error;
 	return 0;
-
-add_sysfs_error:
-	cleanup_sysfs(device);
-	return err;
 }
 
 static int __exit hp_wmi_bios_remove(struct platform_device *device)
 {
 	int i;
-	cleanup_sysfs(device);
 
 	for (i = 0; i < rfkill2_count; i++) {
 		rfkill_unregister(rfkill2[i].rfkill);
@@ -966,6 +942,7 @@ static struct platform_driver hp_wmi_driver = {
 	.driver = {
 		.name = "hp-wmi",
 		.pm = &hp_wmi_pm_ops,
+		.dev_groups = hp_wmi_groups,
 	},
 	.remove = __exit_p(hp_wmi_bios_remove),
 };
-- 
2.22.0

