Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0213CBDFB
	for <lists+platform-driver-x86@lfdr.de>; Fri,  4 Oct 2019 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389316AbfJDOvj (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Fri, 4 Oct 2019 10:51:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389086AbfJDOvj (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Fri, 4 Oct 2019 10:51:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53E60806CE;
        Fri,  4 Oct 2019 14:51:38 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 140B05C226;
        Fri,  4 Oct 2019 14:51:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v7 4/8] firmware: Add new platform fallback mechanism and firmware_request_platform()
Date:   Fri,  4 Oct 2019 16:50:52 +0200
Message-Id: <20191004145056.43267-5-hdegoede@redhat.com>
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 04 Oct 2019 14:51:38 +0000 (UTC)
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

In some cases the platform's main firmware (e.g. the UEFI fw) may contain
an embedded copy of device firmware which needs to be (re)loaded into the
peripheral. Normally such firmware would be part of linux-firmware, but in
some cases this is not feasible, for 2 reasons:

1) The firmware is customized for a specific use-case of the chipset / use
with a specific hardware model, so we cannot have a single firmware file
for the chipset. E.g. touchscreen controller firmwares are compiled
specifically for the hardware model they are used with, as they are
calibrated for a specific model digitizer.

2) Despite repeated attempts we have failed to get permission to
redistribute the firmware. This is especially a problem with customized
firmwares, these get created by the chip vendor for a specific ODM and the
copyright may partially belong with the ODM, so the chip vendor cannot
give a blanket permission to distribute these.

This commit adds a new platform fallback mechanism to the firmware loader
which will try to lookup a device fw copy embedded in the platform's main
firmware if direct filesystem lookup fails.

Drivers which need such embedded fw copies can enable this fallback
mechanism by using the new firmware_request_platform() function.

Note that for now this is only supported on EFI platforms and even on
these platforms firmware_fallback_platform() only works if
CONFIG_EFI_EMBEDDED_FIRMWARE is enabled (this gets selected by drivers
which need this), in all other cases firmware_fallback_platform() simply
always returns -ENOENT.

Reported-by: Dave Olsthoorn <dave@bewaar.me>
Suggested-by: Peter Jones <pjones@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v7:
- Split drivers/firmware/efi and drivers/base/firmware_loader changes into
  2 patches
- Address kdoc comments from Randy Dunlap
- Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
  _request_firmware() wrapper, as requested by Luis R. Rodriguez
- Stop using "efi-embedded-firmware" device-property, now that drivers need to
  use the new firmware_request_platform() to enable fallback to a device fw
  copy embedded in the platform's main firmware, we no longer need a property
  on the device to trigger this behavior
- Use security_kernel_load_data instead of calling
  security_kernel_read_file with a NULL file pointer argument
- Move the docs to Documentation/driver-api/firmware/fallback-mechanisms.rst
- Document the new firmware_request_platform() function in
  Documentation/driver-api/firmware/request_firmware.rst

Changes in v6:
- Rework code to remove casts from if (prefix == mem) comparison
- Use SHA256 hashes instead of crc32 sums
- Add new READING_FIRMWARE_EFI_EMBEDDED read_file_id and use it
- Call security_kernel_read_file(NULL, READING_FIRMWARE_EFI_EMBEDDED)
  to check if this is allowed before looking at EFI embedded fw
- Document why we are not using the UEFI PI Firmware Volume protocol

Changes in v5:
- Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS

Changes in v4:
- Drop note in docs about EFI_FIRMWARE_VOLUME_PROTOCOL, it is not part of
  UEFI proper, so the EFI maintainers don't want us referring people to it
- Use new EFI_BOOT_SERVICES flag
- Put the new fw_get_efi_embedded_fw() function in its own fallback_efi.c
  file which only gets built when EFI_EMBEDDED_FIRMWARE is selected
- Define an empty stub for fw_get_efi_embedded_fw() in fallback.h hwen
  EFI_EMBEDDED_FIRMWARE is not selected, to avoid the need for #ifdefs
  in firmware_loader/main.c
- Properly call security_kernel_post_read_file() on the firmware returned
  by efi_get_embedded_fw() to make sure that we are allowed to use it

Changes in v3:
- Fix the docs using "efi-embedded-fw" as property name instead of
  "efi-embedded-firmware"

Changes in v2:
- Rebased on driver-core/driver-core-next
- Add documentation describing the EFI embedded firmware mechanism to:
  Documentation/driver-api/firmware/request_firmware.rst
- Add a new EFI_EMBEDDED_FIRMWARE Kconfig bool and only build the embedded
  fw support if this is set. This is an invisible option which should be
  selected by drivers which need this
- Remove the efi_embedded_fw_desc and dmi_system_id-s for known devices
  from the efi-embedded-fw code, instead drivers using this are expected to
  export a dmi_system_id array, with each entries' driver_data pointing to a
  efi_embedded_fw_desc struct and register this with the efi-embedded-fw code
- Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmware,
  this avoids us messing with the EFI memmap and avoids the need to make
  changes to efi_mem_desc_lookup()
- Make the firmware-loader code only fallback to efi_get_embedded_fw() if the
  passed in device has the "efi-embedded-firmware" device-property bool set
- Skip usermodehelper fallback when "efi-embedded-firmware" device-property
  is set
---
 .../firmware/fallback-mechanisms.rst          | 71 +++++++++++++++++++
 .../driver-api/firmware/lookup-order.rst      |  2 +
 .../driver-api/firmware/request_firmware.rst  |  5 ++
 drivers/base/firmware_loader/Makefile         |  2 +-
 drivers/base/firmware_loader/fallback.h       |  2 +
 .../base/firmware_loader/fallback_platform.c  | 33 +++++++++
 drivers/base/firmware_loader/firmware.h       |  4 ++
 drivers/base/firmware_loader/main.c           | 27 +++++++
 include/linux/firmware.h                      |  2 +
 include/linux/fs.h                            |  1 +
 10 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/firmware_loader/fallback_platform.c

diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
index 8b041d0ab426..954a6b0ded40 100644
--- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -202,3 +202,74 @@ the following file:
 
 If you echo 0 into it means MAX_JIFFY_OFFSET will be used. The data type
 for the timeout is an int.
+
+EFI embedded firmware fallback mechanism
+========================================
+
+On some devices the system's EFI code / ROM may contain an embedded copy
+of firmware for some of the system's integrated peripheral devices and
+the peripheral's Linux device-driver needs to access this firmware.
+
+Device drivers which need such firmware can use the
+firmware_request_platform() function for this, note that this is a
+separate fallback mechanism from the other fallback mechanisms and
+this does not use the sysfs interface.
+
+A device driver which needs this can describe the firmware it needs
+using an efi_embedded_fw_desc struct:
+
+.. kernel-doc:: include/linux/efi_embedded_fw.h
+   :functions: efi_embedded_fw_desc
+
+The EFI embedded-fw code works by scanning all EFI_BOOT_SERVICES_CODE memory
+segments for an eight byte sequence matching prefix; if the prefix is found it
+then does a sha256 over length bytes and if that matches makes a copy of length
+bytes and adds that to its list with found firmwares.
+
+To avoid doing this somewhat expensive scan on all systems, dmi matching is
+used. Drivers are expected to export a dmi_system_id array, with each entries'
+driver_data pointing to an efi_embedded_fw_desc.
+
+To register this array with the efi-embedded-fw code, a driver needs to:
+
+1. Always be builtin to the kernel or store the dmi_system_id array in a
+   separate object file which always gets builtin.
+
+2. Add an extern declaration for the dmi_system_id array to
+   include/linux/efi_embedded_fw.h.
+
+3. Add the dmi_system_id array to the embedded_fw_table in
+   drivers/firmware/efi/embedded-firmware.c wrapped in a #ifdef testing that
+   the driver is being builtin.
+
+4. Add "select EFI_EMBEDDED_FIRMWARE if EFI_STUB" to its Kconfig entry.
+
+The firmware_request_platform() function will always first try to load firmware
+with the specified name directly from the disk, so the EFI embedded-fw can
+always be overridden by placing a file under /lib/firmware.
+
+Note that:
+
+1. The code scanning for EFI embedded-firmware runs near the end
+   of start_kernel(), just before calling rest_init(). For normal drivers and
+   subsystems using subsys_initcall() to register themselves this does not
+   matter. This means that code running earlier cannot use EFI
+   embedded-firmware.
+
+2. At the moment the EFI embedded-fw code assumes that firmwares always start at
+   an offset which is a multiple of 8 bytes, if this is not true for your case
+   send in a patch to fix this.
+
+3. At the moment the EFI embedded-fw code only works on x86 because other archs
+   free EFI_BOOT_SERVICES_CODE before the EFI embedded-fw code gets a chance to
+   scan it.
+
+4. The current brute-force scanning of EFI_BOOT_SERVICES_CODE is an ad-hoc
+   brute-force solution. There has been discussion to use the UEFI Platform
+   Initialization (PI) spec's Firmware Volume protocol. This has been rejected
+   because the FV Protocol relies on *internal* interfaces of the PI spec, and:
+   1. The PI spec does not define peripheral firmware at all
+   2. The internal interfaces of the PI spec does not guarantee any backward
+   compatibility. Any implementation details in FV may be subject to change,
+   and may vary system to system. Supporting the FV Protocol would be
+   difficult as it is purposely ambiguous.
diff --git a/Documentation/driver-api/firmware/lookup-order.rst b/Documentation/driver-api/firmware/lookup-order.rst
index 88c81739683c..6064672a782e 100644
--- a/Documentation/driver-api/firmware/lookup-order.rst
+++ b/Documentation/driver-api/firmware/lookup-order.rst
@@ -12,6 +12,8 @@ a driver issues a firmware API call.
   return it immediately
 * The ''Direct filesystem lookup'' is performed next, if found we
   return it immediately
+* The ''Platform firmware fallback'' is performed next, but only when
+  firmware_request_platform() is used, if found we return it immediately
 * If no firmware has been found and the fallback mechanism was enabled
   the sysfs interface is created. After this either a kobject uevent
   is issued or the custom firmware loading is relied upon for firmware
diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index f62bdcbfed5b..cd076462d235 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -25,6 +25,11 @@ firmware_request_nowarn
 .. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: firmware_request_nowarn
 
+firmware_request_platform
+-------------------------
+.. kernel-doc:: drivers/base/firmware_loader/main.c
+   :functions: firmware_request_platform
+
 request_firmware_direct
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_loader/Makefile
index 0b2dfa6259c9..fec75895faae 100644
--- a/drivers/base/firmware_loader/Makefile
+++ b/drivers/base/firmware_loader/Makefile
@@ -3,7 +3,7 @@
 
 obj-$(CONFIG_FW_LOADER_USER_HELPER) += fallback_table.o
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
-firmware_class-objs := main.o
+firmware_class-objs := main.o fallback_platform.o
 firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) += fallback.o
 
 obj-y += builtin/
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index 21063503e4ea..c4350f2e7cc2 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -66,4 +66,6 @@ static inline void unregister_sysfs_loader(void)
 }
 #endif /* CONFIG_FW_LOADER_USER_HELPER */
 
+int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt_flags);
+
 #endif /* __FIRMWARE_FALLBACK_H */
diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
new file mode 100644
index 000000000000..7e9d730e36bf
--- /dev/null
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi_embedded_fw.h>
+#include <linux/property.h>
+#include <linux/security.h>
+#include <linux/vmalloc.h>
+
+#include "fallback.h"
+#include "firmware.h"
+
+int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt_flags)
+{
+#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
+	int rc;
+
+	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
+		return -ENOENT;
+
+	rc = security_kernel_load_data(LOADING_FIRMWARE_EFI_EMBEDDED);
+	if (rc)
+		return rc;
+
+	rc = efi_get_embedded_fw(fw_priv->fw_name, &fw_priv->data,
+				 &fw_priv->size);
+	if (rc)
+		return rc; /* rc == -ENOENT when the fw was not found */
+
+	fw_state_done(fw_priv);
+	return 0;
+#else
+	return -ENOENT;
+#endif
+}
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 8656e5239a80..25836a6afc9f 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -29,6 +29,9 @@
  *	firmware caching mechanism.
  * @FW_OPT_NOFALLBACK_SYSFS: Disable the sysfs fallback mechanism. Takes
  *	precedence over &FW_OPT_UEVENT and &FW_OPT_USERHELPER.
+ * @FW_OPT_FALLBACK_PLATFORM: Enable fallback to device fw copy embedded in
+ *	the platform's main firmware. If both this fallback and the sysfs
+ *      fallback are enabled, then this fallback will be tried first.
  */
 enum fw_opt {
 	FW_OPT_UEVENT			= BIT(0),
@@ -37,6 +40,7 @@ enum fw_opt {
 	FW_OPT_NO_WARN			= BIT(3),
 	FW_OPT_NOCACHE			= BIT(4),
 	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
+	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
 };
 
 enum fw_status {
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 08f8995a530a..006ff71458b1 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -775,6 +775,9 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 						 fw_decompress_xz);
 #endif
 
+	if (ret == -ENOENT)
+		ret = firmware_fallback_platform(fw->priv, opt_flags);
+
 	if (ret) {
 		if (!(opt_flags & FW_OPT_NO_WARN))
 			dev_warn(device,
@@ -882,6 +885,30 @@ int request_firmware_direct(const struct firmware **firmware_p,
 }
 EXPORT_SYMBOL_GPL(request_firmware_direct);
 
+/**
+ * firmware_request_platform() - request firmware with platform-fw fallback
+ * @firmware: pointer to firmware image
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded
+ *
+ * This function is similar in behaviour to request_firmware, except that if
+ * direct filesystem lookup fails, it will fallback to looking for a copy of the
+ * requested firmware embedded in the platform's main (e.g. UEFI) firmware.
+ **/
+int firmware_request_platform(const struct firmware **firmware,
+			      const char *name, struct device *device)
+{
+	int ret;
+
+	/* Need to pin this module until return */
+	__module_get(THIS_MODULE);
+	ret = _request_firmware(firmware, name, device, NULL, 0,
+				FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
+	module_put(THIS_MODULE);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(firmware_request_platform);
+
 /**
  * firmware_request_cache() - cache firmware for suspend so resume can use it
  * @name: name of firmware file
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 2dd566c91d44..75dbec0bcc06 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -44,6 +44,8 @@ int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
 int firmware_request_nowarn(const struct firmware **fw, const char *name,
 			    struct device *device);
+int firmware_request_platform(const struct firmware **fw, const char *name,
+			      struct device *device);
 int request_firmware_nowait(
 	struct module *module, bool uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..3cbc955f6a1a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2961,6 +2961,7 @@ extern int do_pipe_flags(int *, int);
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
 	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
+	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-- 
2.23.0

