Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97C61C85FE
	for <lists+platform-driver-x86@lfdr.de>; Thu,  7 May 2020 11:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgEGJmt (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Thu, 7 May 2020 05:42:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44438 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgEGJms (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Thu, 7 May 2020 05:42:48 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jWd3G-00022w-5F
        for platform-driver-x86@vger.kernel.org; Thu, 07 May 2020 09:42:46 +0000
Received: by mail-pl1-f199.google.com with SMTP id c13so4650960plq.22
        for <platform-driver-x86@vger.kernel.org>; Thu, 07 May 2020 02:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=2c0eBBtIepmDWT5vtHR8eCLoQ0+DU8y3zdqCJbavP80=;
        b=IMLoYf4JCcFn5UR7lQMmgq+7vNuhsYr+ubVDuinBlgDY9ZxYG07mlTfzA9XOYzGCTR
         BcuxaoE86mtx2SSts3dYh/IPkxEqKg7oKbN9ZsAcg0jYfD2ur5MUdb6850RkVbr9CcrQ
         fD3fLks5701NGucFaxDTaonbPffOhuTsj5I6MH1Ojh7G8vmmqLsdIB0VSVtPIcvQ2lGa
         MQQ02DH/8S5652eSgFgsYErffQbsRsVzlud5OXJe0SwnMkp68KPn8VcuYdiULz3guUPC
         zogwbMiDxf6pWHA4Hx+Qurs6NCeBrnaxNyfC+ff4rTjFANlBV0zZf0Wne7+nI2m2bRvW
         +lCg==
X-Gm-Message-State: AGi0PuatRSZS7GWbNDUknIEHVz5pPbPXraLyj/iYkgJPmfDAVM/++cBp
        y1lcwbgevjeXQoO5aWHCJTMvuKsHS1booZviNymZBXzR1NOJZgFI2QsLyAK2sMzHjHfPJHKw4rS
        a5iCacQ94gPCaj1wu6cNkT6a71vEcMZHe/2o1NX+P+S50thO2ygU=
X-Received: by 2002:a17:90a:3441:: with SMTP id o59mr3759896pjb.185.1588844564678;
        Thu, 07 May 2020 02:42:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypJeLg3AcGy7HrqF6YZ9GdowrY4PLIXUeYZxe5vuntsu3tjrUThWNi8FjX7u4WnCciQkOx+rRg==
X-Received: by 2002:a17:90a:3441:: with SMTP id o59mr3759880pjb.185.1588844564483;
        Thu, 07 May 2020 02:42:44 -0700 (PDT)
Received: from canonical.com (111-249-71-140.dynamic-ip.hinet.net. [111.249.71.140])
        by smtp.gmail.com with ESMTPSA id i190sm4423030pfe.114.2020.05.07.02.42.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2020 02:42:43 -0700 (PDT)
From:   koba.ko@canonical.com
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-laptop: don't register platform::micmute if the related tokens don't exist.
Date:   Thu,  7 May 2020 17:42:42 +0800
Message-Id: <20200507094242.7523-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

From: Koba Ko <koba.ko@canonical.com>

Error messge is issued,
"platform::micmute: Setting an LED's brightness failed (-19)",
Even the device isn't presented.

Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
If one of two tokens doesn't exist, don't register platform::micmute.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/platform/x86/dell-laptop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 1e46022fb2c5..afc1ded83e56 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -2208,10 +2208,13 @@ static int __init dell_init(void)
 
 	dell_laptop_register_notifier(&dell_laptop_notifier);
 
-	micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
-	ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
-	if (ret < 0)
-		goto fail_led;
+	if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
+	    dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
+		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+		ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
+		if (ret < 0)
+			goto fail_led;
+	}
 
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return 0;
-- 
2.17.1

