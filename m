Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC12FAD08A
	for <lists+platform-driver-x86@lfdr.de>; Sun,  8 Sep 2019 22:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfIHUH0 (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Sun, 8 Sep 2019 16:07:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42691 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfIHUH0 (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Sun, 8 Sep 2019 16:07:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id u13so8827406lfm.9
        for <platform-driver-x86@vger.kernel.org>; Sun, 08 Sep 2019 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuHIWFdcsxUJqPswaYj4b0GivTB6Jcoizn7SrmAv+OI=;
        b=hpbl52co8tDUVi/7gHuODZirz/kPjg5s1T3Nnm+ujNoC3UW8LeJuFgjmu/QfpDpg6F
         9KL5/fR9vyl6YVuwMxlmHCaPhitd5He6n/wXCO+wtNHY8gG9J6M+aOF6ofQwA0cxvSgq
         xJwLdoNj8/+6d4ae319EYmqQyKdMAiDOnk8BdDMr4nPvyOQ4Y3VurcTOljU1a63qoKOc
         OfzWgjijnGzIXdF0CBAxxaDM3F1mQnCu8BDmc82CqiVRB5AJ5YbcaRruZUOgs4HnWeKe
         YZZWUzgDTPEfUWlQjZsBLu/seUOX81ornseYt+nkA4KJ8zLa7vLu9/GQyej9jXErdvfZ
         Rf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuHIWFdcsxUJqPswaYj4b0GivTB6Jcoizn7SrmAv+OI=;
        b=QL7Q0iPcvm4ZKfvTWOrl55tDsUx1M9j46N0Z4xVZU5w1I7tc6L2Ifj0Ix7e0RDfBQ/
         c8F9xz/2QohXxNWqOwD9eEsLfQMafv6W0q+ca7FRyDN/0roXDxAyRuQrZFM0F9oHpb0/
         xpxUcKePNIN4qYhsXSiRmF9V6ZO77Bi0N3SuM1K41XYRRZvohqp0zPv8TzXy2WTtwY8Q
         U6qq2EQSG7c74lLdpPvPZ8XXfR2y1goTpoZGVeF3Y7zOhNc38kMpFG1BAAgic+X1TSCz
         SomK99r+3omTu00C0duvPIHV8DCUkMVsZGCMXXmCeVA1N2009jtGXPq+ojS0MkzhQqdD
         TRHg==
X-Gm-Message-State: APjAAAXQDgWrT0o/eMs6XJDOoumkwTGHeqFDlfPwfbmopY/EdXnkMtBE
        s3iCtRyX83gF0ZVnfp0p3Cnpm1Oa6SWNJYQWitGukg==
X-Google-Smtp-Source: APXvYqz4xrYJV1IQUAk4dL9wEqpbEkQlxchr8/PvxBR9Y0AhwcXiPbiIw1LJ1wLsH0U4GO0jlz888uTPJr7by6oxYNw=
X-Received: by 2002:ac2:4352:: with SMTP id o18mr14106857lfl.164.1567973244230;
 Sun, 08 Sep 2019 13:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Ver=TNKxh8rdJs1xQYSLNsRLfEoFtcGG6hViug=cF6s_g@mail.gmail.com>
 <20190628033413.8058-1-rajatja@google.com> <CACK8Z6GYwPhz-+7zxxe-aG673Tbin=GYUvVZyL9cTgjqk_EXqA@mail.gmail.com>
 <CAHp75VdPY83U5dWJbca_ZCJwT6z8L+V4R+fY0aZTOkM=vNweYQ@mail.gmail.com>
In-Reply-To: <CAHp75VdPY83U5dWJbca_ZCJwT6z8L+V4R+fY0aZTOkM=vNweYQ@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Sun, 8 Sep 2019 13:06:47 -0700
Message-ID: <CACK8Z6F5wjT0CE2ftjaB0_zEhK+P8UTSmzmzWZS3LD1688kgRw@mail.gmail.com>
Subject: Re: [PATCH v7] platform/x86: intel_pmc_core: Attach using APCI HID "INT33A1"
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

On Sat, Sep 7, 2019 at 10:42 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 23, 2019 at 1:44 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > On Thu, Jun 27, 2019 at 8:34 PM Rajat Jain <rajatja@google.com> wrote:
> > >
> > > Most modern platforms already have the ACPI device "INT33A1" that could
> > > be used to attach to the driver. Switch the driver to using that and
> > > thus make the intel_pmc_core.c a pure platform_driver.
> > >
> > > Some of the legacy platforms though, may still not have this ACPI device
> > > in their ACPI tables. Thus for such platforms, move the code to manually
> > > instantiate a platform_device into a new file of its own. This would
> > > instantiate the intel_pmc_core platform device and thus attach to
> > > the driver, if the ACPI device for the same ("INT33A1") is not present
> > > in a system where it should be. This was discussed here:
> > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html
> >
> >
> > HI Andy, Rajneesh, this seems to have fallen through the cracks. Any
> > comments here on this patch?
>
> % git tag --list v5.3* --contains b02f6a2ef0a1
> v5.3-rc1

Oops, my apologies, I failed to notice it.

Thanks,

Rajat
>
> --
> With Best Regards,
> Andy Shevchenko
