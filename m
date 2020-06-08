Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7C1F28AE
	for <lists+platform-driver-x86@lfdr.de>; Tue,  9 Jun 2020 01:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgFHXzW (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Mon, 8 Jun 2020 19:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbgFHXYD (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Mon, 8 Jun 2020 19:24:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA8B820C56;
        Mon,  8 Jun 2020 23:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658643;
        bh=duFMSxH9LLHFznCxFrz5SCLi4Onawnsd+0BCsQHec3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxA20iqZZSzF2aL35GZDyEPqmW+wbFRyrVqqQ4I7vfRYEUlf2i2IigjFvLlBwni2T
         vgWMyGoX6XzSWRwA+gdwc8GdAbvtGenhk0JAF8Q8jm3iMfL6DZxlytvQugeSiY1arm
         PIv+oSS9JBt3xLVOMlpVp7B51cGO7n4bXtYoOJbw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 064/106] platform/x86: intel-vbtn: Split keymap into buttons and switches parts
Date:   Mon,  8 Jun 2020 19:21:56 -0400
Message-Id: <20200608232238.3368589-64-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f6ba524970c4b73b234bf41ecd6628f5803b1559 ]

Split the sparse keymap into 2 separate keymaps, a buttons and a switches
keymap and combine the 2 to a single map again in intel_vbtn_input_setup().

This is a preparation patch for not telling userspace that we have switches
when we do not have them (and for doing the same for the buttons).

Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-vbtn.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 0bcfa20dd614..e42203776727 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -39,14 +39,20 @@ static const struct key_entry intel_vbtn_keymap[] = {
 	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
 	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key press */
 	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key release */
+};
+
+static const struct key_entry intel_vbtn_switchmap[] = {
 	{ KE_SW,     0xCA, { .sw = { SW_DOCK, 1 } } },		/* Docked */
 	{ KE_SW,     0xCB, { .sw = { SW_DOCK, 0 } } },		/* Undocked */
 	{ KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },	/* Tablet */
 	{ KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },	/* Laptop */
-	{ KE_END },
 };
 
+#define KEYMAP_LEN \
+	(ARRAY_SIZE(intel_vbtn_keymap) + ARRAY_SIZE(intel_vbtn_switchmap) + 1)
+
 struct intel_vbtn_priv {
+	struct key_entry keymap[KEYMAP_LEN];
 	struct input_dev *input_dev;
 	bool wakeup_mode;
 };
@@ -54,13 +60,29 @@ struct intel_vbtn_priv {
 static int intel_vbtn_input_setup(struct platform_device *device)
 {
 	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
-	int ret;
+	int ret, keymap_len = 0;
+
+	if (true) {
+		memcpy(&priv->keymap[keymap_len], intel_vbtn_keymap,
+		       ARRAY_SIZE(intel_vbtn_keymap) *
+		       sizeof(struct key_entry));
+		keymap_len += ARRAY_SIZE(intel_vbtn_keymap);
+	}
+
+	if (true) {
+		memcpy(&priv->keymap[keymap_len], intel_vbtn_switchmap,
+		       ARRAY_SIZE(intel_vbtn_switchmap) *
+		       sizeof(struct key_entry));
+		keymap_len += ARRAY_SIZE(intel_vbtn_switchmap);
+	}
+
+	priv->keymap[keymap_len].type = KE_END;
 
 	priv->input_dev = devm_input_allocate_device(&device->dev);
 	if (!priv->input_dev)
 		return -ENOMEM;
 
-	ret = sparse_keymap_setup(priv->input_dev, intel_vbtn_keymap, NULL);
+	ret = sparse_keymap_setup(priv->input_dev, priv->keymap, NULL);
 	if (ret)
 		return ret;
 
-- 
2.25.1

