#!/bin/bash
#
# Copyright (c) 2012-2020 Vector Di-gi <https://vectordigi.cf>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/Vector-Digi/match_complier
# File name: postfix.sh
# Description: OpenWrt customize script phase 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Change default locale to Greater China
sed -i 's/auto/zh_cn/g' feeds/luci/modules/luci-base/root/etc/config/luci && sed -i 's/UTC/CST-8/g' package/base-files/files/bin/config_generate && sed -i '/CST-8/a\set system.@system[-1].zonename='"'"'Asia/Shanghai'"'"'' package/base-files/files/bin/config_generate

# Set default gateway to '10.0.0.1'
sed -i 's/192.168/10.0/g' package/base-files/files/bin/config_generate && sed -i 's/10.0.1/10.0.0/g' package/base-files/files/bin/config_generate

# Activate wireless at reset
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Set 'toor' as the default password for root user
sed -i 's*root::0:0:99999:7:::*root:\$1\$Z5PSAHJ9$1UReP9Mm94CqDFVEnROB//:17713:0:99999:7:::*g' package/

# Add  3rd-part packages
git clone -b packages https://github.com/Vector-Digi/match_complier.git package/custom

# Add Fullcone-NAT option
sed -i '/Netfilter flow offload support/i\o = s.option(form.Flag, '"'"'fullcone'"'"', _('"'"'Enable FullCone-NAT'"'"'));'  feeds/luci/applications/luci-app-firewall/htdocs/luci-static/resources/view/firewall/zones.js && sed -i '/Uncomment this line to disable ipv6 rules/i\option fullcone		0' package/network/config/firewall/files/firewall.config && mkdir package/network/config/firewall/patches/ && wget -P package/network/config/firewall/patches/ https://github.com/Lienol/openwrt/raw/main/package/network/config/firewall/patches/fullconenat.patch &&wget -P target/linux/generic/hack-5.4/  https://github.com/Lienol/openwrt/raw/main/target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch

# Enable MIPS FPU emulator
if grep -q 'CONFIG_TARGET_ramips=y' .config  &&  ! grep -q 'CONFIG_KERNEL_MIPS_FP_SUPPORT=y' .config ;
then 
    echo "CONFIG_KERNEL_MIPS_FP_SUPPORT=y" >> .config && echo "FPU emulator enabled. Do not modify menuconfig again"
else echo "Not MIPS architecture or parameter already exist. Skip"
fi
