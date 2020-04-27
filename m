Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2041BA73D
	for <lists+platform-driver-x86@lfdr.de>; Mon, 27 Apr 2020 17:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgD0PGQ (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 27 Apr 2020 11:06:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46308 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727921AbgD0PGO (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 27 Apr 2020 11:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587999972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHWkGUvj4t05y2VKSH2hO4KlsW7WN90Jqwx2sM7eu3Q=;
        b=EVsUVdIRahpuv4BfwyQx+zSvPXmXyT4WTNdW9eHX7u1a8QuFowqxtQPDAYnJaFQMIbjk9r
        TvJg1KQUDn44xWkmgvgvYN6B7MQSIjRHteFWopJfhHWlBURxlDFIUJao2fpI/Glx3VpLys
        ZxXK+xPatzWjm6EVaBerO/KUeArDkBo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-2cqV4xV6NUipbYqwEVzxPQ-1; Mon, 27 Apr 2020 11:06:07 -0400
X-MC-Unique: 2cqV4xV6NUipbYqwEVzxPQ-1
Received: by mail-wm1-f72.google.com with SMTP id d134so14283wmd.0
        for <platform-driver-x86@vger.kernel.org>; Mon, 27 Apr 2020 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZHWkGUvj4t05y2VKSH2hO4KlsW7WN90Jqwx2sM7eu3Q=;
        b=soaVGECCaDmjOPxfJpN2ckvWeninGHtlX2VLtBMbF46jZ5YtqD3a+PLiBVLxtDWrGZ
         CI8ZfOM4HKX6idNSZjZfW0VE0SSQEUvr8izrqYW02bHq1H7X024eJIWS66OZLueXkPJY
         jE5pqereTg/ImsqMt+fQ/ZClZM1n9pVh2rin7pZ1+h6wI6wLFZm34kVEJYL5x5YHgVdY
         H6WgQt3P7ljUXWH4RYKRyW33ByNHWh2Ic/DYolAQl8pM2qiqb2UCzZ329eFtatStA0lg
         umsMv1tsdpMCibJj1SNtt8IZf4COJp1CaRp3fUcN+Wf4ZH6RJWOD4ONg+kDvB0x8tdeW
         NCxw==
X-Gm-Message-State: AGi0PuZBYZQmaQoqIWCQgtzxnieKiNk1vnBieUMk+IHm73W/Je67d7Kw
        hTNh0ts/8J5qTcuxSNpqpjWyU94stAaN0JM1ejZEm3Hy+UeJ+IoLA0n1sCgxDHveeNL0zUQ82MH
        Ds8VaI/4cJtBTLa9DAWXTwFRZ7aChvN2AQA==
X-Received: by 2002:a5d:6cc2:: with SMTP id c2mr16647071wrc.60.1587999965126;
        Mon, 27 Apr 2020 08:06:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypItdoXY5PFxTED2h0uXEEC850ph4xpBIcVzeUSEgKxX4SO0paRCeuCRDQ38RZAEARYhNB+aiA==
X-Received: by 2002:a5d:6cc2:: with SMTP id c2mr16647048wrc.60.1587999964863;
        Mon, 27 Apr 2020 08:06:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r20sm15244349wmh.26.2020.04.27.08.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 08:06:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] platform/x86: i2c-multi-instantiate: Add flag for
 passing fwnode
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org
References: <20200426104713.216896-1-hdegoede@redhat.com>
 <20200426104713.216896-2-hdegoede@redhat.com>
 <CAHp75VdOd6C36oR7HAnqrKiinVBr4YcqqJ=dv3NpR3=Xp0QQ-Q@mail.gmail.com>
 <b5bdffb4-0af2-abb7-21f7-2f5da56d5dc6@redhat.com>
 <CAHp75VegakBqAzxn1e+MzF3EgB6fNya3L0eZHMh11yct6HHNKw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <66619a61-c398-5a8a-4ee0-13dbe5d2c559@redhat.com>
Date:   Mon, 27 Apr 2020 17:06:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VegakBqAzxn1e+MzF3EgB6fNya3L0eZHMh11yct6HHNKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Hi,

On 4/27/20 3:18 PM, Andy Shevchenko wrote:
> On Mon, Apr 27, 2020 at 3:51 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 4/26/20 7:59 PM, Andy Shevchenko wrote:
>>> On Sun, Apr 26, 2020 at 1:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> In some cases the driver for the i2c_client-s which i2c-multi-instantiate
>>>> instantiates may need access some fields / methods from to the ACPI fwnode
>>>> for which i2c_clients are being instantiated.
>>>>
>>>> An example of this are CPLM3218 ACPI device-s. These contain CPM0 and
>>>> CPM1 packages with various information (e.g. register init values) which
>>>> the driver needs.
>>>>
>>>> Passing the fwnode through the i2c_board_info struct also gives the
>>>> i2c-core access to it, and if we do not pass an IRQ then the i2c-core
>>>> will use the fwnode to get an IRQ, see i2c_acpi_get_irq().
>>>
>>> I'm wondering, can we rather do it in the same way like we do for
>>> GPIO/APIC case here.
>>> Introduce IRQ_RESOURCE_SHARED (or so) and
>>>
>>> case _SHARED:
>>>    irq = i2c_acpi_get_irq();
>>> ...
>>>
>>> ?
>>
>> I think you are miss-understanding the problem. The problem is not that
>> we want to share the IRQ, the problem is that we want to pass the single
>> IRQ in the resources to only 1 of the instantiated I2C-clients. But if we
>> do not pass an IRQ (we leave it at 0) and we do pass the fwnode then
>> i2c-core-base.c will see that there is an ACPI-node attached to the
>> device and will call i2c_acpi_get_irq().
> 
> Do we know ahead which device should take IRQ resource and which should not?
> Can we use current _NONE flag for them?

The problem is not internal to i2c-multi-instantiate.c, the problem
(once we pass a fwnode) is the API between i2c-multi-instantiate.c and
the i2c-core. For the IRQ_RESOURCE_NONE case i2c-multi-instantiate.c
sets board_info.irq to 0, which is the correct way to specify that
we do not have an IRQ, but if don't pass an IRQ then the i2c-core
will try to find one itself.  And once we pass the fwnode, then
the "try to find one itself" code will call i2c_acpi_get_irq()
and find the same IRQ for clients we instantiate, leading to
the earlier mentioned IRQ conflict.

<adding Wolfram + i2c lists to the Cc>

We could set board_info.irq to -ENOENT to indicate that there should
not be an irq. But that will get passed to various i2c-drivers, many of
which check for an irq like this:

	if (client->irq) {
		...
	}

We can avoid this, without needing to change all the drivers
by making the i2c-core check for board_info.irq < 0 to skip its
own "try to find IRQ" code and then set client->irq to 0 after
that check, rather then setting it to board_info.irq = -ENOENT.

If we do that then we can unconditionally pass the fwnode in
the i2c-multi-instantiate code.

Regards,

Hans





>> So the solution is definitely not calling i2c_acpi_get_irq() inside
>> i2c-multi-instantiate.c we want to avoid the i2c_acpi_get_irq(),
>> leaving the other 2 clients for the BSG1160 device without an IRQ
>> and thus avoiding the IRQ mismatch (it is a mismatch because the
>> drivers do not set the shared flag; and that is ok, we do not want
>> to share the IRQ, it is just for the accelerometer AFAIK).
> 
>>>> This is a problem when there is only an IRQ for 1 of the clients described
>>>> in the ACPI device we are instantiating clients for. If we unconditionally
>>>> pass the fwnode, then i2c_acpi_get_irq() will assign the same IRQ to all
>>>> clients instantiated, leading to kernel-oopses like this (BSG1160 device):
>>>>
>>>> [   27.340557] genirq: Flags mismatch irq 76. 00002001 (bmc150_magn_event) vs. 00000001 (bmc150_accel_event)
>>>> [   27.340567] Call Trace:
>>>> ...
>>>>
>>>> So we cannot simply always pass the fwnode. This commit adds a PASS_FWNODE
>>>> flag, which can be used to pass the fwnode in cases where we do not have
>>>> the IRQ problem and the driver for the instantiated client(s) needs access
>>>> to the fwnode.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>    drivers/platform/x86/i2c-multi-instantiate.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
>>>> index 6acc8457866e..dcafb1a29d17 100644
>>>> --- a/drivers/platform/x86/i2c-multi-instantiate.c
>>>> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
>>>> @@ -20,6 +20,8 @@
>>>>    #define IRQ_RESOURCE_GPIO      1
>>>>    #define IRQ_RESOURCE_APIC      2
>>>>
>>>> +#define PASS_FWNODE            BIT(2)
>>>> +
>>>>    struct i2c_inst_data {
>>>>           const char *type;
>>>>           unsigned int flags;
>>>> @@ -93,6 +95,10 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
>>>>                   snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev),
>>>>                            inst_data[i].type, i);
>>>>                   board_info.dev_name = name;
>>>> +
>>>> +               if (inst_data[i].flags & PASS_FWNODE)
>>>> +                       board_info.fwnode = dev->fwnode;
>>>> +
>>>>                   switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
>>>>                   case IRQ_RESOURCE_GPIO:
>>>>                           ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
>>>> --
>>>> 2.26.0
>>>>
>>>
>>>
>>
> 
> 

