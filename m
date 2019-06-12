Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6341D16
	for <lists+platform-driver-x86@lfdr.de>; Wed, 12 Jun 2019 08:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407747AbfFLG7a (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Wed, 12 Jun 2019 02:59:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37187 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407223AbfFLG73 (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Wed, 12 Jun 2019 02:59:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so24055708eds.4
        for <platform-driver-x86@vger.kernel.org>; Tue, 11 Jun 2019 23:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c7dWfW/bJapXFOFfkyjFdL/++/dUWMlX3e9jufSOBgY=;
        b=Zu+Qp2wyd4SoyLPvbkyTPym4DAXWddArZBCfUmyOIH3QI2aldxtD1J5qTzWLynAF4S
         IwLszwrpKiY8rZLwVhQgZ9+88m7geIUBNtPaF2bnnKY+f7dXv34gLFtgbr1wINcVVsjv
         CG8i83HpzYM4R/+s885lPW0nUeAbNpePZbiSeVc5FPqiBLmGD7T8xxYtoh/8P8PZm8eg
         v3TCof5XH/UhZg1xsjsB9DgzAsDtZB2Sxs8SeFF8SsRyh6UEJ/Ynzgoz0g9Wfb/jGTRx
         PnXkJRj76EO9xZjQckmrLSL5onELAebTcLZu0+vX3WwSjNJlaAvL37+knwnaomJdRzpe
         bXkg==
X-Gm-Message-State: APjAAAXm98jxaqzyowt9BLVkb0WJeeUBGRuqkSQy5ASVsW6yG/97UiKk
        8w/EfSi8oOR5Xtxn5gsziUeVmg==
X-Google-Smtp-Source: APXvYqz7EBJgnGY0h5pkCYQHXm0g2k8yDiOt9z4W0eIZwSyszH0plvKKlSIJHiOzuRf+sYnWydswHg==
X-Received: by 2002:a50:b062:: with SMTP id i89mr85945690edd.85.1560322768260;
        Tue, 11 Jun 2019 23:59:28 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id d12sm1826542edp.16.2019.06.11.23.59.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 23:59:27 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: asus-wmi: Only Tell EC the OS will handle
 display hotkeys from asus_nb_wmi
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
References: <20190521062837.3887-1-hdegoede@redhat.com>
 <CAHp75Vf6qzq3O1qz481FRuT1MN2EZOV43FpoSCC-vqATzyRF8w@mail.gmail.com>
 <0018e660-c1d4-2c42-837f-ceb13d575b86@redhat.com>
 <41f5c7ff-20a3-ba6a-7ee3-2d3956d8b5a8@redhat.com>
 <CAHp75Ve8No6pKr0NiNxiQhLRSnJ=w6VW2zsLA2FV9VjqsvvMQA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <25b66e42-b281-3645-f80c-d93aad2d9da1@redhat.com>
Date:   Wed, 12 Jun 2019 08:59:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve8No6pKr0NiNxiQhLRSnJ=w6VW2zsLA2FV9VjqsvvMQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Hi,

On 11-06-19 21:15, Andy Shevchenko wrote:
> On Wed, Jun 5, 2019 at 9:15 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 28-05-19 15:37, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 24-05-19 18:43, Andy Shevchenko wrote:
>>>> On Tue, May 21, 2019 at 9:28 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>> Commit 78f3ac76d9e5 ("platform/x86: asus-wmi: Tell the EC the OS will
>>>>> handle the display off hotkey") causes the backlight to be permanently off
>>>>> on various EeePC laptop models using the eeepc-wmi driver (Asus EeePC
>>>>> 1015BX, Asus EeePC 1025C).
>>>>>
>>>>> The asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL) call added
>>>>> by that commit is made conditional in this commit and only enabled in
>>>>> the quirk_entry structs in the asus-nb-wmi driver fixing the broken
>>>>> display / backlight on various EeePC laptop models.
>>>>>
>>>>
>>>> Hmm... doesn't apply.
>>>
>>> That is likely because your review-andy branch contain a whole-bunch
>>> of asus-wmi patches.
>>>
>>> Since this is a patch fixing a regression this should go to the fixes
>>> branch. As the other patches so far are only in your review-andy branch
>>> it is probably best to merge this patch to for-next + fixes first and
>>> then rebase the set you have in review-andy on top, so that this can go
>>> to fixes without getting a merge conflict when the rest of the patches
>>> show up...
>>
>> Ping? This is a 5.x regression fix, as such it would be really good to
>> get this into 5.2 and then cherry-picked into 5.y.z.
>>
> 
> It doesn't apply to our fixes branch.

Weird. I will resend the patch rebased on top of 5.2-rc4.

Regards,

Hans
