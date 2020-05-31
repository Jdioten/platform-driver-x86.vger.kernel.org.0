Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1301E9851
	for <lists+platform-driver-x86@lfdr.de>; Sun, 31 May 2020 17:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgEaPFb (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Sun, 31 May 2020 11:05:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727781AbgEaPFb (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Sun, 31 May 2020 11:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590937529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RonhcQc7dGXh6zCtQA1Y9Qhkanz1xhePj2mm5aSZxGI=;
        b=iEll66UlQw3znJnHg2B7Wpbm3AaVS4xyJakFG+qldjP/eo26Rds9BA1Y16EZ5bxlOhJDpt
        cmDXav+ucrJkp2EOmNYUgCpWKyfiFkoPwHGiZ0Wr4pVI5YIPVuP+ytSbv2/SQID5VqjpHi
        EYDMeYKsx5iC19ZgjfICcT/OI0AxLGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-ps_oCGUsMwm8g9csdsd56Q-1; Sun, 31 May 2020 11:05:27 -0400
X-MC-Unique: ps_oCGUsMwm8g9csdsd56Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FC25835B40;
        Sun, 31 May 2020 15:05:26 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1B0707B1;
        Sun, 31 May 2020 15:05:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: touchscreen_dmi: Update Trekstor Twin 10.1 entry
Date:   Sun, 31 May 2020 17:05:24 +0200
Message-Id: <20200531150524.89576-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Add minimum values for the x and y axis, correct the max value for the
x-axis and add support for the capacitive home-button these tablets have.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 931814e62454..48ffe90ec3ce 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -679,11 +679,14 @@ static const struct ts_dmi_data trekstor_primetab_t13b_data = {
 };
 
 static const struct property_entry trekstor_surftab_twin_10_1_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1900),
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 20),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 0),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1890),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
 	PROPERTY_ENTRY_U32("touchscreen-inverted-y", 1),
 	PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-surftab-twin-10-1-st10432-8.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-- 
2.26.2

