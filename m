Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C251C27B5
	for <lists+platform-driver-x86@lfdr.de>; Sat,  2 May 2020 20:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgEBSaL (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Sat, 2 May 2020 14:30:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48250 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728252AbgEBSaA (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Sat, 2 May 2020 14:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588444199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i+9v/qYoHNQGNliajcJLNu+vjyiEX3mv4ByBciyGe3g=;
        b=LAXne56bOIgaiO39oz33WVSb1J5uA4qj6u0ny0OILbwmEx2KBFTaFuNFGLwc2gJ0CL+z4R
        eNzKZ5h+Iwy2CgCUVi1TZuTzaZEgAt5gT6La9SJmVkwPKKb0qyIAwrFnxLhoPGHFkjuZIa
        crUrwWFNI2lJ0dATMKUde/+rkk7vs1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-mhLL0URyNiCAicCR8IS9Yg-1; Sat, 02 May 2020 14:29:56 -0400
X-MC-Unique: mhLL0URyNiCAicCR8IS9Yg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB5545F;
        Sat,  2 May 2020 18:29:54 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E6FD600E5;
        Sat,  2 May 2020 18:29:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] platform/x86: intel-vbtn: Fixes + rework to make it work on more devices
Date:   Sat,  2 May 2020 20:29:46 +0200
Message-Id: <20200502182951.114231-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Hi All,

Here is a series of fixes, mostly aimed at fixing commit: de9647efeaa9
("platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's"=
)
causing the driver to not bind on some devices where it could and
should report SW_TABLET_MODE.

The last commit makes the driver also work on some devices where it
previously would not work because they lack a VBDL method.

Mario, can you test this on a Dell XPS 9360 (for which you wrote the
de9647efeaa9 commit) to ensure that this series does not cause a
regression there?  Also I have a question for you about using the DMI
chassis-type for this / a proposal for dealing with this differently
below the '---' of the commit msg of the 4th patch.

Regards,

Hans


