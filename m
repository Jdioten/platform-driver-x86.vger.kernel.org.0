Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E991CCF14
	for <lists+platform-driver-x86@lfdr.de>; Mon, 11 May 2020 03:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgEKBQL (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Sun, 10 May 2020 21:16:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49550 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgEKBQK (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Sun, 10 May 2020 21:16:10 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1jXx3A-0004k1-56
        for platform-driver-x86@vger.kernel.org; Mon, 11 May 2020 01:16:08 +0000
Received: by mail-pg1-f198.google.com with SMTP id g11so6483224pgd.20
        for <platform-driver-x86@vger.kernel.org>; Sun, 10 May 2020 18:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=npzJ2ssQsHpN36Phgsl48fh9Ati/w9bnMfzts9WzPbU=;
        b=e07NicbCbkbWMuGDiwqjT4B/S/rNRHuCem0l+MJwy1+rYGQVsdZsdyPLXNbor1a0X7
         zQ2iqP/64eA4A6vmgiah7we2+ExUkFcNYcucvmyJxenAVvLuDBMbK7FGsvY3V1ZHkeAx
         tqaoSMH3qZh/yp6taF+y4js9wj9AnMzjhmxIN5CD6IqqfTVkrYnJPfMxGqH9Zf4OggFy
         HtceEXFSqgJZyvCrTH6SiRnkiDD7zreYH7tnxYvYJq9gbrhEoncnu5gW7RE0+Ik0ppUw
         v9e0w5IX9USELVf0l4gqyjE4UEzzAsmPRVOi/jcnHjhltd181RpTXo4MJKU2o35UWgf9
         +uLg==
X-Gm-Message-State: AGi0PubzPUI3EBUIizyTMLQ/SpWNh6glUu7V2DbXx2SIlCqeAi20THBX
        qUY4jTjS/kqBnWTk+Cf9FBwXDfgy0HFB6TOY3E5mMRWyTqyecMunyw09YdZKgoSOM8Jd0SJL+d8
        8ituUVOQhrclxtq1L0EzlXSGl3RKTGA1i2gheUFI9q1xaK5gM0Lg=
X-Received: by 2002:a17:902:6114:: with SMTP id t20mr13273901plj.324.1589159766647;
        Sun, 10 May 2020 18:16:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypJGi34Y7+bcHYm0CJ9vm2SKrXWsH/PUviBBdaQ8jLAip9Hqej9PLKvFL95Z95aS1Ec7YYUrLg==
X-Received: by 2002:a17:902:6114:: with SMTP id t20mr13273867plj.324.1589159766166;
        Sun, 10 May 2020 18:16:06 -0700 (PDT)
Received: from canonical.com (111-249-68-192.dynamic-ip.hinet.net. [111.249.68.192])
        by smtp.gmail.com with ESMTPSA id y8sm7887771pfg.216.2020.05.10.18.16.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 May 2020 18:16:05 -0700 (PDT)
From:   koba.ko@canonical.com
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario.Limonciello@dell.com
Subject: [PATCH] platform/x86: dell-laptop: don't register platform::micmute if the related tokens don't exist.
Date:   Mon, 11 May 2020 09:16:03 +0800
Message-Id: <20200511011603.4278-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

From: Koba Ko <koba.ko@canonical.com>

On dell G3-3590, error message is issued during boot up,
"platform::micmute: Setting an LED's brightness failed (-19)",
but there's no micmute led on the machine.

Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
If one of two tokens doesn't exist,
don't call led_classdev_register() for platform::micmute.
After that, you wouldn't see the platform::micmute in /sys/class/leds/,
and the error message wouldn't see in dmesg.

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

