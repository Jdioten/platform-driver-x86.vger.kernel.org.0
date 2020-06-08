Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24F81F177B
	for <lists+platform-driver-x86@lfdr.de>; Mon,  8 Jun 2020 13:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgFHLWZ (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 8 Jun 2020 07:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgFHLWY (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 8 Jun 2020 07:22:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413CBC08C5C2;
        Mon,  8 Jun 2020 04:22:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id EEEA02A35BA
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 0/7] Support inhibiting input devices
Date:   Mon,  8 Jun 2020 13:22:04 +0200
Message-Id: <20200608112211.12125-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

This is a quick respin of v3, with just two small changes, please see
the changelog below.

Userspace might want to implement a policy to temporarily disregard input
from certain devices.

An example use case is a convertible laptop, whose keyboard can be folded
under the screen to create tablet-like experience. The user then must hold
the laptop in such a way that it is difficult to avoid pressing the keyboard
keys. It is therefore desirable to temporarily disregard input from the
keyboard, until it is folded back. This obviously is a policy which should
be kept out of the kernel, but the kernel must provide suitable means to
implement such a policy.

Due to interactions with suspend/resume, a helper has been added for drivers
to decide if the device is being used or not (PATCH 1/7) and it has been
applied to relevant drivers (PATCH 2,4,5,6/7).

PATCH 7/7 adds support for inhibiting input devices.

This work is inspired by:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/45c2d7bb398f74adfae0017e20b224152fde3822

and

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/4ce0e8a3697edb8fd071110b3af65014512061c7

In this respin the elan_i2c patch is dropped and converting it will be
addressed later.

v3..v4:
- updated the comment in input_open_device() (Hans)
- used more straightforward locking pattern in adc/exynos (Michał)

v2..v3:
- ignored autorepeat events in input_get_disposition() if a key is not
pressed (Hans)
- dropped inhibit()/uninhibit() driver callbacks (Hans)
- split ACPI button patch into taking the lock and using the helper (Rafael)
- dropped the elan_i2c conversion
- fixed typos in exynos adc

v1..v2:
- added input_device_enabled() helper and used it in drivers (Dmitry)
- the fact of open() and close() being called in inhibit/uninhibit paths has
been emphasized in the commit message of PATCH 6/7 (Dmitry)

Andrzej Pietrasiewicz (6):
  Input: add input_device_enabled()
  Input: use input_device_enabled()
  ACPI: button: Access input device's users under appropriate mutex
  ACPI: button: Use input_device_enabled() helper
  iio: adc: exynos: Use input_device_enabled()
  platform/x86: thinkpad_acpi: Use input_device_enabled()

Patrik Fimml (1):
  Input: Add "inhibited" property

 drivers/acpi/button.c                       |   7 +-
 drivers/iio/adc/exynos_adc.c                |   6 +-
 drivers/input/input.c                       | 125 ++++++++++++++++++--
 drivers/input/joystick/xpad.c               |   4 +-
 drivers/input/keyboard/ep93xx_keypad.c      |   2 +-
 drivers/input/keyboard/gpio_keys.c          |   4 +-
 drivers/input/keyboard/imx_keypad.c         |   4 +-
 drivers/input/keyboard/ipaq-micro-keys.c    |   2 +-
 drivers/input/keyboard/lpc32xx-keys.c       |   4 +-
 drivers/input/keyboard/pmic8xxx-keypad.c    |   4 +-
 drivers/input/keyboard/pxa27x_keypad.c      |   2 +-
 drivers/input/keyboard/samsung-keypad.c     |   4 +-
 drivers/input/keyboard/spear-keyboard.c     |   8 +-
 drivers/input/keyboard/st-keyscan.c         |   4 +-
 drivers/input/keyboard/tegra-kbc.c          |   4 +-
 drivers/input/misc/drv260x.c                |   4 +-
 drivers/input/misc/drv2665.c                |   4 +-
 drivers/input/misc/drv2667.c                |   4 +-
 drivers/input/misc/gp2ap002a00f.c           |   4 +-
 drivers/input/misc/kxtj9.c                  |   4 +-
 drivers/input/misc/sirfsoc-onkey.c          |   2 +-
 drivers/input/mouse/navpoint.c              |   4 +-
 drivers/input/touchscreen/ad7879.c          |   6 +-
 drivers/input/touchscreen/atmel_mxt_ts.c    |   4 +-
 drivers/input/touchscreen/auo-pixcir-ts.c   |   8 +-
 drivers/input/touchscreen/bu21029_ts.c      |   4 +-
 drivers/input/touchscreen/chipone_icn8318.c |   4 +-
 drivers/input/touchscreen/cyttsp_core.c     |   4 +-
 drivers/input/touchscreen/eeti_ts.c         |   4 +-
 drivers/input/touchscreen/ektf2127.c        |   4 +-
 drivers/input/touchscreen/imx6ul_tsc.c      |   4 +-
 drivers/input/touchscreen/ipaq-micro-ts.c   |   2 +-
 drivers/input/touchscreen/iqs5xx.c          |   4 +-
 drivers/input/touchscreen/lpc32xx_ts.c      |   4 +-
 drivers/input/touchscreen/melfas_mip4.c     |   4 +-
 drivers/input/touchscreen/mms114.c          |   6 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c   |   8 +-
 drivers/input/touchscreen/ucb1400_ts.c      |   4 +-
 drivers/input/touchscreen/wm97xx-core.c     |  14 ++-
 drivers/input/touchscreen/zforce_ts.c       |   8 +-
 drivers/platform/x86/thinkpad_acpi.c        |   4 +-
 include/linux/input.h                       |  14 ++-
 42 files changed, 228 insertions(+), 96 deletions(-)


base-commit: 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
-- 
2.17.1

