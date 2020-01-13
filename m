Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7E1392C3
	for <lists+platform-driver-x86@lfdr.de>; Mon, 13 Jan 2020 14:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAMN5x (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 13 Jan 2020 08:57:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:54643 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgAMN4i (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 13 Jan 2020 08:56:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 05:56:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="422812847"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2020 05:56:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 04F341E0; Mon, 13 Jan 2020 15:56:25 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 23/36] platform/x86: intel_pmc_ipc: Get rid of unnecessary includes
Date:   Mon, 13 Jan 2020 16:56:10 +0300
Message-Id: <20200113135623.56286-24-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

There is no point including headers that are not needed in the driver so
drop them.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 83b106f66fa6..8527327d88c7 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -12,23 +12,13 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/atomic.h>
-#include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/pm.h>
-#include <linux/pm_qos.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/suspend.h>
 
 #include <asm/intel_pmc_ipc.h>
 
-- 
2.24.1

