Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FB16ED4B
	for <lists+platform-driver-x86@lfdr.de>; Tue, 25 Feb 2020 18:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgBYR6c (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Tue, 25 Feb 2020 12:58:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbgBYR6b (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Tue, 25 Feb 2020 12:58:31 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D8D21D7E
        for <platform-driver-x86@vger.kernel.org>; Tue, 25 Feb 2020 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582653511;
        bh=Sva3j0zxk8ZOvePoBklb1lV/d69k6BLltGcoL8zx+i8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XvibRSSoNRmYfm+qIPIN7nGGePEDaM41FlNmAuDbFkQjS98jnypCTx3K7+hk1vN2/
         M/lQCP9nHUXhPsxFFSSFNpzmY/5oXAOoWByYfG7uXgQ6bYNEqrMDvD9uDvFaTSYfzq
         f+9pjizLNvqqgFV8yly2QYf2270oA547XfqE0UTY=
Received: by mail-wm1-f48.google.com with SMTP id t79so108804wmt.3
        for <platform-driver-x86@vger.kernel.org>; Tue, 25 Feb 2020 09:58:30 -0800 (PST)
X-Gm-Message-State: APjAAAWIpOqLIw43T4yy7v0FbcvsAv8IZQ9oC5dAvmOg8Fa0esQyaB4B
        nM+DBraX1iDi6WfxojumHTpAjFpzAH4V3qMhyM63tQ==
X-Google-Smtp-Source: APXvYqxhDCWtAL9XVlcgMQcvnJk1Yjnsuht22saRgp4RLN0yPuLVMLnzI7N2hk/Y4yIm7rpnYZjw7y3JX1RRjlmthUI=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr477751wmk.68.1582653509278;
 Tue, 25 Feb 2020 09:58:29 -0800 (PST)
MIME-Version: 1.0
References: <261ea8108c6290e95962be2638bd204f90787c1c.1582652466.git.thomas.lendacky@amd.com>
 <CAKv+Gu_FJeiaY5yw9=ER4XyBZrDFZ5L4igrqxP6hhJ7Z8easpw@mail.gmail.com> <9e16fed9-4399-5c78-cbfb-6be75c295f31@amd.com>
In-Reply-To: <9e16fed9-4399-5c78-cbfb-6be75c295f31@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Feb 2020 18:58:18 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_0LUY67DwSLU1tyijuF+0mKPpvq1j3RSMy5HBxYE-3qw@mail.gmail.com>
Message-ID: <CAKv+Gu_0LUY67DwSLU1tyijuF+0mKPpvq1j3RSMy5HBxYE-3qw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: Add additional efi tables for unencrypted
 mapping checks
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

On Tue, 25 Feb 2020 at 18:54, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 2/25/20 11:45 AM, Ard Biesheuvel wrote:
> > On Tue, 25 Feb 2020 at 18:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> When booting with SME active, EFI tables must be mapped unencrypted since
> >> they were built by UEFI in unencrypted memory. Update the list of tables
> >> to be checked during early_memremap() processing to account for new EFI
> >> tables.
> >>
> >> This fixes a bug where an EFI TPM log table has been created by UEFI, but
> >> it lives in memory that has been marked as usable rather than reserved.
> >>
> >> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>
> >> ---
> >> Changes since v1:
> >> - Re-spun against EFI tree
> >
> > Which one? Surely not the one in the link I included?
>
> I did a git clone of
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
>
> and checked out branch next. Not sure what I missed...
>

Weird. Do you see commit 5d288dbd88606d8f215c7138b10649115d79cadd on
that branch? It removes rng_seed from struct efi, hence my request to
rebase your patch.

IMO, best is to simply drop the 'static' from rng_seed, rename it to
efi_rng_seed, and drop an extern declaration in linux/efi.h so it is
accessible from your code. I'm reluctant to put it back in struct efi.
