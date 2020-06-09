Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A41F4072
	for <lists+platform-driver-x86@lfdr.de>; Tue,  9 Jun 2020 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbgFIQOU (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Tue, 9 Jun 2020 12:14:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731087AbgFIQOS (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Tue, 9 Jun 2020 12:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591719256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3q22RYspYRyYbER8pK6XhkMiHhqOP+KQeLb3BfV3ios=;
        b=R3Gze83qmQcztRthzuI3imdVYJ5+TKD1c6vj+5wOomGxoCwFeZ0NfncQvU6ydysKlxcegz
        Ir/A8H152DGy2elI7xBeLthXMytzsCFpbDnyPnA7FxZ5YKHFW9XBAN3WMz2KWZWF0cJ91o
        bojNYckd9GL6E5MRqHxysKir76xxptw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-jIhxWhgAOhK7BDXBS503-Q-1; Tue, 09 Jun 2020 12:14:14 -0400
X-MC-Unique: jIhxWhgAOhK7BDXBS503-Q-1
Received: by mail-ej1-f69.google.com with SMTP id m19so7638087ejd.21
        for <platform-driver-x86@vger.kernel.org>; Tue, 09 Jun 2020 09:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3q22RYspYRyYbER8pK6XhkMiHhqOP+KQeLb3BfV3ios=;
        b=YG2DGho5tnsebInH7YriNQBzatUYSj2NdEfC9WGUMXos1jvxfKcJ1hzqmmoC8/5mKN
         6rRnRPvTkda7ka//EZ+VxH+gf4Z+RliLrLNXVjY4McemyGupd2YvZT0uKCy9o4LlCDlL
         /s9gz2/BUQVDbTFvkePQn3+M680L5BPgETY8+chQH2cDUXGZwhuTFAXTuz4nhzKxjqhW
         ecswZlwguDfT/vAmKHK14c5Y473Znj0+xuTm4zfva/rTjpD66mZL6oSZVHaA+C80trl7
         5nY5jig4VUrwCeORZLDgLEXBpGJX6gMqae8Ccl3FD0trorUllAxq3zKf5WenOO3qc+Zu
         Wj/Q==
X-Gm-Message-State: AOAM530Ok0fSkESeM0AFsxy/FY+7k9XQXjFI8uJo/n+np/W/mrFrCgc9
        2Sy2+1q5mdyIi42OpI7A11OVmvkG4fa90YT4y4nF5D8WTaaz/6xnRn5sA3vCmeKSKf0VM/PX5Kw
        wEldoXE95EOB2lrX0SHcWRlfLkzRXkw5YOQ==
X-Received: by 2002:a17:906:b7c8:: with SMTP id fy8mr25767626ejb.85.1591719253511;
        Tue, 09 Jun 2020 09:14:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxGjWA3j+DcBexKy5awWiWEr8epdgclPYU7N2XWOY5sJ5h4HvsCXoxB1j+wWy5yC1n/oRJQw==
X-Received: by 2002:a17:906:b7c8:: with SMTP id fy8mr25767602ejb.85.1591719253188;
        Tue, 09 Jun 2020 09:14:13 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id d11sm10688895edy.79.2020.06.09.09.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 09:14:12 -0700 (PDT)
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
To:     Mario.Limonciello@dell.com, y.linux@paritcher.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mjg59@srcf.ucam.org, pali@kernel.org, linux-input@vger.kernel.org
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
 <137d8e69-a83f-6129-19e0-316ef0a51076@redhat.com>
 <ae45da27126d470888ef0d839665b9ed@AUSX13MPC105.AMER.DELL.COM>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <10fcfbe7-cf2e-0911-334b-60be3336c990@redhat.com>
Date:   Tue, 9 Jun 2020 18:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ae45da27126d470888ef0d839665b9ed@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Hi,

On 6/9/20 5:36 PM, Mario.Limonciello@dell.com wrote:
> Loop linux-input mailing list and trim to the relevant conversation.
> 
>>> Can you please comment here how you would like to see events like this
>> should come
>>> through to userspace?
>>>
>>> * Wrong power adapter (you have X and should have Y)
>>> * You have plugged a dock into the wrong port
>>> * Fn-lock mode
>>
>> Note just thinking out loud here.
>>
>> I'm thinking we just need a mechanism to show a "user notification". This
>> would
>> be just a plain text string passed from the kernel to userspace. I guess we
>> may also want some mechanism to build (on the kernel side) a small file
>> with all possible messages for translation from US English to other
>> languages.
> 
> The part that falls apart here is that some strings have dynamic data added to
> them.  For example in the case I said wrong power adapter there will be some numbers
> put into the string based on what comes into the buffer.  So how will you translate
> these?
> 
> I guess you can draw a line in the sand and say all strings that can be emitted must
> be "static and generic".

Right, that is what I was thinking, although for the power adapter case
I was thinking there are not so much variants so we can just do
a couple of fixed strings for the combos, or maybe just sat that
the adapter does not delivers enough power and that at minimum X watts
is necessary" then we only have 1 variable and we can probably easily
do fixed strings for the few cases of X.

Or we could get fancy and do some generic notification mechanism outside
of printk/dmesg where we push a format string + parameters to the format
string to userspace. So that the translation can be done on the format
string rather then on the end result. I'm not sure we need to make things
that complicated though.

>> So the idea would be that e.g. gnome-shell can listen for these in some way
>> and then show a notification in its notification mechanism with the
>> message,
>> like how it does for when software updates are available for example.
>>
>> I think we can make this as simple as using the normal printk buffer for
>> this
>> and prefixing the messages with "USER NOTIFY", we already have some
>> messages
>> in the kernel which would qualify for this, e.g. in the USB core we have:
>>
>>                   dev_info(&udev->dev, "not running at top speed; "
>>                           "connect to a high speed hub\n");
>>
>> This one is about USB1 vs USB2 ports, but we have a similar one somewhere
>> for USB2 vs USB3 ports (I think) which would also be an interesting message
>> to actually show to the user inside the desktop environment.
>>
>> So sticking with the above example, we could change that to
>>
>> #define USER_NOTIFY "USER NOTIFY: "
>>
>> dev_info(&udev->dev, USER_NOTIFY "not running at top speed; connect to a
>> high speed hub\n");
>>
>> And then userspace would trigger on the "USER NOTIFY: " part, keep the
>> bit before it (which describes the device) as is, try to translate
>> the text after it and then combine the text before it + the possibly
>> translated text after it and show that as a notification.
>>
>> The reason for (ab)using the printk ring-buffer for this is that
>> we will still want to have these messages in dmesg too anyways,
>> so why add a new mechanism and send the same message twice if
>> we can just tag the messages inside the printk ring-buffer ?
>>
>> Note the dev_info above would likely be replaced with some new
>> helper which also does some magic to help with gathering a
>> list of strings to translate.
>>
>> Again just thinking out loud here. If anyone has any initial
>> reaction to this please let me know...
>>
> 
> As a general comment, I think it captures very well the possibility
> that the kernel has more information than userspace about the circumstances
> of something that a user should be notified.  Definitely that's the
> case for these WMI/ACPI events, and I would think similar circumstances
> can apply to other subsystem too.

Right, that was my idea behind having a generic notification mechanism.

Regards,

Hans

