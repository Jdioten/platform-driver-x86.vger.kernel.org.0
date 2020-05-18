Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FD21D71FC
	for <lists+platform-driver-x86@lfdr.de>; Mon, 18 May 2020 09:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgERHgh (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 18 May 2020 03:36:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21576 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbgERHgg (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 18 May 2020 03:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589787393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxahqT/LB/gKtsCv/S2+hQFfwmIb9ycLMKz+VyULbsI=;
        b=arMuVYrwCqfWoMDXL0PHyDHQhX4zwsTpG5PkOK7kDR1DpeGnX69jpk+w7/PonKT4UDTKSr
        0CkPxQADIIMMBKBzRt1NtooS3651AuLH+0ZYfbAz82scX32ghWWPpuraE45M2Fz3frhFWY
        PyDP41/J+ldqtwzP06GHCtoDt/W0SQ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-1aoboFFWNxihBMJUvZxe9Q-1; Mon, 18 May 2020 03:36:31 -0400
X-MC-Unique: 1aoboFFWNxihBMJUvZxe9Q-1
Received: by mail-wr1-f69.google.com with SMTP id e14so5232613wrv.11
        for <platform-driver-x86@vger.kernel.org>; Mon, 18 May 2020 00:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lxahqT/LB/gKtsCv/S2+hQFfwmIb9ycLMKz+VyULbsI=;
        b=T9A7QvZZ5gyGggyNn8uPSs73eu8CIP0iXhuNsxVeWwfhHJlVbBf2QhNxvP6oeGfLDX
         es/E+h5GxrKGmrUxJs393dlipw24ZrpG9/6eHXJqUV95OOcYOKi5y0MWU6vJQdCy6R+c
         /EEpoMcvVvOe9Oh4Ttm6oWPWNOrtyV7My6BZg8/psFcjKf/S8QNKquKVP5zdzRVZnU52
         UX0Xd/vyLywRiBjgZ0MfCWImX+wmEhLjY9wz0OxvS2qllGkru/NMDwe6VIzoNRflp/gX
         NJs3GTxD09gxQ057Nck5c92ppXlemVzuW+htMwF2osNIQ4bX6taM28MBuOhMr/vXTuVy
         X6qA==
X-Gm-Message-State: AOAM5308mYJ6JteEaiwj9uydNX4tb0CdweJVp/2IJZ8DUClAxaxXYzTO
        mcBINogydCDHJf6CgHV43JcxdnB2u9+dDQlMU+rUo+O1GJbinqh3wj2YjQ1hq1gbpsD4E61UCZJ
        cQk1whfXWoRmmbtaVXPBxougxSp2vJVAjtQ==
X-Received: by 2002:adf:eb47:: with SMTP id u7mr8924143wrn.14.1589787390564;
        Mon, 18 May 2020 00:36:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz0SpVMXYaTfwKekGOfJXbmR9UFXcUMo3vR6hnkieQoqI8Z+UsfvdG56sJulcbF8oH7Hmmxg==
X-Received: by 2002:adf:eb47:: with SMTP id u7mr8924093wrn.14.1589787390194;
        Mon, 18 May 2020 00:36:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id f123sm15586970wmf.44.2020.05.18.00.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 00:36:29 -0700 (PDT)
Subject: Re: [PATCHv2 0/7] Support inhibiting input devices
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Peter Hutterer <peter.hutterer@redhat.com>,
        Benjamin Tissoires <btissoir@redhat.com>
References: <20200506002746.GB89269@dtor-ws>
 <20200515164943.28480-1-andrzej.p@collabora.com>
 <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
 <20200517225510.GA205823@koala> <20200518024034.GL89269@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4eb8f557-370f-03bb-9a1d-3652d0ac8b08@redhat.com>
Date:   Mon, 18 May 2020 09:36:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518024034.GL89269@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Hi,

On 5/18/20 4:40 AM, Dmitry Torokhov wrote:
> Hi Hans, Peter,
> 
> On Mon, May 18, 2020 at 08:55:10AM +1000, Peter Hutterer wrote:
>> On Fri, May 15, 2020 at 08:19:10PM +0200, Hans de Goede wrote:
>>> Hi Andrezj,
>>>
>>> On 5/15/20 6:49 PM, Andrzej Pietrasiewicz wrote:
>>>> Userspace might want to implement a policy to temporarily disregard input
>>>> from certain devices, including not treating them as wakeup sources.
>>>>
>>>> An example use case is a laptop, whose keyboard can be folded under the
>>>> screen to create tablet-like experience. The user then must hold the laptop
>>>> in such a way that it is difficult to avoid pressing the keyboard keys. It
>>>> is therefore desirable to temporarily disregard input from the keyboard,
>>>> until it is folded back. This obviously is a policy which should be kept
>>>> out of the kernel, but the kernel must provide suitable means to implement
>>>> such a policy.
>>>
>>> Actually libinput already binds together (inside libinput) SW_TABLET_MODE
>>> generating evdev nodes and e.g. internal keyboards on devices with 360Ã‚Â°
>>> hinges for this reason. libinput simply closes the /dev/input/event#
>>> node when folded and re-opens it when the keyboard should become active
>>> again. Thus not only suppresses events but allows e.g. touchpads to
>>> enter runtime suspend mode which saves power. Typically closing the
>>> /dev/input/event# node will also disable the device as wakeup source.
>>>
>>> So I wonder what this series actually adds for functionality for
>>> userspace which can not already be achieved this way?
>>
>> Thanks Hans. To expand on this:
>> libinput has heuristics to guess which input devices (keyboards, touchpads)
>> are built-in ones. When the tablet mode switch is on, we disable these
>> devices internally (this is not visible to callers), and re-enable it again
>> later when the tablet mode switch is off again.
> 
> I think that is great that libinput has tried solving this for the
> tablet mode, but unfortunately libinput only works for users of
> libinput, leaving cases such as:
> 
> 1. In-kernel input handlers, such as SysRq, VT and others
> 2. Systems that do not rely on libinput for userspace handing (Android,
> Chrome OS)
> 3. Systems with policies that are more complex than tablet mode only.
> 
> Because of libinput's inability to affect the kernel, and the presence
> of "always on" input handlers (sysrq, VT keyboard, potentially others),
> while libinput may control whether consumers receive events from certain
> input devices, it will not allow power savings that an explicit
> "inhibit" allows when coming from dedicated power policy manager.

Ok, the sysrq and vt keyboard handlers keeping the device open and thus
make it keep using power is a valid reason for a separate inhibit mechanism.

> I think pushing policy decisions into a library, and trying to have all
> clients agree with it, is much harder and leaks unnecessary knowledge
> into quite a few layers. A dedicated power policy manager, that is not
> only responsible for input device, but power state of the system as a
> whole, is a very viable architecture.

Well AFAIK the kernel-policy has always been to leave policy decisions
up to userspace as much as possible, but this just adds a mechanism to
implement the policy so that is fine.

>> This is done for keyboards and touchpads atm (and I think pointing sticks)
>> and where the heuristics fail we have extra quirks in place. For example
>> the Lenovo Yogas tend to disable the keyboard mechanically in tablet mode
>> but buttons (e.g. volume keys) around the screen send events through the
>> same event node. So on those devices we don't disable the keyboard.
>>
>> We've had this code for a few years now and the only changes to it have been
>> the various device quirks for devices that must not suspend the keyboard,
>> it's otherwise working as expected.
>>
>> If we ever have a device where we need to disable parts of the keyboard
>> only, we could address this with EVIOCSMASK but so far that hasn't been
>> necessary.
>>
>> I agree with Hans, right now I don't see the usefulness of this new sysfs
>> toggle. For it to be really useful you'd have to guarantee that it's
>> available for 100% of the devices and that's IMO unlikely to happen.
> 
> The inhibiting of the events works for 100% of input devices, the power
> savings work for the ones that implement it. It is responsibility of
> folds shipping the systems to make sure drivers they use support inhibit
> if they believe it will help their battery life.
> 
>>
>> Cheers,
>>     Peter
>>
>>> I also noticed that you keep the device open (do not call the
>>> input_device's close callback) when inhibited and just throw away
>>> any events generated. This seems inefficient and may lead to
>>> the internal state getting out of sync. What if a key is pressed
>>> while inhibited and then the device is uninhibited while the key
>>> is still pressed?  Now the press event is lost and userspace
>>> querying the current state will see the pressed key as being
>>> released.
> 
> This is a good point. We should look into signalling that some events
> have been dropped (via EV_SYN/SYN_DROPPED) so that clients are aware of
> it.
> 
>>>
>>> On top of this you add special inhibit and uninhibit callbacks
>>> and implement those for just a few devices. How do these differ
>>> from just closing the device and later opening it again ?
> 
> I believe majority will simply reuse open/close callbacks. In Chrome OS
> we have dedicated inhibit/uninhibit, but I would like to allow using
> open/close as alternatives.

Ack, maybe some driver flag to just call close on inhibit and
open on unhibit (also taking input_device.users into account of course) ?

>>> Also using a sysfs property for this is very weird given that the
>>> rest of the evdev interface is using ioctls for everything...
> 
> This is not evdev interface, it is at the level above evdev (so that it
> can affect all handlers, not only evdev). As such it is not bound by
> evdev interface.

Ok I can see how on some systems the process implementing the policy
of when to inhibit would be separate from the process which has the
device open. But in e.g. the libinput case it would be good if
libinput could activate any potential power-savings by setting
the inhibit flag.

The problem with sysfs interfaces is that they typically require
root rights and that they are not really compatible with FD
passing. libinput runs as a normal user, getting a fd to the
/dev/input/event# node passed by systemd-logind.

As said I can see the reason for wanting a sysfs attribute for
this, can we perhaps have both a sysfs interface and an ioctl?

Note both could share the same boolean in the kernel, it would be
up to userspace to not try and write to both. E.g. chrome-os
would use the sysfs attr, libinput would use the ioctl.

Regards,

Hans

