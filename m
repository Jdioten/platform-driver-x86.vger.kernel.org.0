Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F182820E244
	for <lists+platform-driver-x86@lfdr.de>; Tue, 30 Jun 2020 00:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390236AbgF2VDp (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 29 Jun 2020 17:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbgF2TMp (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:45 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8155AC08ED8D
        for <platform-driver-x86@vger.kernel.org>; Mon, 29 Jun 2020 00:05:02 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o15so8634519vsp.12
        for <platform-driver-x86@vger.kernel.org>; Mon, 29 Jun 2020 00:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4CL5jT1tY8QD8FjAFdyHeuWe+dWBhI6iRrYPmWg+K0=;
        b=ufgK5aOt+VEkKCf7cfv7S4ZtNXtnnmklYABTUv1VaPxOyVYlRF0W+WWMz74ZV08AGE
         1s1vKmMq4KVk+MBoFIT07TOKURsUNbRQdevHqaQ1aWm8cwm+U1Imt2LTLVn76ZfauBCL
         Jn8YnNOHw3ZvLP+IWIJlri1ht33n4/CzEON0vrJSMjbdw8TJtfW8X1tddfpQMfXgkCZi
         BtT26G9ckLhBaXLHozdLJ9i2lXgOWfKOEveukc+nllrmwg/ZQ4vjc16Owk1GMoom+Uhd
         EtZSUhps1bb5xV0fHsgJxXJI4qzTSeRxyn0KdrZYD00xOxK3NemGIoaULhoM5HjdHhpi
         jOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4CL5jT1tY8QD8FjAFdyHeuWe+dWBhI6iRrYPmWg+K0=;
        b=LhlkkeTv3nJPLz/OvEs6Gf7HZMRVPqSEgeuDWmxZhhXkaFEACytc6g8RXCswEB/+6h
         gesgVOIQPrGXVqGD0pg4xxbcoIqIGJA8M5irj+Ha8+Pmk3O1fkCKeZU3vTM9Zp5te1Rf
         PstSPeuwQ3TnLIVsn7VfY1avWztzTLmofrKtdjzVn/mHcQTtbFpe1MSEBTujidiw2uQy
         qpfeSMZacFgASzhRrDlYUUwOG8b27ag7BLb/pUAviO9UIgaUXCafutaFEvtykyHzzT56
         B5ahILkCa6LSZuVm/sN+HIH1rlkMLLuUYtJAVShKWL4iJN4zW6GAVRZFux6boezf9dxJ
         9RXg==
X-Gm-Message-State: AOAM531z7nPbEQMRtsbNgd/L/pylA0NZtQGgvjjt+oQCd5hXf8NHX6N1
        bXGamAer1olK0mWPep/FhEtMLOerb4KWXDq9jTnC6g==
X-Google-Smtp-Source: ABdhPJwExycQo0Z3q8vxfUV0tozODXEDNYpnqbSU0LS4IbWtPA6zbYd6g3HijjZDuNICJGxZ+gh7EBDX0w/h/Xyyvro=
X-Received: by 2002:a05:6102:203:: with SMTP id z3mr2837721vsp.182.1593414301322;
 Mon, 29 Jun 2020 00:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <9cbffad6-69e4-0b33-4640-fde7c4f6a6e7@linaro.org>
 <20200626173755.26379-1-andrzej.p@collabora.com> <20200626173755.26379-7-andrzej.p@collabora.com>
In-Reply-To: <20200626173755.26379-7-andrzej.p@collabora.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 29 Jun 2020 12:34:50 +0530
Message-ID: <CAHLCerO2XOOX9akEwaTu_cjSqRycFpNmoVxkSe36L8B4ALWidA@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] thermal: Add mode helpers
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
> Prepare for making the drivers not access tzd's private members.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> [EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL]
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/thermal/thermal_core.c | 53 ++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h        | 13 +++++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 14d3b1b94c4f..3181295075b9 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -459,6 +459,59 @@ static void thermal_zone_device_reset(struct thermal_zone_device *tz)
>         thermal_zone_device_init(tz);
>  }
>
> +int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
> +                                enum thermal_device_mode mode)

Should this be static?

> +{
> +       int ret = 0;
> +
> +       mutex_lock(&tz->lock);
> +
> +       /* do nothing if mode isn't changing */
> +       if (mode == tz->mode) {
> +               mutex_unlock(&tz->lock);
> +
> +               return ret;
> +       }
> +
> +       if (tz->ops->set_mode)
> +               ret = tz->ops->set_mode(tz, mode);
> +
> +       if (!ret)
> +               tz->mode = mode;
> +
> +       mutex_unlock(&tz->lock);
> +
> +       thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +
> +       return ret;
> +}
> +
> +int thermal_zone_device_enable(struct thermal_zone_device *tz)
> +{
> +       return thermal_zone_device_set_mode(tz, THERMAL_DEVICE_ENABLED);
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device_enable);
> +
> +int thermal_zone_device_disable(struct thermal_zone_device *tz)
> +{
> +       return thermal_zone_device_set_mode(tz, THERMAL_DEVICE_DISABLED);
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device_disable);
> +
> +int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
> +{
> +       enum thermal_device_mode mode;
> +
> +       mutex_lock(&tz->lock);
> +
> +       mode = tz->mode;
> +
> +       mutex_unlock(&tz->lock);
> +
> +       return mode == THERMAL_DEVICE_ENABLED;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device_is_enabled);
> +
>  void thermal_zone_device_update(struct thermal_zone_device *tz,
>                                 enum thermal_notify_event event)
>  {
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index a808f6fa2777..df013c39ba9b 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -416,6 +416,9 @@ int thermal_zone_get_offset(struct thermal_zone_device *tz);
>
>  void thermal_cdev_update(struct thermal_cooling_device *);
>  void thermal_notify_framework(struct thermal_zone_device *, int);
> +int thermal_zone_device_enable(struct thermal_zone_device *tz);
> +int thermal_zone_device_disable(struct thermal_zone_device *tz);
> +int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
>  #else
>  static inline struct thermal_zone_device *thermal_zone_device_register(
>         const char *type, int trips, int mask, void *devdata,
> @@ -463,6 +466,16 @@ static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  static inline void thermal_notify_framework(struct thermal_zone_device *tz,
>         int trip)
>  { }
> +
> +static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
> +{ return -ENODEV; }
> +
> +static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
> +{ return -ENODEV; }
> +
> +static inline int
> +thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
> +{ return -ENODEV; }
>  #endif /* CONFIG_THERMAL */
>
>  #endif /* __THERMAL_H__ */
> --
> 2.17.1
>
