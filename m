Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7984EFCFD6
	for <lists+platform-driver-x86@lfdr.de>; Thu, 14 Nov 2019 21:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKNUsp (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Thu, 14 Nov 2019 15:48:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24205 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726592AbfKNUso (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Thu, 14 Nov 2019 15:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573764523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4B6rfmtv2Qt+9DfwNYqiCu2HEO09fbhcXd54eFBcgs=;
        b=B6oAHm6aEGaQ33EY4BjnZp64dfKMlN4jEC17B+DMKJSZ5VOmgxMLHycj0ac+tsZqN+NZxq
        PQmbuCtmbw/ntOiS/qjy+f8ogUru4vH9UcqQgKO/tfx2+6ms8SpoS9A/gLg73XjDjjW9Pq
        rKOigYga6ACmPkjlohUzoQ8q5FZFZBs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-NpVjGHj5MgOeFDepL7aRJA-1; Thu, 14 Nov 2019 15:48:42 -0500
Received: by mail-wr1-f72.google.com with SMTP id h7so5517852wrb.2
        for <platform-driver-x86@vger.kernel.org>; Thu, 14 Nov 2019 12:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SG38e6rn6sWVYD6nEtXoWfLrsm5oi0uDjlI4qnmFxyI=;
        b=XG7odbPW+A2H2uvh4ApOV6OG7/zqGq/qPhhw61rVsgdQGzuLVl2VOLFe0b0na2ZvF9
         w1lT1LMwcxSJHpoKjmeoL6wRkGcb0OX51lRstb0ZuvBzkE5yGK4eNZ5156Oz9fDzZVZE
         o0nUyLhTAZOJdY2U/rI5zTgZ29ig3MHlEEKECYBYrUEovotgG5hqRPgiROKQEWoxgOz5
         cHa1Dbzdqw7PvO4XoJJegOkYONCBO6oJQQzFaM9XFXcJJrnm5qqtw/GcUxLCERmv52PY
         yTPI/rr/uZBfggyVMTIPip4bAJd2pGVfYVzWpFAVun1cAmwgFmQCj1ob9uyQt7rlaXJ3
         WxjA==
X-Gm-Message-State: APjAAAVRbrcB0P1I9SM44Rb7tx+FyV6xMdGvN5PSCDbJYvGL3OJ7NQpx
        29n2fMFIB8kS+eWCDpJuhN9op2DZmMbajV5F1TvX4MLEpuGexD9lczMj+rJTqsmbxd0/58epIL4
        CNkg0Etaw7Ww0DxppSYDgDhP/FhHGOpgHxA==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr10084258wrs.86.1573764521111;
        Thu, 14 Nov 2019 12:48:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQ9pjh3RE3RyLPfgQ0X+rKHYvPgNDppJzxUIq6hmxR7oOINOPj1s5eWmXRkA4hcoyBNvT/uQ==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr10084228wrs.86.1573764520872;
        Thu, 14 Nov 2019 12:48:40 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id f19sm10152403wrf.23.2019.11.14.12.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 12:48:40 -0800 (PST)
Subject: Re: [PATCH v7 2/8] efi: Add embedded peripheral firmware support
From:   Hans de Goede <hdegoede@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-3-hdegoede@redhat.com>
 <20191011144834.GL16384@42.do-not-panic.com>
 <e7bd40ff-20d1-3aed-8516-9fffd4c3a207@redhat.com>
 <20191114194233.GE11244@42.do-not-panic.com>
 <f00804ae-e556-35e4-d0a3-cd9201fdd2d0@redhat.com>
Message-ID: <9b0a0121-3e63-0602-6c0d-00547e389f76@redhat.com>
Date:   Thu, 14 Nov 2019 21:48:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <f00804ae-e556-35e4-d0a3-cd9201fdd2d0@redhat.com>
Content-Language: en-US
X-MC-Unique: NpVjGHj5MgOeFDepL7aRJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Hi,

On 14-11-2019 21:13, Hans de Goede wrote:
> Hi,
>=20
> On 14-11-2019 20:42, Luis Chamberlain wrote:
>> On Thu, Nov 14, 2019 at 12:27:01PM +0100, Hans de Goede wrote:
>>> Hi Luis,
>>>
>>> Thank you for the reviews and sorry for being a bit slow to respind.
>>>
>>> On 11-10-2019 16:48, Luis Chamberlain wrote:
>>>> On Fri, Oct 04, 2019 at 04:50:50PM +0200, Hans de Goede wrote:
>>>>> +static int __init efi_check_md_for_embedded_firmware(
>>>>> +=A0=A0=A0 efi_memory_desc_t *md, const struct efi_embedded_fw_desc *=
desc)
>>>>> +{
>>>>> +=A0=A0=A0 const u64 prefix =3D *((u64 *)desc->prefix);
>>>>> +=A0=A0=A0 struct sha256_state sctx;
>>>>> +=A0=A0=A0 struct embedded_fw *fw;
>>>>> +=A0=A0=A0 u8 sha256[32];
>>>>> +=A0=A0=A0 u64 i, size;
>>>>> +=A0=A0=A0 void *map;
>>>>> +
>>>>> +=A0=A0=A0 size =3D md->num_pages << EFI_PAGE_SHIFT;
>>>>> +=A0=A0=A0 map =3D memremap(md->phys_addr, size, MEMREMAP_WB);
>>>>
>>>> Since our limitaiton is the init process must have mostly finished,
>>>> it implies early x86 boot code cannot use this, what measures can we
>>>> take to prevent / check for such conditions to be detected and
>>>> gracefully errored out?
>>>
>>> As with all (EFI) early boot code, there simply is a certain order
>>> in which things need to be done. This needs to happen after the basic
>>> mm is setup, but before efi_free_boot_services() gets called, there
>>> isn't really a way to check for all these conditions. As with all
>>> early boot code, people making changes need to be careful to not
>>> break stuff.
>>
>> I rather we take a proactive measure here and add whatever it is we need
>> to ensure the API works only when its supposed to, rather than try and
>> fail, and then expect the user to know these things.
>>
>> I'd prefer if we at least try to address this.
>=20
> This is purely internal x86/EFI API it is not intended for drivers
> or anything like that. It has only one caller under arch/x86 and it is
> not supposed to get any other callers outside of arch/* ever.
>=20
> Note that this all runs before even core_initcall-s get run, none
> if the code which runs before then has any sort of ordering checks
> and I don't see how this bit is special and thus does need ordering
> checks; and there really is no mechanism for such checks so early
> during boot.
>=20
> The drivers/firmware/efi/embedded-firmware.c file does add some API
> which can be used normally, specifically the efi_get_embedded_fw()
> but that has no special ordering constrains and it does not directly
> use the function we are discussing now. It reads back data stored
> by the earlier functions; and if somehow called before those functions
> run (*), then it will simply return -ENOENT.

Ok, I just realized that we may have some miscommunication here,
when you wrote:

"Since our limitation is the init process must have mostly finished,
  it implies early x86 boot code cannot use this, what measures can we
  take to prevent / check for such conditions to be detected and
  gracefully errored out?"

I assumed you meant that to apply to the efi_check_md_for_embedded_firmware=
()
helper or its caller.

But I guess what you really want is some error to be thrown if someone
calls firmware_request_platform() before we are ready.

I guess I could make efi_check_for_embedded_firmwares() which scans
for known firmwares and saved a copy set a flag that it has run.

And then combine that with making efi_get_embedded_fw() (which underpins
firmware_request_platform()) print a warning when called if that flag
is not set yet.

That would mean though that some code which runs earlier then
a core_initcall would, would call firmware_request_platform() and
such code is generally expected to know what they are doing.

I just checked and the cpu microcode stuff which comes to mind
for this uses a late_initcall so runs long after efi_get_embedded_fw()
and I have a feeling that trying to use the fw_loader before
core_initcalls have run is going to end poorly anyways.

Still if you want I can add a pr_warn or maybe even a WARN_ON
to efi_get_embedded_fw() in case it somehow gets called before
efi_check_for_embedded_firmwares().

Regards,

Hans

