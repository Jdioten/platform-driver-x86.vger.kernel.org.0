Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025DC1BACA4
	for <lists+platform-driver-x86@lfdr.de>; Mon, 27 Apr 2020 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgD0S3Y (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 27 Apr 2020 14:29:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22332 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbgD0S3X (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 27 Apr 2020 14:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588012161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bjYHlTE3f0K8iBEQjkZI2BtLm4xIMhdWfhRKQ6nTDo=;
        b=Cef+ZO9/cmi3vqz6xrYtYe/ewvKKgPkSCVfDf+IBgfZFK+5MKbA30LOQPooc/AoSLmtd4x
        yWrzXK1E8I97E1s+nZCwzSeq09JpgC3om9LprxPkuwtao7ttShUlCEVu4aBvPnMB8ktnnb
        0SIhPNaA8B9eRXTSZLcrHzCiLaqrf88=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-0INykBlzPO2YrhSWEC-U6A-1; Mon, 27 Apr 2020 14:29:20 -0400
X-MC-Unique: 0INykBlzPO2YrhSWEC-U6A-1
Received: by mail-wm1-f72.google.com with SMTP id s12so232133wmj.6
        for <platform-driver-x86@vger.kernel.org>; Mon, 27 Apr 2020 11:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bjYHlTE3f0K8iBEQjkZI2BtLm4xIMhdWfhRKQ6nTDo=;
        b=C4ecrPAf63cuDDDQnBxSdSqITRbDA8SMIK7UA++4RcA6mKKi45XOnWqT5QAoqlwcHk
         4+hOxqU34cyMbygbVuM3TTkZFV6T5S+9c0QNTlWXZ9H+UCXHmZ0BUdVq7oi6Xbx1fwg6
         RC6s2L+NJgZjVDUqfonikOtauiFWSATuxDoEetFvwV2Rzfa7G1JmKc5VspgtuMcW5f1U
         uuTRO/23Sm2723QMGNIYR1vDRAKMc09Uan0Erzv+J1ExVP5M+9tRTK14E+9ycGTPAyTt
         p9Ai0XGR/QoNvZTu3C3y9mW/HzPZEJpw10LBykMIyFWdT4WZgxHLZ/gzyScUudV1brbf
         +g4A==
X-Gm-Message-State: AGi0Pub1lZeHrSLRSXSgOfl4ZUrs6405Oum3LGvxn6tX9o5wGIvTMzhU
        p9EIioWJ0pkzmuwGAocjuimOFzMYcEQ+QY+WyVQquXv3jNVBGKPQe3ruwEdYFSnpyUtjbhPS3ZU
        lvPCZQkOMdjPNYjRcnH0LsDgK3yTXnuVFpQ==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr774911wmc.29.1588012159070;
        Mon, 27 Apr 2020 11:29:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypLfvQcZm4UmkjP5XXVw/I9YuU4k9M1fxPuwkaF6ru/9oWh+UosSsARMAxjgnhWn6nqbMO36xA==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr774893wmc.29.1588012158824;
        Mon, 27 Apr 2020 11:29:18 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id o6sm13565241wrw.63.2020.04.27.11.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 11:29:18 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/8] iio: light: cm32181: Add some extra register
 defines
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20200427155037.218390-1-hdegoede@redhat.com>
Message-ID: <10122c2e-ea04-2be7-ac19-c070390d5335@redhat.com>
Date:   Mon, 27 Apr 2020 20:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200427155037.218390-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Hi ,

Self-nack for this series, specifically for the

[PATCH v2 3/8] iio: light: cm32181: Handle ACPI instantiating a cm32181 client on the SMBus ARA

Patch, I will reply to that patch with more details and I will prepare a v3
of this series with a better solution.

Regards,

Hans


On 4/27/20 5:50 PM, Hans de Goede wrote:
> These come from a newer version of cm32181.c, which is floating around
> the net, with a copyright of:
> 
>   * Copyright (C) 2014 Capella Microsystems Inc.
>   * Author: Kevin Tsai <ktsai@capellamicro.com>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License version 2, as published
>   * by the Free Software Foundation.
> 
> Note that this removes the bogus CM32181_CMD_ALS_ENABLE define, there
> is no enable bit, only a disable bit and enabled is the absence of
> being disabled.
> 
> This is a preparation patch for adding support for the older
> CM3218 model of the light sensor.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/iio/light/cm32181.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 5f4fb5674fa0..ee386afe811e 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -18,6 +18,9 @@
>   
>   /* Registers Address */
>   #define CM32181_REG_ADDR_CMD		0x00
> +#define CM32181_REG_ADDR_WH		0x01
> +#define CM32181_REG_ADDR_WL		0x02
> +#define CM32181_REG_ADDR_TEST		0x03
>   #define CM32181_REG_ADDR_ALS		0x04
>   #define CM32181_REG_ADDR_STATUS		0x06
>   #define CM32181_REG_ADDR_ID		0x07
> @@ -26,9 +29,13 @@
>   #define CM32181_CONF_REG_NUM		0x01
>   
>   /* CMD register */
> -#define CM32181_CMD_ALS_ENABLE		0x00
> -#define CM32181_CMD_ALS_DISABLE		0x01
> -#define CM32181_CMD_ALS_INT_EN		0x02
> +#define CM32181_CMD_ALS_DISABLE		BIT(0)
> +#define CM32181_CMD_ALS_INT_EN		BIT(1)
> +#define CM32181_CMD_ALS_THRES_WINDOW	BIT(2)
> +
> +#define CM32181_CMD_ALS_PERS_SHIFT	4
> +#define CM32181_CMD_ALS_PERS_MASK	(0x03 << CM32181_CMD_ALS_PERS_SHIFT)
> +#define CM32181_CMD_ALS_PERS_DEFAULT	(0x01 << CM32181_CMD_ALS_PERS_SHIFT)
>   
>   #define CM32181_CMD_ALS_IT_SHIFT	6
>   #define CM32181_CMD_ALS_IT_MASK		(0x0F << CM32181_CMD_ALS_IT_SHIFT)
> @@ -82,7 +89,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>   		return -ENODEV;
>   
>   	/* Default Values */
> -	cm32181->conf_regs[CM32181_REG_ADDR_CMD] = CM32181_CMD_ALS_ENABLE |
> +	cm32181->conf_regs[CM32181_REG_ADDR_CMD] =
>   			CM32181_CMD_ALS_IT_DEFAULT | CM32181_CMD_ALS_SM_DEFAULT;
>   	cm32181->calibscale = CM32181_CALIBSCALE_DEFAULT;
>   
> 

