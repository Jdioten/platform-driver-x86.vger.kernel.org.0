Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F90A6CF4
	for <lists+platform-driver-x86@lfdr.de>; Tue,  3 Sep 2019 17:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfICPhk (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Tue, 3 Sep 2019 11:37:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfICPhk (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Tue, 3 Sep 2019 11:37:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B93A8980FD;
        Tue,  3 Sep 2019 15:37:40 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9429919C78;
        Tue,  3 Sep 2019 15:37:39 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] tools-power-x86-intel-speed-select: Fixes and updates for output
Date:   Tue,  3 Sep 2019 11:37:26 -0400
Message-Id: <20190903153734.11904-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 03 Sep 2019 15:37:40 +0000 (UTC)
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

Some general fixes and updates for intel-speed-select.  Fixes include some
typos as well as an off-by-one cpu count reporting error.  Updates for the
output are

- switching to MHz as a standard
- reporting CPU frequencies instead of ratios as a standard
- viewing a human-readable CPU list.
- avoiding reporting "0|1" as success|fail as these can be confusing for a
  user.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org

Prarit Bhargava (8):
  tools/power/x86/intel-speed-select: Fix package typo
  tools/power/x86/intel-speed-select: Fix help option typo
  tools/power/x86/intel-speed-select: Fix cpu-count output
  tools/power/x86/intel-speed-select: Simplify output for turbo-freq and
    base-freq
  tools/power/x86/intel-speed-select: Switch output to MHz
  tools/power/x86/intel-speed-select: Change turbo ratio output to
    maximum turbo frequency
  tools/power/x86/intel-speed-select: Output human readable CPU list
  tools/power/x86/intel-speed-select: Output success/failed for command
    output

 .../x86/intel-speed-select/isst-config.c      |   4 +-
 .../x86/intel-speed-select/isst-display.c     | 116 ++++++++++++------
 2 files changed, 83 insertions(+), 37 deletions(-)

-- 
2.21.0

