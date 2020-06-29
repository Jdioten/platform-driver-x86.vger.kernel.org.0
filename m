Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8030E20DF9F
	for <lists+platform-driver-x86@lfdr.de>; Mon, 29 Jun 2020 23:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgF2Uie (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 29 Jun 2020 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731754AbgF2TOT (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:19 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B18C09B058
        for <platform-driver-x86@vger.kernel.org>; Mon, 29 Jun 2020 00:20:02 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 64so2428912vsl.3
        for <platform-driver-x86@vger.kernel.org>; Mon, 29 Jun 2020 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLsjiHozNvDgrzZmIQ2WouKu5DGkcV6Zi4pLil1Ar3w=;
        b=ttB2j8EwlPtN89bjJxgTu6zN6r9fAS6dOKjdEH5q5VgMNoawKPbasYLeO6Wib3Imiu
         Txm/pUueF19FSodecKaZf3ZCJfrG2w/E1RbAWvWvaWLmozbRr0o+MyQ7Vxyu66mUVwFe
         /MZk9rP3wex38QGJdlpG8PBJhrr5KQXRJnt7Ook8usx2iRD6oBwGhzP3MrMOF9jCbkfq
         eSr9Kpja5TQMUcLHo5FvLvaFIOmhzprhE5iUWmMHkVkAKT40wuc3HhlD8Mu+pYd20+vk
         8fp8IK3heEU6zqUmyhzEWQIjcRkJvNFJ8lZm1mu5e2bjNw9dQXVcD8D+oPj0s/f4WY+P
         5OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLsjiHozNvDgrzZmIQ2WouKu5DGkcV6Zi4pLil1Ar3w=;
        b=SrAGEAqS2ZhhSSroC2sSV19GHYPa58+4NToH4K+sArroxMuIYzbntka0vquwcYmz9t
         G1yS2Lp3Tyrp28RfK/Velx39iCYL/DAc0jerR0GgYfVsKRsbzLsjTtZQmpQOECTnQiYW
         9/2YGcn3saqyhB7KiJGYOZanDRGsF+rzVok8Jz/wX0b+5mNp/IeH6VvtbIVud2UCL3kv
         1m6x/3K4Xw/JLBkd14lMKl7RjcXnP73Av2YlUJy12psgs328us4ZCbj05K4rXUDiNzVO
         wyBlLWLRbA+HQXIqQYwad8Ail0uJXd8pZ7WuE5H0ebwfjCSkGcKD954xheKBhuU+A3Z3
         Uo/g==
X-Gm-Message-State: AOAM532XUNOA21ejZxKbTd1V4ZGf6vkT4GoT6ruq18Kd3RPzH5pEpMcO
        ZP/YgsH3t+H3Tj3GztBc+7mXd43TEH6Q7wQg04pma0vqZro=
X-Google-Smtp-Source: ABdhPJw1dMYfsxBM8+BKZp4XBDpFgIheslKYpyoIyIHIog2rFo9mF/XWUJd4HbD/zb2zQFhnhGkGFwPawu8DZjqwdrU=
X-Received: by 2002:a67:7f04:: with SMTP id a4mr5058336vsd.9.1593415201875;
 Mon, 29 Jun 2020 00:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <9cbffad6-69e4-0b33-4640-fde7c4f6a6e7@linaro.org>
 <20200626173755.26379-1-andrzej.p@collabora.com> <20200626173755.26379-4-andrzej.p@collabora.com>
In-Reply-To: <20200626173755.26379-4-andrzej.p@collabora.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 29 Jun 2020 12:49:51 +0530
Message-ID: <CAHLCerNXcst72EDWf-xRTdUJ78jMDhhxpf31MO2WPgtJxzv6bA@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] thermal: Add current mode to thermal zone device
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
> Prepare for changing the place where the mode is stored: now it is in
> drivers, which might or might not implement get_mode()/set_mode() methods.
> A lot of cleanup can be done thanks to storing it in struct tzd. The
> get_mode() methods will become redundant.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  include/linux/thermal.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 216185bb3014..5f91d7f04512 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -128,6 +128,7 @@ struct thermal_cooling_device {
>   * @trip_temp_attrs:   attributes for trip points for sysfs: trip temperature
>   * @trip_type_attrs:   attributes for trip points for sysfs: trip type
>   * @trip_hyst_attrs:   attributes for trip points for sysfs: trip hysteresis
> + * @mode:              current mode of this thermal zone
>   * @devdata:   private pointer for device private data
>   * @trips:     number of trip points the thermal zone supports
>   * @trips_disabled;    bitmap for disabled trips
> @@ -170,6 +171,7 @@ struct thermal_zone_device {
>         struct thermal_attr *trip_temp_attrs;
>         struct thermal_attr *trip_type_attrs;
>         struct thermal_attr *trip_hyst_attrs;
> +       enum thermal_device_mode mode;
>         void *devdata;
>         int trips;
>         unsigned long trips_disabled;   /* bitmap for disabled trips */
> --
> 2.17.1
>
