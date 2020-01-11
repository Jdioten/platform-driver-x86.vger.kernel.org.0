Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687E11381DB
	for <lists+platform-driver-x86@lfdr.de>; Sat, 11 Jan 2020 15:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgAKO51 (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Sat, 11 Jan 2020 09:57:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52956 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730046AbgAKO50 (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Sat, 11 Jan 2020 09:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578754644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVY918Qo8zqs+/9YxsquL9mthkGkrO/QKB0e1ZjhCrY=;
        b=fDdjUG1+La9yX60S8g4gtpJRMjd7gLg2ahSs4PMkbtRDuRzZT/14N/KrYQSbmJFwNtBtdO
        CBHAJFU6ZxpZkuWqzb6HK8peo+E4/OgHyNVTBsIz3J560UsnAWefVqA3wjLKb6HkFVUsdo
        TH+nq2slASPY8etmWTtkGpRPQKARXZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-HGN18lMYMJ6Wyl03EHdHZQ-1; Sat, 11 Jan 2020 09:57:23 -0500
X-MC-Unique: HGN18lMYMJ6Wyl03EHdHZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1196800A02;
        Sat, 11 Jan 2020 14:57:20 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-84.ams2.redhat.com [10.36.116.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E9B987EC6;
        Sat, 11 Jan 2020 14:57:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
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
Subject: [PATCH v11 03/10] firmware: Rename FW_OPT_NOFALLBACK to FW_OPT_NOFALLBACK_SYSFS
Date:   Sat, 11 Jan 2020 15:56:56 +0100
Message-Id: <20200111145703.533809-4-hdegoede@redhat.com>
In-Reply-To: <20200111145703.533809-1-hdegoede@redhat.com>
References: <20200111145703.533809-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

This is a preparation patch for adding a new platform fallback mechanism,
which will have its own enable/disable FW_OPT_xxx option.

Note this also fixes a typo in one of the re-wordwrapped comments:
enfoce -> enforce.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/base/firmware_loader/fallback.c | 11 ++++++-----
 drivers/base/firmware_loader/firmware.h | 16 ++++++++--------
 drivers/base/firmware_loader/main.c     |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmw=
are_loader/fallback.c
index 62ee90b4db56..8704e1bae175 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -606,7 +606,7 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_fla=
gs)
 		return false;
 	}
=20
-	if ((opt_flags & FW_OPT_NOFALLBACK))
+	if ((opt_flags & FW_OPT_NOFALLBACK_SYSFS))
 		return false;
=20
 	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
@@ -630,10 +630,11 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_f=
lags)
  * interface. Userspace is in charge of loading the firmware through the=
 sysfs
  * loading interface. This sysfs fallback mechanism may be disabled comp=
letely
  * on a system by setting the proc sysctl value ignore_sysfs_fallback to=
 true.
- * If this false we check if the internal API caller set the @FW_OPT_NOF=
ALLBACK
- * flag, if so it would also disable the fallback mechanism. A system ma=
y want
- * to enfoce the sysfs fallback mechanism at all times, it can do this b=
y
- * setting ignore_sysfs_fallback to false and force_sysfs_fallback to tr=
ue.
+ * If this is false we check if the internal API caller set the
+ * @FW_OPT_NOFALLBACK_SYSFS flag, if so it would also disable the fallba=
ck
+ * mechanism. A system may want to enforce the sysfs fallback mechanism =
at all
+ * times, it can do this by setting ignore_sysfs_fallback to false and
+ * force_sysfs_fallback to true.
  * Enabling force_sysfs_fallback is functionally equivalent to build a k=
ernel
  * with CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
  **/
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmw=
are_loader/firmware.h
index 7ecd590e67fe..8656e5239a80 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -27,16 +27,16 @@
  *	firmware file lookup on storage is avoided. Used for calls where the
  *	file may be too big, or where the driver takes charge of its own
  *	firmware caching mechanism.
- * @FW_OPT_NOFALLBACK: Disable the fallback mechanism. Takes precedence =
over
- *	&FW_OPT_UEVENT and &FW_OPT_USERHELPER.
+ * @FW_OPT_NOFALLBACK_SYSFS: Disable the sysfs fallback mechanism. Takes
+ *	precedence over &FW_OPT_UEVENT and &FW_OPT_USERHELPER.
  */
 enum fw_opt {
-	FW_OPT_UEVENT =3D         BIT(0),
-	FW_OPT_NOWAIT =3D         BIT(1),
-	FW_OPT_USERHELPER =3D     BIT(2),
-	FW_OPT_NO_WARN =3D        BIT(3),
-	FW_OPT_NOCACHE =3D        BIT(4),
-	FW_OPT_NOFALLBACK =3D     BIT(5),
+	FW_OPT_UEVENT			=3D BIT(0),
+	FW_OPT_NOWAIT			=3D BIT(1),
+	FW_OPT_USERHELPER		=3D BIT(2),
+	FW_OPT_NO_WARN			=3D BIT(3),
+	FW_OPT_NOCACHE			=3D BIT(4),
+	FW_OPT_NOFALLBACK_SYSFS		=3D BIT(5),
 };
=20
 enum fw_status {
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_=
loader/main.c
index 249add8c5e05..57133a9dad09 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -877,7 +877,7 @@ int request_firmware_direct(const struct firmware **f=
irmware_p,
 	__module_get(THIS_MODULE);
 	ret =3D _request_firmware(firmware_p, name, device, NULL, 0,
 				FW_OPT_UEVENT | FW_OPT_NO_WARN |
-				FW_OPT_NOFALLBACK);
+				FW_OPT_NOFALLBACK_SYSFS);
 	module_put(THIS_MODULE);
 	return ret;
 }
--=20
2.24.1

