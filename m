Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1160921AC9C
	for <lists+platform-driver-x86@lfdr.de>; Fri, 10 Jul 2020 03:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgGJB4c (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Thu, 9 Jul 2020 21:56:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55107 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGJB4c (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Thu, 9 Jul 2020 21:56:32 -0400
Received: from [114.250.191.34] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1jtiH0-0000mo-4R; Fri, 10 Jul 2020 01:56:23 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     aaron.ma@canonical.com, mapengyu@gmail.com, ibm-acpi@hmh.eng.br,
        dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3][PATCH] platform/x86: thinkpad_acpi: not loading brightness_init when _BCL invalid
Date:   Fri, 10 Jul 2020 09:56:14 +0800
Message-Id: <20200710015614.3854-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702085520.16901-1-aaron.ma@canonical.com>
References: <20200702085520.16901-1-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

When _BCL invalid, disable thinkpad_acpi backlight brightness control.

brightness_enable is already checked at the beginning.
Most new thinkpads are using GPU driver to control brightness now,
print notice when enabled brightness control even when brightness_enable = 1.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ff7f0a4f2475..2b36d5416a3b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6955,10 +6955,13 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 			pr_warn("Cannot enable backlight brightness support, ACPI is already handling it.  Refer to the acpi_backlight kernel parameter.\n");
 			return 1;
 		}
-	} else if (tp_features.bright_acpimode && brightness_enable > 1) {
-		pr_notice("Standard ACPI backlight interface not available, thinkpad_acpi native brightness control enabled\n");
+	} else if (!tp_features.bright_acpimode) {
+		pr_notice("ACPI backlight interface not available\n");
+		return 1;
 	}
 
+	pr_notice("ACPI native brightness control enabled\n");
+
 	/*
 	 * Check for module parameter bogosity, note that we
 	 * init brightness_mode to TPACPI_BRGHT_MODE_MAX in order to be
-- 
2.26.2

