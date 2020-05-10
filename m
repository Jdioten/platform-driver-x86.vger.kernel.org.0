Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A61CCA09
	for <lists+platform-driver-x86@lfdr.de>; Sun, 10 May 2020 12:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgEJKDP (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Sun, 10 May 2020 06:03:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57286 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728840AbgEJKDO (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Sun, 10 May 2020 06:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589104994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dsUXVagzxtVSDXpUC6CjeS6CObrDJ63NqscKd/3xqEI=;
        b=P9WSlhvWBNwFB9IVvHr4xMmemgxCS4uJA0mD34/PDky01JuQaL0P0XDhSnMfgOx2KTVLZ/
        vNrIAqSqizbzIZ8/9jtWc79PQBAJFDh74mH6XJkgvpGcEkvjXBeDy3CL2EaSM/CAof+H1i
        7IDj9rtomEx5zjKA78tVYy/j3lF8JjQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-qYVmC_DqNJyLo0SXweGTLg-1; Sun, 10 May 2020 06:03:12 -0400
X-MC-Unique: qYVmC_DqNJyLo0SXweGTLg-1
Received: by mail-wr1-f69.google.com with SMTP id p2so1669467wrm.6
        for <platform-driver-x86@vger.kernel.org>; Sun, 10 May 2020 03:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dsUXVagzxtVSDXpUC6CjeS6CObrDJ63NqscKd/3xqEI=;
        b=i5DMH0YCc4I+6o9zjXCZOJty/yyUHlPR4G8t4WM30AzzUBZZcZitX7mnTk9lIpLWFu
         xBMvFAHJXqMbRGegt9IPYEzveS2V9C1K68N7qE4pwpdtXawu/Mus4aP/6GIIKZrHzBHr
         2oYWU3oVjCqSsHJZzoXKc28EdvjYrpDgwJYafR39RsFGIZC7z3/Agrnkel61FxTPXm74
         0SnZxGeGREfSwdRijn+/P7Kjf7CuBguRvbzpXwfGl2gJOmt+DSArxsXpH1/xDbJd/rih
         GsSVo1fXl4HQ0TKcsQV+707LVZ9N1nH7SlzpoMObjqA3D82A2+0u6USDRY2n8ufrFKx4
         GdoQ==
X-Gm-Message-State: AGi0PuZ79k2IerBQtHBEj3X4Zzh85TBDx62BAqsLISuJWZ4VojpV2MRS
        hJnW0tr7e+SfC18ClgYQgurBAveKXJehkGPCpTpsrzjg5owDgXQnM01S+YpKzKoBMUybOBJBboF
        yCmqBPWBplqR8QKRE8OBRFRsjnkx66UeSTw==
X-Received: by 2002:adf:f38c:: with SMTP id m12mr12572459wro.167.1589104991029;
        Sun, 10 May 2020 03:03:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypIaV3fAsK6sWbWBE1MktPukGJJdd82mv0FoNq7Xm2a+epPUOf7RLNjHmclXTdjK5oWgEUZGMg==
X-Received: by 2002:adf:f38c:: with SMTP id m12mr12572423wro.167.1589104990729;
        Sun, 10 May 2020 03:03:10 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a8sm12313218wrg.85.2020.05.10.03.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 03:03:09 -0700 (PDT)
Subject: Re: [PATCH v4 01/11] iio: light: cm32181: Switch to new style
 i2c-driver probe function
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20200504125551.434647-1-hdegoede@redhat.com>
 <20200510104806.63ffeae5@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e30bbcb4-c0cd-e95f-501a-89270f8dd19e@redhat.com>
Date:   Sun, 10 May 2020 12:03:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200510104806.63ffeae5@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Hi,

On 5/10/20 11:48 AM, Jonathan Cameron wrote:
> On Mon,  4 May 2020 14:55:41 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Switch to the new style i2c-driver probe_new probe function and drop the
>> unnecessary i2c_device_id table (we do not have any old style board files
>> using this).
>>
>> This is a preparation patch for adding ACPI binding support.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Hi Hans,
> 
> Seems these have all been sent with mime type of quoted-printable.
> As git am really doesn't like that I ended up pulling these down from
> patchwork.
> 
> Please try and sort that email issue out for future patch sets until
> we get git am that works with it in standard distro packages (assuming
> it ever does)

Weird, I used git send-email to send the patches, as I always do.
I contribute to a lot of subsystems and this is the first complaint I'm
getting about this ?

> Otherwise, a bit of fuzz from the patch that dropped the of_match_ptr
> protections.
> 
> Series applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.

Great, thank you.

Regards,

Hans



>> ---
>> Changes in v4:
>> - Set indio_dev->name to "cm32181" instead of setting it to dev_name(dev)
>>
>> Changes in v3:
>> - This is a new patch in v3 of this patch-set
>> ---
>>   drivers/iio/light/cm32181.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index 5f4fb5674fa0..2c139d85ef0c 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -294,8 +294,7 @@ static const struct iio_info cm32181_info = {
>>   	.attrs			= &cm32181_attribute_group,
>>   };
>>   
>> -static int cm32181_probe(struct i2c_client *client,
>> -			const struct i2c_device_id *id)
>> +static int cm32181_probe(struct i2c_client *client)
>>   {
>>   	struct cm32181_chip *cm32181;
>>   	struct iio_dev *indio_dev;
>> @@ -316,7 +315,7 @@ static int cm32181_probe(struct i2c_client *client,
>>   	indio_dev->channels = cm32181_channels;
>>   	indio_dev->num_channels = ARRAY_SIZE(cm32181_channels);
>>   	indio_dev->info = &cm32181_info;
>> -	indio_dev->name = id->name;
>> +	indio_dev->name = "cm32181";
>>   	indio_dev->modes = INDIO_DIRECT_MODE;
>>   
>>   	ret = cm32181_reg_init(cm32181);
>> @@ -338,13 +337,6 @@ static int cm32181_probe(struct i2c_client *client,
>>   	return 0;
>>   }
>>   
>> -static const struct i2c_device_id cm32181_id[] = {
>> -	{ "cm32181", 0 },
>> -	{ }
>> -};
>> -
>> -MODULE_DEVICE_TABLE(i2c, cm32181_id);
>> -
>>   static const struct of_device_id cm32181_of_match[] = {
>>   	{ .compatible = "capella,cm32181" },
>>   	{ }
>> @@ -356,8 +348,7 @@ static struct i2c_driver cm32181_driver = {
>>   		.name	= "cm32181",
>>   		.of_match_table = of_match_ptr(cm32181_of_match),
>>   	},
>> -	.id_table       = cm32181_id,
>> -	.probe		= cm32181_probe,
>> +	.probe_new	= cm32181_probe,
>>   };
>>   
>>   module_i2c_driver(cm32181_driver);
> 

