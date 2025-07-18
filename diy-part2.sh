#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 1. 修改默认IP地址为 192.168.10.1
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 2. 清除默认登录密码 (首次登录无需密码)
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings

# 3. 替换默认主题为您喜欢的 Design
sed -i 's/luci-theme-bootstrap/luci-theme-design/g' feeds/luci/collections/luci/Makefile

# 4. 添加软件包到 .config 配置文件
cat >> .config <<EOF

# --- 基础功能与语言 ---
CONFIG_PACKAGE_luci=y
CONFIG_PACKAGE_luci-i18n-base-zh-cn=y
CONFIG_PACKAGE_luci-theme-design=y

# --- 网络核心服务 ---
# AC控制器 (您的核心需求)
CONFIG_PACKAGE_luci-app-gecoosac=y
# 动态DNS
CONFIG_PACKAGE_luci-app-ddns-go=y
# 网络质量优化 (防卡顿)
CONFIG_PACKAGE_luci-app-sqm=y
# VPN服务器
CONFIG_PACKAGE_luci-proto-wireguard=y
CONFIG_PACKAGE_wireguard-tools=y
# UPnP 端口自动转发
CONFIG_PACKAGE_luci-app-upnp=y

# --- 科学上网与广告过滤 ---
# 广告过滤
CONFIG_PACKAGE_luci-app-adguardhome=y
# 科学上网
CONFIG_PACKAGE_luci-app-openclash=y
# 解锁网易云音乐
CONFIG_PACKAGE_luci-app-unblockneteasemusic=y

# --- 容器与虚拟化 ---
# Docker 容器
CONFIG_PACKAGE_luci-app-dockerman=y

# --- 系统工具与监控 ---
# 网页终端
CONFIG_PACKAGE_luci-app-ttyd=y
# 实时流量监控
CONFIG_PACKAGE_luci-app-wrtbwmon=y
# 长期流量统计
CONFIG_PACKAGE_luci-app-nlbwmon=y
# 局域网唤醒
CONFIG_PACKAGE_luci-app-wol=y
# 命令行工具
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y

# --- 智能家居 (可选，为未来扩展) ---
# MQTT 服务器
CONFIG_PACKAGE_luci-app-mosquitto=y

EOF
