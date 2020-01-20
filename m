Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED71428F9
	for <lists+platform-driver-x86@lfdr.de>; Mon, 20 Jan 2020 12:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgATLM7 (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 20 Jan 2020 06:12:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45256 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgATLM7 (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 20 Jan 2020 06:12:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so29055978wrj.12
        for <platform-driver-x86@vger.kernel.org>; Mon, 20 Jan 2020 03:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HlltTZpAEDLvscRb688hqMcZim5skpAdya8N3DvxZEM=;
        b=UXD+EDxFhXSrpENIh2A/85v6fyes50rL1DiydfBrrvhrh6DNi9F+AYVNeheFVXBxCJ
         rGaRLMVLeDk7c9vYNEQ6xdXdgeJPqbLah7k34UX9s6IFGZTDtVmaTFFdMbqTrDW5LNCM
         hU19egfqAtCu6kYb2IvHL2KT8v7Gn612jjhrAVh5NxbkhO46gNGG2Z5TKQvoi4yMZipc
         EK5jOZ8a2x12A0c27EKdljk+Ea/kU/GzLZdwxlC/FrBdhL1R/6pf86oBjHi7R4TngeEX
         Uh3A0Uceu9xjf7K1PCKrA8imYxWxO2zlRJKdJ/mc4TfYME1FKfO7F7AFWZZXSgDJa8W8
         +Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HlltTZpAEDLvscRb688hqMcZim5skpAdya8N3DvxZEM=;
        b=tH+fhELVekb2ln/lJoHCu3knlJwirsSkxgeeiTLylEYXgZuZvlNVk6GBaKcD6uyhPV
         cttrNeGyYNhgDH2vgq5psG1ugVbVNItqbLmhv8Duv9XoTu/oWdp4CvjlK/U0emVBL49d
         naajIo1K3amFzXy5l8cv1bB6DT2hHncEWajA2Vackn3JIu0JGTQTJGsFxU6mlILso9B2
         WJAelNsBvPhvDoGffyqXEOSYG7qFXWX+s0OSeEi77irRG/CSyiU6bEiEN25Oc024UmHf
         PMPmBok+oh72MTBsbRQLEW+z4UGMoAM0OeTxRqDcDkt7gxC5Oio8cIjDPuXqd2myzaGJ
         m02w==
X-Gm-Message-State: APjAAAXWZ8Mw0QFOa3SL1si/gt4gBfQG+/J938QYr3HUQZzgf+3Khs85
        6MDvSa3MpVhlNTodmltFYc0Q8g==
X-Google-Smtp-Source: APXvYqxQHGbEwEkD/O3AcaNIUudE99Tt5DRIuc3ysO5EJhjUT1/um+Fyx5PMGE3tKu56OqMRzGjN5A==
X-Received: by 2002:a5d:480f:: with SMTP id l15mr17182858wrq.305.1579518777252;
        Mon, 20 Jan 2020 03:12:57 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id g9sm47501170wro.67.2020.01.20.03.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:12:56 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:13:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 35/36] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200120111312.GD15507@dell>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
 <20200113135623.56286-36-mika.westerberg@linux.intel.com>
 <20200116132108.GH325@dell>
 <20200116143730.GE2838@lahna.fi.intel.com>
 <20200117113202.GH15507@dell>
 <20200120092650.GI2665@lahna.fi.intel.com>
 <20200120111159.GC15507@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200120111159.GC15507@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

> Adding Mark (the Regmap Maintainer) to the conversation.

Fingers faster than brain!

I'll actually add him this time - sorry for the noise!

> On Mon, 20 Jan 2020, Mika Westerberg wrote:
> > On Fri, Jan 17, 2020 at 11:32:02AM +0000, Lee Jones wrote:
> > > [...]
> > > 
> > > > > Looks like Regmap could save you the trouble here.
> > > > 
> > > > Agreed.
> > > 
> > > Great.
> > 
> > I started to implement regmap for this driver but I run into some
> > problems. The registers we read/write are all 64-bit and accessed trough
> > readq/writeq accessors. However, the regmap API takes unsigned int:
> > 
> >   int regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
> >   int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
> > 
> > I'm not sure how we can take advantage of this API with the 64-bit
> > registers. There are "raw" versions of the functions that take void
> > pointer like:
> > 
> >  int regmap_raw_read(struct regmap *map, unsigned int reg,
> >                      void *val, size_t val_len);
> > 
> > but looking at the implementation if the register gets cached it
> > internally does reads in unsigned int sized chunks (if I understand it
> > right).
> > 
> > Any ideas how this can be done?
 
Mark,

  Does Regmap support 64bit accesses?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
