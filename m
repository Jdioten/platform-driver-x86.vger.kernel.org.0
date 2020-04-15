Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2521A98A5
	for <lists+platform-driver-x86@lfdr.de>; Wed, 15 Apr 2020 11:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895437AbgDOJXt (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Wed, 15 Apr 2020 05:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895406AbgDOJXO (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Wed, 15 Apr 2020 05:23:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D65C061BD3
        for <platform-driver-x86@vger.kernel.org>; Wed, 15 Apr 2020 02:23:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so18249880wrs.9
        for <platform-driver-x86@vger.kernel.org>; Wed, 15 Apr 2020 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+pTtxbF6QRKm4ChjDfBhdzosGTJFivS8O2LYLc6THQ=;
        b=wU0K3NA/8EqmM1ff21F2XRJIgW7Mcma7ec0tb8Vq97AT7ksJ4VfqAtHEjK4wV5jIy4
         /yQFIqSk4PYe4fSkgSYWWgsf2SMd/XEpAUDZq9Jv+yx0ylFID3IH0MsxRdMJSjkikLnB
         XnLhglk5wYF+wo5aXbTs0aoE7O/oCNmB8j19OCsJUX5cmDn5Dh6oTgeTDan0cHwcb7QT
         SQskOHvgF5QlIxEfrXUEKamA5ifUB6l1MiFYHwpXk4gsHHZyrIX+MqlRzqDRLcZjs90f
         v2tI+U1O56udSg6DR9X5hpCHQQYIXmg6uegtzv3uC35CaVBlQpjzrfzSekHAHgXewnuz
         RLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+pTtxbF6QRKm4ChjDfBhdzosGTJFivS8O2LYLc6THQ=;
        b=cbSzrqjauu6HJoQsVGkPlR6sd6q33pw04UrKa4CBN63bi/lYnUIvlAvPnNoRp/6c6j
         fiZoIYls0OcLB9nm9JrusZUk0Hwj2hjoajBcJpm3ajHOIbB0StzlPa+5ytYMIhfcM69g
         PGLpne3MxDIM1/F40t0bOf83rWLii4LwV9c+9rZrIlupMXM/scJPxg0puUmpnryoKYTP
         ZoyzRfsDs/S/BW2hqpcJFWZlGtlV287PZuvchkpI6skNgNEJdXfzKEerM+bGJ5Kv0y1d
         y9uhLPt6hu2PyNwRk0baYuKljF6k6hdqjYkUS0uMMe60uKNSqP0XjvnaxjEQ+E6cqhmE
         UGKg==
X-Gm-Message-State: AGi0PuZ8cypb3BUm2P0N0sbEn/XT4iOqLvD0KhvP3DiaBNMpvF1jxOdU
        AbH4Eb77/OI+g88VJf75UcpsdA==
X-Google-Smtp-Source: APiQypKZCE4jcvwyEetbY5z9ghNHFxXWQpEL5eKh/IZ5lv3p9Amt6yFTRtJP4keaPPNXhk4WY/KQtQ==
X-Received: by 2002:adf:ea44:: with SMTP id j4mr4812531wrn.38.1586942591970;
        Wed, 15 Apr 2020 02:23:11 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id 138sm23013314wmb.14.2020.04.15.02.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 02:23:11 -0700 (PDT)
Subject: Re: [RFC v2 1/9] thermal: int3400_thermal: Statically initialize
 .get_mode()/.set_mode() ops
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Kaestle <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <2bc5a902-acde-526a-11a5-2357d899916c@linaro.org>
 <20200414180105.20042-1-andrzej.p@collabora.com>
 <20200414180105.20042-2-andrzej.p@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3f271ce1-b4bf-4516-7e6d-7a26bd6953de@linaro.org>
Date:   Wed, 15 Apr 2020 11:23:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414180105.20042-2-andrzej.p@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

On 14/04/2020 20:00, Andrzej Pietrasiewicz wrote:
> int3400_thermal_ops is used inside int3400_thermal_probe() only after
> the assignments, which can just as well be made statically at struct's
> initizer.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---

Applied this patch with Bartlomiej's tag.

Thanks

  -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
