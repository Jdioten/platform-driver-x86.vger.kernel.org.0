Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBFFBF62D
	for <lists+platform-driver-x86@lfdr.de>; Thu, 26 Sep 2019 17:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfIZPsB (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Thu, 26 Sep 2019 11:48:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52612 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfIZPsB (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Thu, 26 Sep 2019 11:48:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so3354379wmh.2
        for <platform-driver-x86@vger.kernel.org>; Thu, 26 Sep 2019 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/3rZGyZ8wo8IAcGiILpVEqgSPsTH+XHREiJwrwJZ0c=;
        b=U88hSCSVdES0JklNpygW7AUNISvDUWxqvq4/RSOySBI5RzuSv+bpqM+wTTWfEgN470
         gpWs4NWRtg1KSgUlo1WODgHYlyEzsJCwy2XgdvfzaGF7tyj8UG3Cy33jvIZNQ9756JvX
         1LeIfEYrSH2efSPIn9ouNdEhhcFvJsuyAipddSXiF9WT9a9mopnxOIST9ZA+6sO3tZAK
         AVPMuSa/OpgLP+yEGoxFMsCHt46w6mASVKwB1PexFBAeghG4VYEHVzI5C4WLILW6AM27
         kwNcJaxbNdYrbcX4EdTYGMlowktBAefXRD8GaHicfkXcwspN7u5wR5AnDdvGdeEemsVO
         2hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/3rZGyZ8wo8IAcGiILpVEqgSPsTH+XHREiJwrwJZ0c=;
        b=cMOviQPlW0qHyeRHUVVI7yTfhjz8oZzDFYYZ2bTU3Pqpe0H66hd5x3NIyNNqTtfj+V
         cIUSySxC8zgzu4bqI8psqEhv1C2n29nXLq0KgcvsjNw7YNSM1GXDmJVgT0dsTVYf7wjo
         gdhvFIWlbvfgnaHjP9DyMQOY/1rwRp+C6oRt06M0oIS0VI5hnr4JOJALWwFuTL6l0dqA
         TJAiyjQpooAY8HFtrpQtbIthIVg6sbDotodm34syOQyo8/WmYOWs6qdisGg9RYf7r8+j
         dTtVFBO6eUDzZZZf3bFE+norS35AligyCbjtC9Sv3sP0Y2Y3EKFtZR2yaFORLO1+w/ZD
         Dsqg==
X-Gm-Message-State: APjAAAUBkP7trbiuMbf/lpEAo/0XAEDGc60iTioU5id7KE9npU9djqeC
        nX4RAK4tUfNN0p/IURvpsyaMaPF3J7xWAwR/JJau5w==
X-Google-Smtp-Source: APXvYqwg/Q6oCeFIWzSC1GJg9f91HyLzsXgfBri1ybbR91Ec6CKH3zjayo1IQXAKjEjd8xJkw8PBdgzNIcv/LyEcR7M=
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr3407725wma.119.1569512879378;
 Thu, 26 Sep 2019 08:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190926141234.8271-1-ross.lagerwall@citrix.com>
 <CAKv+Gu8ok=v6WaKWW1AmhPgf1-n7p=4h8Tkno9YNW6H8p4fg8w@mail.gmail.com> <be816ae1-b802-f477-20d0-16e5be15a2b8@citrix.com>
In-Reply-To: <be816ae1-b802-f477-20d0-16e5be15a2b8@citrix.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 26 Sep 2019 17:47:47 +0200
Message-ID: <CAKv+Gu_j=Nb_Q92vVcqyE_FBos76ZG0=hGZwSNuG2sL1ZYsxXw@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Don't require non-blocking EFI callbacks
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

On Thu, 26 Sep 2019 at 17:47, Ross Lagerwall <ross.lagerwall@citrix.com> wrote:
>
> On 9/26/19 4:29 PM, Ard Biesheuvel wrote:
> > On Thu, 26 Sep 2019 at 16:12, Ross Lagerwall <ross.lagerwall@citrix.com> wrote:
> >>
> >> If a backend does not implement non-blocking EFI operations, it implies
> >> that the normal operations are non-blocking.
> >
> > Is that documented anywhere?
>
> Sort of. From commit 6d80dba1c9fe "efi: Provide a non-blocking
> SetVariable() operation"
>
> """
> Introduce ->set_variable_nonblocking() for this use case. It is an
> optional EFI backend operation, and need only be implemented by those
> backends that usually acquire locks to serialize access to EFI
> variables, as is the case for virt_efi_set_variable() where we now grab
> the EFI runtime spinlock.
> """
>
> >
> >> Instead of crashing
> >> dereferencing a NULL pointer, fallback to the normal operations since it
> >> is safe to do so.
> >>
> >
> > I agree that crashing is never the right thing to do, but I wonder
> > whether we shouldn't just bail instead. If the provided default
> > operation is non-blocking, the platform can populate the function
> > pointer with a reference to the default implementation.
>
> If you would prefer it that platforms are always required to implement
> the non-blocking functions, then I will just send a simple patch fixing
> up the Xen implementation.
>

Yes, please, that sounds like a safer option to me.
