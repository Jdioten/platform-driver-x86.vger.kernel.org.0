Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659C21ADBA8
	for <lists+platform-driver-x86@lfdr.de>; Fri, 17 Apr 2020 12:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgDQK4K (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Fri, 17 Apr 2020 06:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729908AbgDQK4H (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Fri, 17 Apr 2020 06:56:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB56C061A0C
        for <platform-driver-x86@vger.kernel.org>; Fri, 17 Apr 2020 03:56:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a81so2498323wmf.5
        for <platform-driver-x86@vger.kernel.org>; Fri, 17 Apr 2020 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Zy7B31yVbo24Z3sSwOmI0rE3FMjeyfjDv352hxUkToU=;
        b=sdM56yL6/sZg7Jddl9k0izO39qBUzuzsdNoFJjuGk7smxTdU4SBNE5mevCf8LoiCfi
         8avOtHMfgdjO4CdrlsZLVLNWbiW9gjYyH5QxZGAnLBR38EzcK77BU61Q5R8Ip4UiueEC
         QOa6+6TIJp7q8TsGM0iZKF2JgoHbAq1y+eMiCB4DyfZnoY52PmrRVlPF4Xf7SQqVUjMa
         jTZtluk1GKkPwLT69x5df69+flCiPzQ1g0lL4I/lKyu/pcPFDJJzt6YGni3NlUHxvrEC
         JJCbAsg+2Vz8I8GvwIBxRQhaaI0KETDACgk1gspI90r688Vx9NwSI3Hqp0fzw4MCqkra
         nVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Zy7B31yVbo24Z3sSwOmI0rE3FMjeyfjDv352hxUkToU=;
        b=bxb2h3lOUi7RhhNQdbMJYCBL66+IKzrmiRO/MEMT8zP5w7bLejKBdTTJAxhzmpNdI2
         b1C0CJP9MB6P/VsaVMHzBEw0aNrdI75EoPXJ0Ym7ROShu/esIYBJy3yPDWRhFJlFSX7m
         MSTzVIB7Pxz2fM4gADH8Vl5CRznkuqwyHo1w8XmycKzVhJgbD2QpvZUwlKhSHKVUQPlM
         TZBGujztFqoXorrdrw/bbyqT0M9Lb8+5/HQEZJvd+/nEFUhfTUa8rsD+O5nXrWIs07nG
         EiNRGZ3pOQPFSm+vaUQ8ZfBAjrWbs9XStk+2biKKAy2CGAcd2AzAOPPDajg2B0gfAI6p
         FxTw==
X-Gm-Message-State: AGi0PublX5o6b7rs9jV/qB5axeaBC82RWIcA+so6YaNwhbSExdXXgkmp
        hHEFGu0oOpopPEHUJ8SjnBp9Y4H2KW8=
X-Google-Smtp-Source: APiQypKpvJGamn20c9w6PhxX78HILd35jS6h/JDY9Q5LuEqNOc6YBop+EvV1mgFml8+qiNKp0yb9og==
X-Received: by 2002:a1c:4b16:: with SMTP id y22mr2792717wma.170.1587120963825;
        Fri, 17 Apr 2020 03:56:03 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id b66sm7293958wmh.12.2020.04.17.03.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 03:56:03 -0700 (PDT)
Date:   Fri, 17 Apr 2020 11:57:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 19/20] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200417105704.GE3737@dell>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
 <20200416081552.68083-20-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416081552.68083-20-mika.westerberg@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

On Thu, 16 Apr 2020, Mika Westerberg wrote:

> This driver only creates a bunch of platform devices sharing resources
> belonging to the PMC device. This is pretty much what MFD subsystem is
> for so move the driver there, renaming it to intel_pmc_bxt.c which
> should be more clear what it is.
> 
> MFD subsystem provides nice helper APIs for subdevice creation so
> convert the driver to use those. Unfortunately the ACPI device includes
> separate resources for most of the subdevices so we cannot simply call
> mfd_add_devices() to create all of them but instead we need to call it
> separately for each device.
> 
> The new MFD driver continues to expose two sysfs attributes that allow
> userspace to send IPC commands to the PMC/SCU to avoid breaking any
> existing applications that may use these. Generally this is bad idea so
> document this in the ABI documentation.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |  22 +
>  arch/x86/include/asm/intel_pmc_ipc.h          |  47 --
>  arch/x86/include/asm/intel_telemetry.h        |   1 +
>  drivers/mfd/Kconfig                           |  16 +-
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/intel_pmc_bxt.c                   | 468 +++++++++++++
>  drivers/platform/x86/Kconfig                  |  16 +-
>  drivers/platform/x86/Makefile                 |   1 -
>  drivers/platform/x86/intel_pmc_ipc.c          | 645 ------------------
>  .../platform/x86/intel_telemetry_debugfs.c    |  12 +-
>  drivers/platform/x86/intel_telemetry_pltdrv.c |   2 +
>  drivers/usb/typec/tcpm/Kconfig                |   2 +-
>  drivers/watchdog/iTCO_wdt.c                   |  25 +-
>  include/linux/mfd/intel_pmc_bxt.h             |  53 ++
>  include/linux/platform_data/itco_wdt.h        |  11 +-
>  15 files changed, 602 insertions(+), 720 deletions(-)
>  create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
>  delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
>  create mode 100644 drivers/mfd/intel_pmc_bxt.c
>  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
>  create mode 100644 include/linux/mfd/intel_pmc_bxt.h

Looks good to me know.

Thanks for taking the time to realise my review comments.

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
