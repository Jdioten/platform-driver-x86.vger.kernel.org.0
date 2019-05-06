Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA71495A
	for <lists+platform-driver-x86@lfdr.de>; Mon,  6 May 2019 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfEFMMj (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 6 May 2019 08:12:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39741 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFMMj (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 6 May 2019 08:12:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so6672929pfg.6;
        Mon, 06 May 2019 05:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmxCB7LP69CVGAXY/adFCVFF9KJfeURbRonO3oUrf8c=;
        b=kiLbwjh4jOBNwmAvF/JbsIT7QyuxULl2QC2utRpH3pwRAis3fuaDApX0ZsRxl/gbIL
         AH85FEcXo8p5Hv5w1SIZKlUqMtJfKgD7Up6iLEkkWrpDkPO0ngyLrFdsrzrICtopcgyM
         Azw+lBknShvUsmdQigB2baPKdBNsZRTj9seiXuPSTLDq3kYFec+nHD5+5bOIeS6Ao4FK
         ChqifowXTjS+FgKZikqTUPnuy4zSxvonEChgwG4L16y/rTunVKC6ogbjmwyA0lGxKV6+
         HKcPJ/eUB1QQ0oF03rB/TLUl0+8KtheSUFiY2EypOBOVAu46JTsDEmjptfexZjbYrqB2
         jjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmxCB7LP69CVGAXY/adFCVFF9KJfeURbRonO3oUrf8c=;
        b=P/e9psRGflk7jS0nHJoq4B9qTAUYcYfES6+6SlSQqqKSzUji9frbUyLTdXm86sS7If
         1v1ejoo/i5JBP4OLOHg0cGHgZCbclaJErWcadYwz3N7c0i42d7SaKjpXmn0cQxyEhEsF
         q1W0BiKABRHcMkRinzHMoaB/wZKPCpZqWNWnQ2Mu/dEasy78IV+nP2irMddUaZ2AL4SE
         CK8t0YQTXUN5mAml7bUC9hsBktxt/hKmE3jWIctCnOjYc54HHRYflTwqjuChccAvERcE
         g3Ya+k7PCHi96OwWHqtxor0WoAMtcOq2y5OzG3FSlNRfrDJJRqz6aXev6T2+AUYnlayu
         shxg==
X-Gm-Message-State: APjAAAXm+wiPU039TLMPVLqUMTLyvaSl2lIHJBCHzpkWFhEp/t6jOWTD
        I5/DChJvo3i2QNJRX7iPjd96Va6WjJ4cx/qe48c=
X-Google-Smtp-Source: APXvYqy0RDpwpau4Fc20dfB5hVMlt2XXQ8Si4xjDk8e+lufkZ/CMAVQOBHgRMHl1hfi16GGW1FhW4dR2IKcOKJ1OS0Q=
X-Received: by 2002:aa7:884b:: with SMTP id k11mr32615332pfo.49.1557144757917;
 Mon, 06 May 2019 05:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190429143807.13232-1-hdegoede@redhat.com>
In-Reply-To: <20190429143807.13232-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 15:12:27 +0300
Message-ID: <CAHp75Ve7kvm9NAv74_=BvPbC9GtaAQ+Ps07qNt=iSQ99++C3gg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Remove no_hw_rfkill_list
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

On Mon, Apr 29, 2019 at 5:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> When the ideapad-laptop driver was first written it was written for laptops
> which had a hardware rfkill switch. So when the first ideapad laptops
> showed up without a hw rfkill switch and it turned out that in this case
> the ideapad firmware interface would always report the wifi being hardware-
> blocked, a DMI id list of models which lack a hw rfkill switch was started
> (by yours truly). Things were done this way to avoid regressing existing
> models with a hw rfkill switch. In hindsight this was a mistake.
>
> Lenovo releases a lot of ideapad models every year and even the latest
> models still use the "VPC2004" ACPI interface the ideapad-laptop driver
> binds to. Having a hw rfkill switch is quite rare on modern hardware, so
> all these new models need to be added to the no_hw_rfkill_list, leading
> to a never ending game of whack a mole.
>
> Worse the failure mode when not present on the list, is very bad. In this
> case the ideapad-laptop driver will report the wifi as being hw-blocked,
> at which points NetworkManager does not even try to use it and the user
> ends up with non working wifi.
>
> This leads to various Linux fora on the internet being filled with
> wifi not working on ideapad laptops stories, which does not make Linux
> look good.
>
> The failure mode when we flip the default to assuming that a hw rfkill
> switch is not present OTOH is quite benign. When we properly report the
> wifi as being hw-blocked on ideapads which do have the hw-switch; and it
> is in the wifi-off position, then at least when using NetworkManager +
> GNOME3 the user will get a "wifi disabled in hardware" message when trying
> to connect to the wifi from the UI. If OTOH we assume there is no hardware
> rfkill switch, then the user will get an empty list for the list of
> available networks. Although the empty list vs the "wifi disabled in
> hardware" message is a regression, it is a very minor regression and it
> can easily be fixed on a model by model basis by filling the new
> hw_rfkill_list this commit introduces.
>
> Therefor this commit removes the ever growing no_hw_rfkill_list, flipping
> the default to assuming there is no hw rfkill switch and adding a new
> hw_rfkill_list. Thereby fixing the wifi not working on all the current
> ideapad and yoga models which are not on the list yet and also fixing it
> for all future ideapad and yoga models using the "VPC2004" ACPI interface.
>
> Note once this patch has been accepted upstream. I plan to write a blog
> post asking for users of ideapads and yoga's with a hw rfkill switch to
> step forward, so that we can populate the new hw_rfkill_list with the few
> older yoga and ideapad models which actually have a hw rfkill switch.
>

Pushed to my review and testing queue, thanks!

> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1703338
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 321 ++------------------------
>  1 file changed, 15 insertions(+), 306 deletions(-)
>
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index c53ae86b59c7..2d94536dea88 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -980,312 +980,21 @@ static void ideapad_wmi_notify(u32 value, void *context)
>  #endif
>
>  /*
> - * Some ideapads don't have a hardware rfkill switch, reading VPCCMD_R_RF
> - * always results in 0 on these models, causing ideapad_laptop to wrongly
> - * report all radios as hardware-blocked.
> + * Some ideapads have a hardware rfkill switch, but most do not have one.
> + * Reading VPCCMD_R_RF always results in 0 on models without a hardware rfkill,
> + * switch causing ideapad_laptop to wrongly report all radios as hw-blocked.
> + * There used to be a long list of DMI ids for models without a hw rfkill
> + * switch here, but that resulted in playing whack a mole.
> + * More importantly wrongly reporting the wifi radio as hw-blocked, results in
> + * non working wifi. Whereas not reporting it hw-blocked, when it actually is
> + * hw-blocked results in an empty SSID list, which is a much more benign
> + * failure mode.
> + * So the default now is the much safer option of assuming there is no
> + * hardware rfkill switch. This default also actually matches most hardware,
> + * since having a hw rfkill switch is quite rare on modern hardware, so this
> + * also leads to a much shorter list.
>   */
> -static const struct dmi_system_id no_hw_rfkill_list[] = {
> -       {
> -               .ident = "Lenovo RESCUER R720-15IKBN",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo R720-15IKBN"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo G40-30",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo G40-30"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo G50-30",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo G50-30"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo V310-14IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo V310-14IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo V310-14ISK",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo V310-14ISK"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo V310-15IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo V310-15IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo V310-15ISK",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo V310-15ISK"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo V510-15IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo V510-15IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad 300-15IBR",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 300-15IBR"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad 300-15IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 300-15IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad 300S-11IBR",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 300S-11BR"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad 310-15ABR",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 310-15ABR"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad 310-15IAP",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 310-15IAP"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad 310-15IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 310-15IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad 310-15ISK",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 310-15ISK"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad 330-15ICH",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 330-15ICH"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad 530S-14ARR",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 530S-14ARR"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad S130-14IGM",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad S130-14IGM"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad Y700-14ISK",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad Y700-14ISK"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad Y700-15ACZ",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad Y700-15ACZ"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad Y700-15ISK",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad Y700-15ISK"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad Y700 Touch-15ISK",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad Y700 Touch-15ISK"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad Y700-17ISK",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad Y700-17ISK"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo ideapad MIIX 720-12IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "MIIX 720-12IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Legion Y520-15IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Y520-15IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Y520-15IKBM",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Y520-15IKBM"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Legion Y530-15ICH",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Legion Y530-15ICH"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Legion Y530-15ICH-1060",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Legion Y530-15ICH-1060"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Legion Y720-15IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Y720-15IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Legion Y720-15IKBN",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Y720-15IKBN"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Y720-15IKBM",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Y720-15IKBM"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Yoga 2 11 / 13 / Pro",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Yoga 2"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Yoga 2 11 / 13 / Pro",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_BOARD_NAME, "Yoga2"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Yoga 2 13",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Yoga 2 13"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Yoga 3 1170 / 1470",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Yoga 3"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Yoga 3 Pro 1370",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 3"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Yoga 700",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 700"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Yoga 900",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 900"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Yoga 900",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_BOARD_NAME, "VIUU4"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo YOGA 910-13IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 910-13IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo YOGA 920-13IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 920-13IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo YOGA C930-13IKB",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA C930-13IKB"),
> -               },
> -       },
> -       {
> -               .ident = "Lenovo Zhaoyang E42-80",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "ZHAOYANG E42-80"),
> -               },
> -       },
> +static const struct dmi_system_id hw_rfkill_list[] = {
>         {}
>  };
>
> @@ -1311,7 +1020,7 @@ static int ideapad_acpi_add(struct platform_device *pdev)
>         priv->cfg = cfg;
>         priv->adev = adev;
>         priv->platform_device = pdev;
> -       priv->has_hw_rfkill_switch = !dmi_check_system(no_hw_rfkill_list);
> +       priv->has_hw_rfkill_switch = dmi_check_system(hw_rfkill_list);
>
>         ret = ideapad_sysfs_init(priv);
>         if (ret)
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
