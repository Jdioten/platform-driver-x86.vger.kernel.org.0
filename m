Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8442A1BC6A7
	for <lists+platform-driver-x86@lfdr.de>; Tue, 28 Apr 2020 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgD1R3j (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Tue, 28 Apr 2020 13:29:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25231 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728257AbgD1R3i (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Tue, 28 Apr 2020 13:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588094977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RItB41ATDO9EfPwjDNJiPqZsEf7VFPDFGS8Is5xQSio=;
        b=OWc8S5Rnx9S5h+HWYuadSe8tw5utwrVPzmvIef4gIRf9M/5po4mGqdK7ckbrVOvm1w+J8W
        YsdP9UxoIFiI3ovmY1MnCxqsnf/6k5EYtfMY4MPFnu2G5OwYs0SEKvA7xBhb8R5++WbTJt
        KdYLXWfZqgSBu5xzqTm5L35LwnTBFeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-urJGPG_1M5yzMliyeQWP1A-1; Tue, 28 Apr 2020 13:29:36 -0400
X-MC-Unique: urJGPG_1M5yzMliyeQWP1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B8B41937FC4;
        Tue, 28 Apr 2020 17:29:34 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-62.ams2.redhat.com [10.36.114.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D5FD5C220;
        Tue, 28 Apr 2020 17:29:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 02/11] iio: light: cm32181: Add support for ACPI enumeration
Date:   Tue, 28 Apr 2020 19:29:14 +0200
Message-Id: <20200428172923.567806-2-hdegoede@redhat.com>
In-Reply-To: <20200428172923.567806-1-hdegoede@redhat.com>
References: <20200428172923.567806-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Add support for ACPI enumeration, this has been tested on a HP
HP Pavilion x2 Detachable 10 (Bay Trail model).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- This is a new patch in v3 of this patch-set
---
 drivers/iio/light/cm32181.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index cc57190a24cb..5ca8bbf6667c 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -343,9 +343,18 @@ static const struct of_device_id cm32181_of_match[] =
=3D {
 };
 MODULE_DEVICE_TABLE(of, cm32181_of_match);
=20
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cm32181_acpi_match[] =3D {
+	{ "CPLM3218", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cm32181_acpi_match);
+#endif
+
 static struct i2c_driver cm32181_driver =3D {
 	.driver =3D {
 		.name	=3D "cm32181",
+		.acpi_match_table =3D ACPI_PTR(cm32181_acpi_match),
 		.of_match_table =3D of_match_ptr(cm32181_of_match),
 	},
 	.probe_new	=3D cm32181_probe,
--=20
2.26.0

