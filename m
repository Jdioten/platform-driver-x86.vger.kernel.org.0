Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B861F7530
	for <lists+platform-driver-x86@lfdr.de>; Fri, 12 Jun 2020 10:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFLISG (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Fri, 12 Jun 2020 04:18:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46508 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726324AbgFLISC (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Fri, 12 Jun 2020 04:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591949880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbTU48ojgO2FlIo9PAsC9R4igbZ13z+cUADaXE0FnOU=;
        b=Tkh3ejkZXDN8pEFvcVn1r3AMpy0Ti3rb9et1sZJA7rLix3i5CdVp49qUj4IPLYsrDKSwEi
        R0sb9An+q7Je6S5XrDYmX9oybJmEZiCIs/WSAkFAS8miSLGA48izlBmifmGP4eM/rHKHwd
        lGquSXSqbCjKH/wqs8ou2iKuzdjSAaI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-3NM2YmwYN-2iMa698s1xuA-1; Fri, 12 Jun 2020 04:17:57 -0400
X-MC-Unique: 3NM2YmwYN-2iMa698s1xuA-1
Received: by mail-ed1-f70.google.com with SMTP id c1so2585006edd.21
        for <platform-driver-x86@vger.kernel.org>; Fri, 12 Jun 2020 01:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LbTU48ojgO2FlIo9PAsC9R4igbZ13z+cUADaXE0FnOU=;
        b=e/u80XRPYCytvwZU/lW0IB4QQEt0abkMA1MOkdhHBvlUkbxwc5NKsnLbOqj8ycxgsT
         bZhbMb6rM1+DqpXihMoqN+pYBINJgr/55C4Ga8O9G4xPy9X2eKhFWd+Kf3OjGLs9zZJE
         9IRQE63ATuk1+fbEsRlR0oLq2ZBGzOWJVnD0YeKC7M6xguPSrH03PdqpLFlkqlNAhUwA
         76h2v/Im/T0hL9vGlFrWxEKqEzk1WXubwsKJv9kClDtZ74raKPXRoQgBWfJmcmveDxss
         rFQKnzqQUDWsQZNP/MRlWkfwisV53txZzKIqnDwSfKrlBPDcQgA9olOWrdGL0ed/1cdk
         QSlg==
X-Gm-Message-State: AOAM532RbGmx5dpfHo3Td5q3sjg8Vqz2HzRkN4Z/qssAWe0MCVgZE1V/
        mwQlUb/EWlBLlJBxzFh1tYXa6jOBMhCvRJWs04zcp7Euc4mZpA22oTN1as1W/lrr3R4tMqPi83e
        9U3W/63N6CPwnwsBs1P1oWEWXgF212/rcNA==
X-Received: by 2002:a17:906:ccdd:: with SMTP id ot29mr11758828ejb.119.1591949875883;
        Fri, 12 Jun 2020 01:17:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwtNGBDEJyj/avNl3UCU7R4ntwBo4aI35VOBMw7tHPjvk5hJcx1khBKXvQ05G75ytNLMmeTQ==
X-Received: by 2002:a17:906:ccdd:: with SMTP id ot29mr11758779ejb.119.1591949875662;
        Fri, 12 Jun 2020 01:17:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id mf24sm3166452ejb.13.2020.06.12.01.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 01:17:54 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1821a5b7-cbf3-a739-2203-a93b06f0c6f2@redhat.com>
Date:   Fri, 12 Jun 2020 10:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608112211.12125-1-andrzej.p@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Hi,

On 6/8/20 1:22 PM, Andrzej Pietrasiewicz wrote:
> This is a quick respin of v3, with just two small changes, please see
> the changelog below.
> 
> Userspace might want to implement a policy to temporarily disregard input
> from certain devices.
> 
> An example use case is a convertible laptop, whose keyboard can be folded
> under the screen to create tablet-like experience. The user then must hold
> the laptop in such a way that it is difficult to avoid pressing the keyboard
> keys. It is therefore desirable to temporarily disregard input from the
> keyboard, until it is folded back. This obviously is a policy which should
> be kept out of the kernel, but the kernel must provide suitable means to
> implement such a policy.
> 
> Due to interactions with suspend/resume, a helper has been added for drivers
> to decide if the device is being used or not (PATCH 1/7) and it has been
> applied to relevant drivers (PATCH 2,4,5,6/7).
> 
> PATCH 7/7 adds support for inhibiting input devices.
> 
> This work is inspired by:
> 
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/45c2d7bb398f74adfae0017e20b224152fde3822
> 
> and
> 
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/4ce0e8a3697edb8fd071110b3af65014512061c7
> 
> In this respin the elan_i2c patch is dropped and converting it will be
> addressed later.
> 
> v3..v4:
> - updated the comment in input_open_device() (Hans)
> - used more straightforward locking pattern in adc/exynos (Michał)
> 
> v2..v3:
> - ignored autorepeat events in input_get_disposition() if a key is not
> pressed (Hans)
> - dropped inhibit()/uninhibit() driver callbacks (Hans)
> - split ACPI button patch into taking the lock and using the helper (Rafael)
> - dropped the elan_i2c conversion
> - fixed typos in exynos adc
> 
> v1..v2:
> - added input_device_enabled() helper and used it in drivers (Dmitry)
> - the fact of open() and close() being called in inhibit/uninhibit paths has
> been emphasized in the commit message of PATCH 6/7 (Dmitry)
> 
> Andrzej Pietrasiewicz (6):
>    Input: add input_device_enabled()
>    Input: use input_device_enabled()
>    ACPI: button: Access input device's users under appropriate mutex
>    ACPI: button: Use input_device_enabled() helper
>    iio: adc: exynos: Use input_device_enabled()
>    platform/x86: thinkpad_acpi: Use input_device_enabled()
> 
> Patrik Fimml (1):
>    Input: Add "inhibited" property

The entire series looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


