Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7467E197F3C
	for <lists+platform-driver-x86@lfdr.de>; Mon, 30 Mar 2020 17:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgC3PG2 (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 30 Mar 2020 11:06:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgC3PG2 (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 30 Mar 2020 11:06:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7F1882965E2
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, Collabora Kernel ML <kernel@collabora.com>,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Soller <jeremy@system76.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3] platform: x86: Add ACPI driver for ChromeOS
Date:   Mon, 30 Mar 2020 17:06:17 +0200
Message-Id: <20200330150617.1132570-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

This driver attaches to the ChromeOS ACPI device and then exports the values
reported by the ACPI in a sysfs directory. These values are not exported
via the standard ACPI tables, hence a specific driver is needed to do
it. The ACPI values are presented in the string form (numbers as decimal
values) or binary blobs, and can be accessed as the contents of the
appropriate read only files in the standard ACPI devices sysfs directory tree.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
_Note_ that the entries are still undocumented because I still need to get
the possible entries, as might differ between devices. But, meanwhile
I'd really appreciate some review.

Hi,

I sent the first patch of this three years ago [1], and then, due a lack
of time and a change of priorities I forget about it. Now, I completely
reworked that driver and keep only in this driver the part that is related
to export the sysfs attributes, making it a bit more easy to review,
hopefully I can get your feedback and I'll able to address it now to
finally land this patch.

These properties are used on some userspace tools available in the
ChromeOS userspace like the crash reporter. This driver was tested on a
Samus Chromebook with following data and checking that matches with the
data reported with the downstream driver.

Also installed/removed the driver several times.

 /sys/bus/acpi/devices/GGL0001:00/BINF.2 : 1
 /sys/bus/acpi/devices/GGL0001:00/FMAP : -2031616
 /sys/bus/acpi/devices/GGL0001:00/HWID : SAMUS E25-G7R-W35
 /sys/bus/acpi/devices/GGL0001:00/BINF.0 : 0
 /sys/bus/acpi/devices/GGL0001:00/GPIO.0/GPIO.2 : -1
 /sys/bus/acpi/devices/GGL0001:00/GPIO.0/GPIO.0 : 1
 /sys/bus/acpi/devices/GGL0001:00/GPIO.0/GPIO.3 : INT3437:00
 /sys/bus/acpi/devices/GGL0001:00/GPIO.0/GPIO.1 : 0
 /sys/bus/acpi/devices/GGL0001:00/FRID : Google_Samus.6300.102.0
 /sys/bus/acpi/devices/GGL0001:00/VBNV.0 : 38
 /sys/bus/acpi/devices/GGL0001:00/BINF.3 : 2
 /sys/bus/acpi/devices/GGL0001:00/BINF.1 : 1
 /sys/bus/acpi/devices/GGL0001:00/GPIO.1/GPIO.2 : 16
 /sys/bus/acpi/devices/GGL0001:00/GPIO.1/GPIO.0 : 3
 /sys/bus/acpi/devices/GGL0001:00/GPIO.1/GPIO.3 : INT3437:00
 /sys/bus/acpi/devices/GGL0001:00/GPIO.1/GPIO.1 : 1
 /sys/bus/acpi/devices/GGL0001:00/CHSW : 0
 /sys/bus/acpi/devices/GGL0001:00/FWID : Google_Samus.6300.330.0
 /sys/bus/acpi/devices/GGL0001:00/VBNV.1 : 16
 /sys/bus/acpi/devices/GGL0001:00/BINF.4 : 0

And for binary packages:

cat /sys/bus/acpi/devices/GGL0001:00/MECK | hexdump
 0000000 02fb 8e72 a025 0a73 0f13 095e 9e07 41e6
 0000010 f9e6 bb4e 76cc bef9 cca7 70e2 8f6d 863d
 0000020

cat /sys/bus/acpi/devices/GGL0001:00/VDAT | hexdump
 0000000 6256 4453 0002 0000 0448 0000 0000 0000
 0000010 0c00 0000 0000 0000 0850 0000 0000 0000
 0000020 7c54 0003 0000 0000 0420 0000 0000 0000
 0000030 0408 0000 0000 0000 0007 0000 0000 0000
 0000040 0003 0000 0000 0000 0448 0000 0000 0000
 0000050 0408 0000 0000 0000 9335 1f80 0000 0000
 0000060 69a8 21f3 0000 0000 1d02 21f9 0000 0000
 0000070 ba55 371b 0000 0000 0000 0000 0000 0000
 0000080 bcae 001d 0000 0000 0003 0001 0001 0003
 0000090 000c 0000 0003 0001 0003 0001 0001 0000
 00000a0 0001 0000 0000 0000 cc00 01da 0000 0000
 00000b0 0200 0000 0204 0000 0001 0000 0000 0000
 00000c0 0800 0000 0000 0000 0000 0001 0000 0000
 00000d0 0001 0001 1301 0000 0000 0000 0000 0000
 00000e0 0000 0000 0000 0000 0000 0000 0000 0000
 *

Thanks,
 Enric

[1] https://lkml.org/lkml/2017/7/31/378

Changes in v3:
- Use attribute groups instead of adding files "by hand".
- Add BUILD_TEST to increment build coverage.
- Do not use "raw" kobject to create directories.
- Do not abuse of the platform_device interface. Remove it.

Changes in v2:
- Note that this version is a total rework, with those major changes:
  - Use lists to track dinamically allocated attributes and groups.
  - Use sysfs binary attributes to store the ACPI contents.
  - Remove all the functionalities except the one that creates the sysfs files.

 drivers/platform/x86/Kconfig         |  12 +
 drivers/platform/x86/Makefile        |   1 +
 drivers/platform/x86/chromeos_acpi.c | 517 +++++++++++++++++++++++++++
 3 files changed, 530 insertions(+)
 create mode 100644 drivers/platform/x86/chromeos_acpi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 587403c44598..917a1c1a0758 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -72,6 +72,18 @@ config ACERHDF
 	  If you have an Acer Aspire One netbook, say Y or M
 	  here.
 
+config ACPI_CHROMEOS
+	tristate "ChromeOS specific ACPI extensions"
+	depends on ACPI
+	depends on CHROME_PLATFORMS
+	help
+	  This driver provides the firmware interface for the services
+	  exported through the ChromeOS interfaces when using ChromeOS
+	  ACPI firmware.
+
+	  If you have an ACPI-compatible Chromebook, say Y or M
+	  here.
+
 config ALIENWARE_WMI
 	tristate "Alienware Special feature control"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 3747b1f07cf1..222e2e88ccb8 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_SAMSUNG_Q10)	+= samsung-q10.o
 obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
 obj-$(CONFIG_INTEL_RST)		+= intel-rst.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)	+= intel-smartconnect.o
+obj-$(CONFIG_ACPI_CHROMEOS)	+= chromeos_acpi.o
 
 obj-$(CONFIG_ALIENWARE_WMI)	+= alienware-wmi.o
 obj-$(CONFIG_INTEL_PMC_IPC)	+= intel_pmc_ipc.o
diff --git a/drivers/platform/x86/chromeos_acpi.c b/drivers/platform/x86/chromeos_acpi.c
new file mode 100644
index 000000000000..dc8967281e70
--- /dev/null
+++ b/drivers/platform/x86/chromeos_acpi.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ChromeOS specific ACPI extensions
+ *
+ * Copyright 2011 Google, Inc.
+ * Copyright 2020 Google LLC
+ *
+ * This file is a rework and part of the code is ported from
+ * drivers/platform/x86/chromeos_acpi.c of the chromeos-3.18 kernel and
+ * was originally written by Vadim Bendebury <vbendeb@chromium.org>.
+ *
+ * This driver attaches to the ChromeOS ACPI device and then exports the
+ * values reported by the ACPI in a sysfs directory. All values are
+ * presented in the string form (numbers as decimal values) and can be
+ * accessed as the contents of the appropriate read only files in the
+ * sysfs directory tree.
+ */
+
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+
+/*
+ * ACPI method name for MLST; the response for this method is a package of
+ * strings listing the methods which should be reflected in sysfs.
+ */
+#define MLST "MLST"
+
+/*
+ * The default list of methods the ChromeOS ACPI device is supposed to export,
+ * if the MLST method is not present or is poorly formed.  The MLST method
+ * itself is included, to aid in debugging.
+ */
+static char *chromeos_acpi_default_methods[] = {
+	"CHSW", "HWID", "BINF", "GPIO", "CHNV", "FWID", "FRID", MLST
+};
+
+/*
+ * Representation of a single sysfs attribute. In addition to the standard
+ * bin_attribute structure has a list of these structures (to keep track for
+ * de-allocation when removing the driver) and a pointer to the actual
+ * attribute name and value, reported when accessing the appropriate sysfs
+ * file.
+ */
+struct chromeos_acpi_attribute {
+	struct bin_attribute bin_attr;
+	struct list_head list;
+	char *name;
+	char *data;
+};
+
+/*
+ * Representation of a sysfs attribute group (a sub directory in the device's
+ * sysfs directory). In addition to the standard structure has lists to allow
+ * to keep track of the allocated structures.
+ */
+struct chromeos_acpi_attribute_group {
+	struct attribute_group group;
+	struct list_head attribs;
+	struct list_head list;
+	char *name;
+};
+
+/*
+ * This is the main structure, we use it to store data and adds links pointing
+ * at lists of allocated attributes and attribute groups.
+ */
+struct chromeos_acpi_dev {
+	struct chromeos_acpi_attribute_group *root;
+	const struct attribute_group **dev_groups;
+	struct list_head groups;
+	unsigned int num_groups;
+	unsigned int num_attrs;
+};
+
+static struct chromeos_acpi_dev chromeos_acpi;
+
+static ssize_t chromeos_acpi_read_bin_attribute(struct file *filp,
+						struct kobject *kobj,
+						struct bin_attribute *bin_attr,
+						char *buffer, loff_t pos,
+						size_t count)
+{
+	struct chromeos_acpi_attribute *info = bin_attr->private;
+
+	return memory_read_from_buffer(buffer, count, &pos, info->data,
+				       info->bin_attr.size);
+}
+
+static char *chromeos_acpi_alloc_name(char *name, int count, int index)
+{
+	char *str;
+
+	if (count == 1)
+		str = kstrdup(name, GFP_KERNEL);
+	else
+		str = kasprintf(GFP_KERNEL, "%s.%d", name, index);
+
+	return str;
+}
+
+static int
+chromeos_acpi_add_attr(struct chromeos_acpi_attribute_group *aag,
+		       union acpi_object *element, char *name,
+		       int count, int index)
+{
+	struct chromeos_acpi_attribute *info;
+	char buffer[24]; /* enough to store a u64 and "\n\0" */
+	int length;
+	int ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->name = chromeos_acpi_alloc_name(name, count, index);
+	if (!info->name) {
+		ret = -ENOMEM;
+		goto free_attribute;
+	}
+
+	sysfs_bin_attr_init(&info->bin_attr);
+	info->bin_attr.attr.name = info->name;
+	info->bin_attr.attr.mode = 0444;
+
+	switch (element->type) {
+	case ACPI_TYPE_BUFFER:
+		length = element->buffer.length;
+		info->data = kmemdup(element->buffer.pointer,
+				     length, GFP_KERNEL);
+		break;
+	case ACPI_TYPE_INTEGER:
+		length = snprintf(buffer, sizeof(buffer), "%d",
+				  (int)element->integer.value);
+		info->data = kmemdup(buffer, length, GFP_KERNEL);
+		break;
+	case ACPI_TYPE_STRING:
+		length = element->string.length + 1;
+		info->data = kstrdup(element->string.pointer, GFP_KERNEL);
+		break;
+	default:
+		ret = -EINVAL;
+		goto free_attr_name;
+	}
+
+	if (!info->data) {
+		ret = -ENOMEM;
+		goto free_attr_name;
+	}
+
+	info->bin_attr.size = length;
+	info->bin_attr.read = chromeos_acpi_read_bin_attribute;
+	info->bin_attr.private = info;
+
+	INIT_LIST_HEAD(&info->list);
+
+	list_add(&info->list, &aag->attribs);
+
+	return 0;
+
+free_attr_name:
+	kfree(info->name);
+free_attribute:
+	kfree(info);
+	return ret;
+}
+
+static void
+chromeos_acpi_remove_attribs(struct chromeos_acpi_attribute_group *aag)
+{
+	struct chromeos_acpi_attribute *attr, *tmp_attr;
+
+	list_for_each_entry_safe(attr, tmp_attr, &aag->attribs, list) {
+		kfree(attr->name);
+		kfree(attr->data);
+		kfree(attr);
+	}
+}
+
+static int
+chromeos_acpi_add_attribs_to_group(struct chromeos_acpi_attribute_group *aag,
+				   unsigned int num_attrs)
+{
+	struct chromeos_acpi_attribute *attr;
+	int count = 0;
+
+	aag->group.bin_attrs = kcalloc(num_attrs + 1,
+				       sizeof(*aag->group.bin_attrs),
+				       GFP_KERNEL);
+	if (!aag->group.bin_attrs)
+		return -ENOMEM;
+
+	list_for_each_entry(attr, &aag->attribs, list) {
+		aag->group.bin_attrs[count] = &attr->bin_attr;
+		count++;
+	}
+
+	chromeos_acpi.num_groups++;
+	list_add(&aag->list, &chromeos_acpi.groups);
+
+	return 0;
+}
+
+/**
+ * chromeos_acpi_add_group() - Create a sysfs group including attributes
+ *			       representing a nested ACPI package.
+ *
+ * @adev: ACPI device.
+ * @obj: Package contents as returned by ACPI.
+ * @name: Name of the group.
+ * @num_attrs: Number of attributes of this package.
+ * @index: Index number of this particular group.
+ *
+ * The created group is called @name in case there is a single instance, or
+ * @name.@index otherwise.
+ *
+ * All group and attribute storage allocations are included in the lists for
+ * tracking of allocated memory.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int chromeos_acpi_add_group(struct acpi_device *adev,
+				   union acpi_object *obj, char *name,
+				   int num_attrs, int index)
+{
+	struct chromeos_acpi_attribute_group *aag;
+	union acpi_object *element;
+	int i, count, ret;
+
+	aag = kzalloc(sizeof(*aag), GFP_KERNEL);
+	if (!aag)
+		return -ENOMEM;
+
+	aag->name = chromeos_acpi_alloc_name(name, num_attrs, index);
+	if (!aag->name) {
+		ret = -ENOMEM;
+		goto free_group;
+	}
+
+	INIT_LIST_HEAD(&aag->attribs);
+	INIT_LIST_HEAD(&aag->list);
+
+	count = obj->package.count;
+	element = obj->package.elements;
+	for (i = 0; i < count; i++, element++) {
+		ret = chromeos_acpi_add_attr(aag, element, name, count, i);
+		if (ret)
+			goto free_group_attr;
+	}
+
+	aag->group.name = aag->name;
+
+	ret = chromeos_acpi_add_attribs_to_group(aag, count);
+	if (ret)
+		goto free_group_attr;
+
+	return 0;
+
+free_group_attr:
+	chromeos_acpi_remove_attribs(aag);
+	kfree(aag->name);
+free_group:
+	kfree(aag);
+	return ret;
+}
+
+static void chromeos_acpi_remove_groups(void)
+{
+	struct chromeos_acpi_attribute_group *aag, *tmp_aag;
+
+	list_for_each_entry_safe(aag, tmp_aag, &chromeos_acpi.groups, list) {
+		chromeos_acpi_remove_attribs(aag);
+		kfree(aag->group.bin_attrs);
+		kfree(aag->name);
+		kfree(aag);
+	}
+}
+
+/**
+ * chromeos_acpi_handle_package() - Create sysfs group including attributes
+ *				    representing an ACPI package.
+ *
+ * @adev: ACPI device.
+ * @obj: Package contents as returned by ACPI.
+ * @name: Name of the group.
+ *
+ * Scalar objects included in the package get sysfs attributes created for
+ * them. Nested packages are passed to a function creating a sysfs group per
+ * package.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int chromeos_acpi_handle_package(struct acpi_device *adev,
+					union acpi_object *obj, char *name)
+{
+	struct device *dev = &adev->dev;
+	int count = obj->package.count;
+	union acpi_object *element;
+	int i, ret;
+
+	element = obj->package.elements;
+	for (i = 0; i < count; i++, element++) {
+		if (element->type == ACPI_TYPE_BUFFER ||
+		    element->type == ACPI_TYPE_STRING ||
+		    element->type == ACPI_TYPE_INTEGER) {
+			/* Create a single attribute in the root directory */
+			ret = chromeos_acpi_add_attr(chromeos_acpi.root,
+						     element, name,
+						     count, i);
+			if (ret) {
+				dev_err(dev, "error adding attributes (%d)\n",
+					ret);
+				return ret;
+			}
+			chromeos_acpi.num_attrs++;
+		} else if (element->type == ACPI_TYPE_PACKAGE) {
+			/* Create a group of attributes */
+			ret = chromeos_acpi_add_group(adev, element, name,
+						      count, i);
+			if (ret) {
+				dev_err(dev, "error adding a group (%d)\n",
+					ret);
+				return ret;
+			}
+		} else {
+			if (ret) {
+				dev_err(dev, "error on element type (%d)\n",
+					ret);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * chromeos_acpi_add_method() - Evaluate an ACPI method and create sysfs
+ *				attributes.
+ *
+ * @adev: ACPI device
+ * @name: Name of the method to evaluate
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+static int chromeos_acpi_add_method(struct acpi_device *adev, char *name)
+{
+	struct device *dev = &adev->dev;
+	struct acpi_buffer output;
+	union acpi_object *obj;
+	acpi_status status;
+	int ret = 0;
+
+	output.length = ACPI_ALLOCATE_BUFFER;
+
+	status = acpi_evaluate_object(adev->handle, name, NULL, &output);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "failed to retrieve %s (%d)\n", name, status);
+		return status;
+	}
+
+	obj = output.pointer;
+	if (obj->type == ACPI_TYPE_PACKAGE)
+		ret = chromeos_acpi_handle_package(adev, obj, name);
+
+	kfree(output.pointer);
+
+	return ret;
+}
+
+/**
+ * chromeos_acpi_process_mlst() - Evaluate the MLST method and add methods
+ *				  listed in the response.
+ *
+ * @adev: ACPI device
+ *
+ * Returns: 0 if successful, non-zero if error.
+ */
+static int chromeos_acpi_process_mlst(struct acpi_device *adev)
+{
+	struct chromeos_acpi_attribute_group *aag;
+	char name[ACPI_NAMESEG_SIZE + 1];
+	union acpi_object *element, *obj;
+	struct device *dev = &adev->dev;
+	struct acpi_buffer output;
+	acpi_status status;
+	int ret = 0;
+	int size;
+	int i;
+
+	output.length = ACPI_ALLOCATE_BUFFER;
+	status = acpi_evaluate_object(adev->handle, MLST, NULL,
+				      &output);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	obj = output.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE) {
+		ret = -EINVAL;
+		goto free_acpi_buffer;
+	}
+
+	element = obj->package.elements;
+	for (i = 0; i < obj->package.count; i++, element++) {
+		if (element->type == ACPI_TYPE_STRING) {
+			size = min(element->string.length + 1,
+				   (u32)ACPI_NAMESEG_SIZE + 1);
+			strlcpy(name, element->string.pointer, size);
+			ret = chromeos_acpi_add_method(adev, name);
+			if (ret) {
+				chromeos_acpi_remove_groups();
+				break;
+			}
+		}
+	}
+
+	/* Add attributes to the main group */
+	ret = chromeos_acpi_add_attribs_to_group(chromeos_acpi.root,
+						 chromeos_acpi.num_attrs);
+	if (ret)
+		goto free_acpi_buffer;
+
+	chromeos_acpi.dev_groups = kcalloc(chromeos_acpi.num_groups + 1,
+					   sizeof(struct attribute_group),
+					   GFP_KERNEL);
+
+	i = 0;
+	list_for_each_entry(aag, &chromeos_acpi.groups, list) {
+		chromeos_acpi.dev_groups[i] = &aag->group;
+		i++;
+	}
+
+	ret = sysfs_create_groups(&dev->kobj, chromeos_acpi.dev_groups);
+	if (ret)
+		kfree(chromeos_acpi.dev_groups);
+
+free_acpi_buffer:
+	kfree(output.pointer);
+	return ret;
+}
+
+static int chromeos_acpi_device_add(struct acpi_device *adev)
+{
+	struct chromeos_acpi_attribute_group *aag = chromeos_acpi.root;
+	struct device *dev = &adev->dev;
+	int i, ret;
+
+	aag = kzalloc(sizeof(*aag), GFP_KERNEL);
+	if (!aag)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&aag->attribs);
+	INIT_LIST_HEAD(&aag->list);
+	INIT_LIST_HEAD(&chromeos_acpi.groups);
+
+	chromeos_acpi.root = aag;
+
+	/*
+	 * Attempt to add methods by querying the device's MLST method
+	 * for the list of methods.
+	 */
+	if (!chromeos_acpi_process_mlst(adev))
+		return 0;
+
+	dev_info(dev, "falling back to default list of methods\n");
+
+	for (i = 0; i < ARRAY_SIZE(chromeos_acpi_default_methods); i++) {
+		ret = chromeos_acpi_add_method(adev,
+					     chromeos_acpi_default_methods[i]);
+		if (ret) {
+			dev_err(dev, "failed to add default methods (%d)\n",
+				ret);
+			goto free_group_root;
+		}
+	}
+
+	return 0;
+
+free_group_root:
+	kfree(chromeos_acpi.root);
+	return ret;
+}
+
+static int chromeos_acpi_device_remove(struct acpi_device *adev)
+{
+	/* Remove sysfs groups */
+	sysfs_remove_groups(&adev->dev.kobj, chromeos_acpi.dev_groups);
+	kfree(chromeos_acpi.dev_groups);
+
+	/* Remove allocated chromeos acpi groups and attributes */
+	chromeos_acpi_remove_groups();
+	kfree(chromeos_acpi.root);
+
+	return 0;
+}
+
+static const struct acpi_device_id chromeos_device_ids[] = {
+	{ "GGL0001", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, chromeos_device_ids);
+
+static struct acpi_driver chromeos_acpi_driver = {
+	.name = "chromeos-acpi",
+	.class = "chromeos-acpi",
+	.ids = chromeos_device_ids,
+	.ops = {
+		.add = chromeos_acpi_device_add,
+		.remove = chromeos_acpi_device_remove,
+	},
+};
+module_acpi_driver(chromeos_acpi_driver);
+
+MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ChromeOS specific ACPI extensions");
-- 
2.25.1

