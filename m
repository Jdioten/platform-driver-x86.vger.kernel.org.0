Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34615172D1
	for <lists+platform-driver-x86@lfdr.de>; Wed,  8 May 2019 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfEHHsk (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Wed, 8 May 2019 03:48:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46705 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfEHHsk (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Wed, 8 May 2019 03:48:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id f37so21122134edb.13
        for <platform-driver-x86@vger.kernel.org>; Wed, 08 May 2019 00:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FO0gLsxYIO+RwffbAYVeceY7yV7ZX7wepiF9XqqZUxg=;
        b=UxusbwH83GtMQOoNItJ4OPWXUaxMS/HEui1vy+5vETFXtVqra6jhucOinJ8apfebYX
         3zhUzaAeXTsCyxLxAerTbJT9Sq3YS5VxbXEdLW2XdssLv0MIMMSElGBhmxCwWbGimc6w
         S2MZC3GEp3LucwKtoczYmEuzvTYe7OjYxrKe7kQqfQzWDJgblO9rfStvf0L4b7POFacq
         a/5gHfS7rfP4aUPOYc6jp6PcpIIkueGOwXKgLezrivkSkMxuC/R1nlaLBsamSAqGdCwB
         7ZSE3gwzLN9qozfNSxfbknxgxXY1CDm0v74+pjS+mf6rCCy1VGqa2f/KIFq98uKi1WmD
         wepA==
X-Gm-Message-State: APjAAAVcRB7/I/8R4eyhdg8NNImCSmwVebbxJmva/SvX4tpe+Ao24L/P
        Jvq9FWVwDYkD1gD0XCd8x9otng==
X-Google-Smtp-Source: APXvYqzvjRZtwwqIXkc4q8CpZL23B9fxxI4nKeCTlQGfR7gLQB6QFnbi8yyscmSfZXR62tKUCmK2kg==
X-Received: by 2002:a50:d519:: with SMTP id u25mr38638071edi.185.1557301718884;
        Wed, 08 May 2019 00:48:38 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id j18sm4814399edf.72.2019.05.08.00.48.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 00:48:37 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to
 critclk_systems DMI table
To:     Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Semyon Verchenko <semverchenko@factor-ts.ru>
References: <20190429150135.15070-1-hdegoede@redhat.com>
 <CAHp75VeE=88mCcgVx3Y3PQJPQ819Z7=3s=jRGz1y=t09phk=rA@mail.gmail.com>
 <085c5b6e-d220-ebd1-38d2-def7efca24b8@redhat.com>
 <CAHp75Vfe9uK_b_V+uG29wb1L6J7u1hpbU+P4beXso9KNPM+8Rg@mail.gmail.com>
 <568ba27d-a6a5-b158-bab1-f22cd8ccb34e@redhat.com>
 <155726027056.14659.1724431433952718602@swboyd.mtv.corp.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <10c8864c-6ee7-4dfd-6274-b1996e767653@redhat.com>
Date:   Wed, 8 May 2019 09:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155726027056.14659.1724431433952718602@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Hi,

On 07-05-19 22:17, Stephen Boyd wrote:
> Quoting Hans de Goede (2019-05-06 08:05:42)
>> Hi,
>>
>> On 06-05-19 16:59, Andy Shevchenko wrote:
>>> On Mon, May 6, 2019 at 5:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 06-05-19 14:38, Andy Shevchenko wrote:
>>>>> On Mon, Apr 29, 2019 at 6:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>
>>>>>> The Lex 3I380D industrial PC has 4 ethernet controllers on board
>>>>>> which need pmc_plt_clk0 - 3 to function, add it to the critclk_systems
>>>>>> DMI table, so that drivers/clk/x86/clk-pmc-atom.c will mark the clocks
>>>>>> as CLK_CRITICAL and they will not get turned off.
>>>>>>
>>>>>
>>>>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>>> supposedly to go via CLK tree.
>>>>>
>>>>> P.S. If you want it through PDx86, I need immutable branch / tag from CLK.
>>>>
>>>> Stephen added the patches this depends on to his fixes branch, so they
>>>> are in the 5.1 / Torvald's master branch, since we are now in the 5.2 merge
>>>> window, you should be able to cleanly apply this directly.
>>>
>>> We don't do back merges, so, our base is v5.1-rc1. Does it mean the
>>> commit in question is in v5.1-rc1?
>>> AFAICS it was appeared in v5.1-rc5.
>>
>> Ah, I see, my bad.
>>
>> Stephen can you pick up this patch and the
>> "[PATCH 1/1] Add several Beckhoff Automation boards to critclk_systems DMI table"
>> patch then?
>>
> 
> I guess this is urgent?

Somewhat, getting this into e.g. rc2 would be fine too, waiting till 5.3
would be bad.

Regards,

Hans
