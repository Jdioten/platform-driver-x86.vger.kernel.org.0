Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF479BF7E5
	for <lists+platform-driver-x86@lfdr.de>; Thu, 26 Sep 2019 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfIZRsa (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Thu, 26 Sep 2019 13:48:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51515 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727727AbfIZRs3 (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Thu, 26 Sep 2019 13:48:29 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 32E6621C7A;
        Thu, 26 Sep 2019 13:48:28 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute1.internal (MEProxy); Thu, 26 Sep 2019 13:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=pQQrrXaEneoyMCg0rYj+V0VGK9/6k
        E/FNx+NR8/YF4s=; b=Yi+lcqpQHixxyw2z5uDxOPirZ0iYZX+Y9JipOrjipLPLA
        SQBF3y4vuLiBcUbmxgiiQgg/m83AVvOrbNFZdhHMUlhohVW/iAbKRYYN9j2rGEm3
        tsjTNd6uo3SutZxPEhMjuvRvE4lteMuJR9wN9DpAa1I6SDXzkYfaf80DUclTufxa
        84e4trk9Kfit9ica8EhTERccZfBsTP9ayuqAKxBC8pYRLDCS5steV021El4JxpEc
        p0rzUKwBwjDalBaZN8od5txEKpcreFuETtqB5la1SHk2VZFg96AjgD5ddXoUeKuL
        4vz1wOiBhiGGi8G4HCU64dbx1H2WWztQbM2z41UqA==
X-ME-Sender: <xms:6_mMXZh7y_iHMKuNnUk67-tJx47qTewplCgYxjgH22kU3NLUMeYtng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrfeeggdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedflfgvrhgvmhihucfuohhllhgvrhdfuceojhgvrhgvmhihsehs
    hihsthgvmhejiedrtghomheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvghrvghmhi
    esshihshhtvghmjeeirdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:6_mMXc07ldEHyHm-tVKx0yHSaaTIKR2CSQjWpTHDTzdzmmxtwWt61g>
    <xmx:6_mMXTwfNKSpSisMXifnLufM0qEoagPLf13s4ngBjoda-VsCPtyrOQ>
    <xmx:6_mMXVWn65DuRWpg7ewLmWqEJhdtOjd5s-C3wCmTLu8cYFwgr_QsEQ>
    <xmx:7PmMXTDx4tfy3SEgcELUOfjMC7_Qkm-tSe0zQbWpMvah46yHuzR_kg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C259FE00BC; Thu, 26 Sep 2019 13:48:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-305-g4111847-fmstable-20190924v1
Mime-Version: 1.0
Message-Id: <957bc038-c2d7-4ffb-a209-a4b8dfe95454@www.fastmail.com>
Date:   Thu, 26 Sep 2019 11:47:56 -0600
From:   "Jeremy Soller" <jeremy@system76.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     productdev@system76.com
Subject: platform/x86: system76_acpi: Add System76 ACPI driver
Content-Type: text/plain
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Add System76 ACPI driver, which allows for control of keyboard backlight and airplane mode LED on System76 machines running open firmware.

Signed-off-by: Jeremy Soller <jeremy@system76.com>
Cc: platform-driver-x86@vger.kernel.org
---
 MAINTAINERS                          |   7 +
 drivers/platform/x86/Kconfig         |  13 ++
 drivers/platform/x86/Makefile        |   1 +
 drivers/platform/x86/system76_acpi.c | 385 +++++++++++++++++++++++++++++++++++
 4 files changed, 406 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a97f1be63b9d..6be3944b1b2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15745,6 +15745,13 @@ F:	drivers/hwtracing/stm/
 F:	include/linux/stm.h
 F:	include/uapi/linux/stm.h
 
+SYSTEM76 ACPI DRIVER
+M:	Jeremy Soller <jeremy@system76.com>
+M:	System76 Product Development <productdev@system76.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/system76_acpi.c
+
 SYSV FILESYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
 S:	Maintained
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ae21d08c65e8..b880b051e3e8 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1337,6 +1337,19 @@ config PCENGINES_APU2
 
 source "drivers/platform/x86/intel_speed_select_if/Kconfig"
 
+config SYSTEM76_ACPI
+	tristate "System76 ACPI Driver"
+	depends on ACPI
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_TRIGGERS
+	help
+	  This is a driver for System76 laptops running open firmware. It adds
+	  support for Fn-Fx key combinations, keyboard backlight, and airplane mode
+	  LEDs.
+
+	  If you have a System76 laptop running open firmware, say Y or M here.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 415104033060..92ce1d87c4cb 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -100,3 +100,4 @@ obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
 obj-$(CONFIG_INTEL_ATOMISP2_PM)	+= intel_atomisp2_pm.o
 obj-$(CONFIG_PCENGINES_APU2)	+= pcengines-apuv2.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += intel_speed_select_if/
+obj-$(CONFIG_SYSTEM76_ACPI)	+= system76_acpi.o
diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
new file mode 100644
index 000000000000..e9f4262812d0
--- /dev/null
+++ b/drivers/platform/x86/system76_acpi.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * System76 ACPI Driver
+ *
+ * Copyright (C) 2019 System76
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/pci_ids.h>
+#include <linux/types.h>
+
+struct system76_data {
+	struct acpi_device *acpi_dev;
+	struct led_classdev ap_led;
+	struct led_classdev kb_led;
+	enum led_brightness kb_brightness;
+	enum led_brightness kb_toggle_brightness;
+	int kb_color;
+};
+
+static const struct acpi_device_id device_ids[] = {
+	{"17761776", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, device_ids);
+
+// Array of keyboard LED brightness levels
+static const enum led_brightness kb_levels[] = {
+	48,
+	72,
+	96,
+	144,
+	192,
+	255
+};
+
+// Array of keyboard LED colors in 24-bit RGB format
+static const int kb_colors[] = {
+	0xFFFFFF,
+	0x0000FF,
+	0xFF0000,
+	0xFF00FF,
+	0x00FF00,
+	0x00FFFF,
+	0xFFFF00
+};
+
+// Get a System76 ACPI device value by name
+static int system76_get(struct system76_data *data, char *method)
+{
+	acpi_handle handle;
+	acpi_status status;
+	unsigned long long ret = 0;
+
+	handle = acpi_device_handle(data->acpi_dev);
+	status = acpi_evaluate_integer(handle, method, NULL, &ret);
+	if (ACPI_SUCCESS(status))
+		return (int)ret;
+	else
+		return -1;
+}
+
+// Set a System76 ACPI device value by name
+static int system76_set(struct system76_data *data, char *method, int value)
+{
+	union acpi_object obj;
+	struct acpi_object_list obj_list;
+	acpi_handle handle;
+	acpi_status status;
+
+	obj.type = ACPI_TYPE_INTEGER;
+	obj.integer.value = value;
+	obj_list.count = 1;
+	obj_list.pointer = &obj;
+	handle = acpi_device_handle(data->acpi_dev);
+	status = acpi_evaluate_object(handle, method, &obj_list, NULL);
+	if (ACPI_SUCCESS(status))
+		return 0;
+	else
+		return -1;
+}
+
+// Get the airplane mode LED brightness
+static enum led_brightness ap_led_get(struct led_classdev *led)
+{
+	struct system76_data *data;
+	int value;
+
+	data = container_of(led, struct system76_data, ap_led);
+	value = system76_get(data, "GAPL");
+	if (value > 0)
+		return (enum led_brightness)value;
+	else
+		return LED_OFF;
+}
+
+// Set the airplane mode LED brightness
+static void ap_led_set(struct led_classdev *led, enum led_brightness value)
+{
+	struct system76_data *data;
+
+	data = container_of(led, struct system76_data, ap_led);
+	system76_set(data, "SAPL", value == LED_OFF ? 0 : 1);
+}
+
+// Get the last set keyboard LED brightness
+static enum led_brightness kb_led_get(struct led_classdev *led)
+{
+	struct system76_data *data;
+
+	data = container_of(led, struct system76_data, kb_led);
+	return data->kb_brightness;
+}
+
+// Set the keyboard LED brightness
+static void kb_led_set(struct led_classdev *led, enum led_brightness value)
+{
+	struct system76_data *data;
+
+	data = container_of(led, struct system76_data, kb_led);
+	data->kb_brightness = value;
+	system76_set(data, "SKBL", (int)data->kb_brightness);
+}
+
+// Get the last set keyboard LED color
+static ssize_t kb_led_color_show(
+	struct device *dev,
+	struct device_attribute *dev_attr,
+	char *buf)
+{
+	struct led_classdev *led;
+	struct system76_data *data;
+
+	led = (struct led_classdev *)dev->driver_data;
+	data = container_of(led, struct system76_data, kb_led);
+	return sprintf(buf, "%06X\n", data->kb_color);
+}
+
+// Set the keyboard LED color
+static ssize_t kb_led_color_store(
+	struct device *dev,
+	struct device_attribute *dev_attr,
+	const char *buf,
+	size_t size)
+{
+	struct led_classdev *led;
+	struct system76_data *data;
+	unsigned int val;
+	int ret;
+
+	led = (struct led_classdev *)dev->driver_data;
+	data = container_of(led, struct system76_data, kb_led);
+	ret = kstrtouint(buf, 16, &val);
+	if (ret)
+		return ret;
+	if (val > 0xFFFFFF)
+		return -EINVAL;
+	data->kb_color = (int)val;
+	system76_set(data, "SKBC", data->kb_color);
+
+	return size;
+}
+
+static const struct device_attribute kb_led_color_dev_attr = {
+	.attr = {
+		.name = "color",
+		.mode = 0644,
+	},
+	.show = kb_led_color_show,
+	.store = kb_led_color_store,
+};
+
+// Notify that the keyboard LED was changed by hardware
+static void kb_led_notify(struct system76_data *data)
+{
+	led_classdev_notify_brightness_hw_changed(
+		&data->kb_led,
+		data->kb_brightness
+	);
+}
+
+// Read keyboard LED brightness as set by hardware
+static void kb_led_hotkey_hardware(struct system76_data *data)
+{
+	int value;
+
+	value = system76_get(data, "GKBL");
+	if (value < 0)
+		return;
+	data->kb_brightness = value;
+	kb_led_notify(data);
+}
+
+// Toggle the keyboard LED
+static void kb_led_hotkey_toggle(struct system76_data *data)
+{
+	if (data->kb_brightness > 0) {
+		data->kb_toggle_brightness = data->kb_brightness;
+		kb_led_set(&data->kb_led, 0);
+	} else {
+		kb_led_set(&data->kb_led, data->kb_toggle_brightness);
+	}
+	kb_led_notify(data);
+}
+
+// Decrease the keyboard LED brightness
+static void kb_led_hotkey_down(struct system76_data *data)
+{
+	int i;
+
+	if (data->kb_brightness > 0) {
+		for (i = ARRAY_SIZE(kb_levels); i > 0; i--) {
+			if (kb_levels[i - 1] < data->kb_brightness) {
+				kb_led_set(&data->kb_led, kb_levels[i - 1]);
+				break;
+			}
+		}
+	} else {
+		kb_led_set(&data->kb_led, data->kb_toggle_brightness);
+	}
+	kb_led_notify(data);
+}
+
+// Increase the keyboard LED brightness
+static void kb_led_hotkey_up(struct system76_data *data)
+{
+	int i;
+
+	if (data->kb_brightness > 0) {
+		for (i = 0; i < ARRAY_SIZE(kb_levels); i++) {
+			if (kb_levels[i] > data->kb_brightness) {
+				kb_led_set(&data->kb_led, kb_levels[i]);
+				break;
+			}
+		}
+	} else {
+		kb_led_set(&data->kb_led, data->kb_toggle_brightness);
+	}
+	kb_led_notify(data);
+}
+
+// Cycle the keyboard LED color
+static void kb_led_hotkey_color(struct system76_data *data)
+{
+	int i;
+
+	if (data->kb_color < 0)
+		return;
+	if (data->kb_brightness > 0) {
+		for (i = 0; i < ARRAY_SIZE(kb_colors); i++) {
+			if (kb_colors[i] == data->kb_color)
+				break;
+		}
+		i += 1;
+		if (i >= ARRAY_SIZE(kb_colors))
+			i = 0;
+		data->kb_color = kb_colors[i];
+		system76_set(data, "SKBC", data->kb_color);
+	} else {
+		kb_led_set(&data->kb_led, data->kb_toggle_brightness);
+	}
+	kb_led_notify(data);
+}
+
+// Handle ACPI notification
+static void system76_notify(struct acpi_device *acpi_dev, u32 event)
+{
+	struct system76_data *data;
+	int i;
+
+	data = acpi_driver_data(acpi_dev);
+	switch (event) {
+	case 0x80:
+		kb_led_hotkey_hardware(data);
+		break;
+	case 0x81:
+		kb_led_hotkey_toggle(data);
+		break;
+	case 0x82:
+		kb_led_hotkey_down(data);
+		break;
+	case 0x83:
+		kb_led_hotkey_up(data);
+		break;
+	case 0x84:
+		kb_led_hotkey_color(data);
+		break;
+	}
+}
+
+// Add a System76 ACPI device
+static int system76_add(struct acpi_device *acpi_dev)
+{
+	struct system76_data *data;
+	int err;
+
+	data = devm_kzalloc(&acpi_dev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	acpi_dev->driver_data = data;
+	data->acpi_dev = acpi_dev;
+
+	err = system76_get(data, "INIT");
+	if (err)
+		return err;
+	data->ap_led.name = "system76_acpi::airplane";
+	data->ap_led.flags = LED_CORE_SUSPENDRESUME;
+	data->ap_led.brightness_get = ap_led_get;
+	data->ap_led.brightness_set = ap_led_set;
+	data->ap_led.max_brightness = 1;
+	data->ap_led.default_trigger = "rfkill-none";
+	err = devm_led_classdev_register(&acpi_dev->dev, &data->ap_led);
+	if (err)
+		return err;
+
+	data->kb_led.name = "system76_acpi::kbd_backlight";
+	data->kb_led.flags = LED_BRIGHT_HW_CHANGED | LED_CORE_SUSPENDRESUME;
+	data->kb_led.brightness_get = kb_led_get;
+	data->kb_led.brightness_set = kb_led_set;
+	if (acpi_has_method(acpi_device_handle(data->acpi_dev), "SKBC")) {
+		data->kb_led.max_brightness = 255;
+		data->kb_toggle_brightness = 72;
+		data->kb_color = 0xffffff;
+		system76_set(data, "SKBC", data->kb_color);
+	} else {
+		data->kb_led.max_brightness = 5;
+		data->kb_color = -1;
+	}
+	err = devm_led_classdev_register(&acpi_dev->dev, &data->kb_led);
+	if (err)
+		return err;
+
+	if (data->kb_color >= 0) {
+		err = device_create_file(
+			data->kb_led.dev,
+			&kb_led_color_dev_attr
+		);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+// Remove a System76 ACPI device
+static int system76_remove(struct acpi_device *acpi_dev)
+{
+	struct system76_data *data;
+
+	data = acpi_driver_data(acpi_dev);
+	if (data->kb_color >= 0)
+		device_remove_file(data->kb_led.dev, &kb_led_color_dev_attr);
+
+	devm_led_classdev_unregister(&acpi_dev->dev, &data->ap_led);
+
+	devm_led_classdev_unregister(&acpi_dev->dev, &data->kb_led);
+
+	system76_get(data, "FINI");
+
+	return 0;
+}
+
+static struct acpi_driver system76_driver = {
+	.name = "System76 ACPI Driver",
+	.class = "hotkey",
+	.ids = device_ids,
+	.ops = {
+		.add = system76_add,
+		.remove = system76_remove,
+		.notify = system76_notify,
+	},
+};
+module_acpi_driver(system76_driver);
+
+MODULE_DESCRIPTION("System76 ACPI Driver");
+MODULE_AUTHOR("Jeremy Soller <jeremy@system76.com>");
+MODULE_LICENSE("GPL");
