Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE920E132
	for <lists+platform-driver-x86@lfdr.de>; Mon, 29 Jun 2020 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgF2UxB (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 29 Jun 2020 16:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbgF2TNX (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:23 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C311CC08EE2B
        for <platform-driver-x86@vger.kernel.org>; Mon, 29 Jun 2020 00:19:51 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id n137so3493866vkf.7
        for <platform-driver-x86@vger.kernel.org>; Mon, 29 Jun 2020 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUO3+r2sFoXJJwwAqV9c0Q0ogOkw7+fslU8OhD00s94=;
        b=j6sxctFKb1mJwmXECAuxRFxfkqkfbZ1kOAtfSNS8rj2MadohBjSiToURKEtzZVv/p2
         iUce2+4PqZNXqvUh7nf4X1mEVbbXUmaFDTTYMxg40OwPdijDO6g1WrQty40shNaKk6zM
         Ik2xyBqi84PaQ9TCQ4ibRR1SMrBhgbe+Oz9DEVZgLPgpvP6sJolPmBjojhvt6Y5ymQRl
         XeEbGtbZbcJMCA6gWSsrnzZfSfjCt6wFFf1Xnsa79SFK3medZIqtPagRwJOdtppBNK0w
         W7K7ctJxA8JDaVu8Ea6+frG9WizNm1YAcuxJBjIlt5SIhWFdOzP4CCrTKdu37oYl/N+H
         OOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUO3+r2sFoXJJwwAqV9c0Q0ogOkw7+fslU8OhD00s94=;
        b=inmd8bFnJW3n501+MqB8nlvzSVhzvOEo+PcYVq5XABpaC6j78BHoM2x6s+zA87DHDj
         zYLWm81vp2hb3Hd4jVTkjoI8NPnMNp9NPDlKzU2lSrlhemw8QmbEBF9KjrtWGm3ceWuw
         hKJtF2QM3ns3LUB2xIe2nR1WZ3bzoLsaEQjXhNgAecAl6YftnzVU9hQgu2WS32MiEgWN
         86tnt54p/d1yK6oCuSHNHoNgCCws/wweo3KjDZD6Caa4yqggJwJXVijv/WR1ihYUbJLI
         2xDG7/tN36ohzl5wFG2ZHLZeaMoRh/adrD7H6Wu7JZgCuIh0Dg3Fvs0HEOtM/L15xZyx
         Qkcw==
X-Gm-Message-State: AOAM531OZTyo0F7BgNpZATEJ301WN2Y3mmQnZKIPd3WCvaZ3D/p9i+X+
        1p7FYcsXuGMqekR5GimJXqJiHZXSZgoWcu7dIscm4A==
X-Google-Smtp-Source: ABdhPJwykMxdCaunCw+6cjgT17VrZ+LKonlUMsHr7L1u0M4VXGQWOJZGkC2m5oFMwQFDbqUfYt7EG/cDnAZ+aaTq/ZA=
X-Received: by 2002:ac5:c189:: with SMTP id z9mr9141504vkb.79.1593415190948;
 Mon, 29 Jun 2020 00:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <9cbffad6-69e4-0b33-4640-fde7c4f6a6e7@linaro.org>
 <20200626173755.26379-1-andrzej.p@collabora.com> <20200626173755.26379-2-andrzej.p@collabora.com>
In-Reply-To: <20200626173755.26379-2-andrzej.p@collabora.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 29 Jun 2020 12:49:39 +0530
Message-ID: <CAHLCerOi-rme0p7gmPdzmMgDRkj8jVn5Skkh0d5FMVO+-BqOBA@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] acpi: thermal: Fix error handling in the
 register function
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Vishal Kulkarni <vishal@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Peter Kaestle <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

On Fri, Jun 26, 2020 at 11:08 PM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> The acpi_thermal_register_thermal_zone() is missing any error handling.
> This needs to be fixed.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  drivers/acpi/thermal.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 19067a5e5293..6de8066ca1e7 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -901,23 +901,35 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>         result = sysfs_create_link(&tz->device->dev.kobj,
>                                    &tz->thermal_zone->device.kobj, "thermal_zone");
>         if (result)
> -               return result;
> +               goto unregister_tzd;
>
>         result = sysfs_create_link(&tz->thermal_zone->device.kobj,
>                                    &tz->device->dev.kobj, "device");
>         if (result)
> -               return result;
> +               goto remove_tz_link;
>
>         status =  acpi_bus_attach_private_data(tz->device->handle,
>                                                tz->thermal_zone);
> -       if (ACPI_FAILURE(status))
> -               return -ENODEV;
> +       if (ACPI_FAILURE(status)) {
> +               result = -ENODEV;
> +               goto remove_dev_link;
> +       }
>
>         tz->tz_enabled = 1;
>
>         dev_info(&tz->device->dev, "registered as thermal_zone%d\n",
>                  tz->thermal_zone->id);
> +
>         return 0;
> +
> +remove_dev_link:
> +       sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
> +remove_tz_link:
> +       sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
> +unregister_tzd:
> +       thermal_zone_device_unregister(tz->thermal_zone);
> +
> +       return result;
>  }
>
>  static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
> --
> 2.17.1
>
