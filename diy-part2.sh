#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 1.5 【针对 LibWrt 的无线切除手术】直接从机型 Makefile 定义里抹除强制捆绑的无线板级包
# 遍历 qualcommax 平台下所有的 .mk 机型配置文件，把 cmiot_ax18 强制捆绑的 wifi 依赖行直接擦除
find target/linux/qualcommax/image/ -name "*.mk" | xargs sed -i 's/ipq-wifi-cmiot_ax18//g' 2>/dev/null

# 2. 自动将基础组件中的 dnsmasq 替换为 dnsmasq-full，从源头规避包冲突
find include/ target/ -name "Makefile" -o -name "*.mk" | xargs sed -i 's/\bdnsmasq\b/dnsmasq-full/g' 2>/dev/null
