Return-Path: <platform-driver-x86-owner@vger.kernel.org>
X-Original-To: lists+platform-driver-x86@lfdr.de
Delivered-To: lists+platform-driver-x86@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF23194B94
	for <lists+platform-driver-x86@lfdr.de>; Thu, 26 Mar 2020 23:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCZWew (ORCPT
        <rfc822;lists+platform-driver-x86@lfdr.de>);
        Thu, 26 Mar 2020 18:34:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:54032 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZWev (ORCPT
        <rfc822;platform-driver-x86@vger.kernel.org>);
        Thu, 26 Mar 2020 18:34:51 -0400
IronPort-SDR: D2WDzbOpUHYUH5UlzDxZbMYKlZES5sU+4Qzh05Ds5KloaOsRvHA/U9wLeB7HFQY2k0pFepqFq8
 NoWrVDy8oAWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 15:34:51 -0700
IronPort-SDR: wTyJ9yKZyVeDZvnazr5jWEtK2Q8TItB5lrfCSmjt0Hff810LoHXHR95WwdKyhVmu6latXTnmAG
 hi18VdUU5l5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="394178150"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Mar 2020 15:34:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jHb5M-0006JS-QV; Fri, 27 Mar 2020 06:34:48 +0800
Date:   Fri, 27 Mar 2020 06:34:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [platform-drivers-x86:review-andy] BUILD REGRESSION
 5539ddc1d8e82e685ea6500a75b79c994bd25fa9
Message-ID: <5e7d2e03.0DY7tzco9ar9J3EY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: platform-driver-x86-owner@vger.kernel.org
Precedence: bulk
List-ID: <platform-driver-x86.vger.kernel.org>
X-Mailing-List: platform-driver-x86@vger.kernel.org

tree/branch: git://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git  review-andy
branch HEAD: 5539ddc1d8e82e685ea6500a75b79c994bd25fa9  platform/x86: surface3_power: Fix Kconfig section ordering

Regressions in current branch:

drivers/platform/x86/surface3_power.c:60:24: warning: struct member 'mshw0011_lookup::cdata' is never used. [unusedStructMember]
drivers/platform/x86/surface3_power.c:61:16: warning: struct member 'mshw0011_lookup::n' is never used. [unusedStructMember]
drivers/platform/x86/surface3_power.c:62:16: warning: struct member 'mshw0011_lookup::index' is never used. [unusedStructMember]
drivers/platform/x86/surface3_power.c:63:8: warning: struct member 'mshw0011_lookup::addr' is never used. [unusedStructMember]
int   addr;
struct mshw0011_data *cdata;

Error ids grouped by kconfigs:

recent_errors
`-- x86_64-allyesconfig
    |-- drivers-platform-x86-surface3_power.c:warning:struct-member-mshw0011_lookup::addr-is-never-used.-unusedStructMember
    |-- drivers-platform-x86-surface3_power.c:warning:struct-member-mshw0011_lookup::cdata-is-never-used.-unusedStructMember
    |-- drivers-platform-x86-surface3_power.c:warning:struct-member-mshw0011_lookup::index-is-never-used.-unusedStructMember
    |-- drivers-platform-x86-surface3_power.c:warning:struct-member-mshw0011_lookup::n-is-never-used.-unusedStructMember
    |-- int-addr
    `-- struct-mshw0011_data-cdata

elapsed time: 484m

configs tested: 152
configs skipped: 0

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
alpha                               defconfig
xtensa                       common_defconfig
powerpc                       ppc64_defconfig
um                           x86_64_defconfig
xtensa                          iss_defconfig
s390                             alldefconfig
riscv                    nommu_virt_defconfig
nds32                               defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
csky                                defconfig
nds32                             allnoconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200326
x86_64               randconfig-a002-20200326
x86_64               randconfig-a003-20200326
i386                 randconfig-a001-20200326
i386                 randconfig-a002-20200326
i386                 randconfig-a003-20200326
alpha                randconfig-a001-20200326
m68k                 randconfig-a001-20200326
mips                 randconfig-a001-20200326
nds32                randconfig-a001-20200326
parisc               randconfig-a001-20200326
riscv                randconfig-a001-20200326
c6x                  randconfig-a001-20200326
h8300                randconfig-a001-20200326
microblaze           randconfig-a001-20200326
nios2                randconfig-a001-20200326
sparc64              randconfig-a001-20200326
s390                 randconfig-a001-20200326
csky                 randconfig-a001-20200326
xtensa               randconfig-a001-20200326
openrisc             randconfig-a001-20200326
sh                   randconfig-a001-20200326
x86_64               randconfig-c001-20200326
x86_64               randconfig-c002-20200326
x86_64               randconfig-c003-20200326
i386                 randconfig-c001-20200326
i386                 randconfig-c002-20200326
i386                 randconfig-c003-20200326
x86_64               randconfig-e001-20200326
x86_64               randconfig-e002-20200326
x86_64               randconfig-e003-20200326
i386                 randconfig-e001-20200326
i386                 randconfig-e002-20200326
i386                 randconfig-e003-20200326
x86_64               randconfig-f001-20200326
x86_64               randconfig-f002-20200326
x86_64               randconfig-f003-20200326
i386                 randconfig-f001-20200326
i386                 randconfig-f002-20200326
i386                 randconfig-f003-20200326
x86_64               randconfig-g001-20200326
x86_64               randconfig-g002-20200326
x86_64               randconfig-g003-20200326
i386                 randconfig-g001-20200326
i386                 randconfig-g002-20200326
i386                 randconfig-g003-20200326
x86_64               randconfig-h001-20200326
x86_64               randconfig-h002-20200326
x86_64               randconfig-h003-20200326
i386                 randconfig-h001-20200326
i386                 randconfig-h002-20200326
i386                 randconfig-h003-20200326
arc                  randconfig-a001-20200326
arm                  randconfig-a001-20200326
arm64                randconfig-a001-20200326
ia64                 randconfig-a001-20200326
powerpc              randconfig-a001-20200326
sparc                randconfig-a001-20200326
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
