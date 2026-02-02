#!/bin/bash
# ImmortalWrt 编译前自定义：修改 qca9880 VAP 数量为 24

# ==================== 核心：修改 qca9880 VAP 限制 ====================
# 定义 ath10k 驱动文件路径（适配不同仓库分支，按需调整）
# 路径1：官方 ath10k 驱动（主流分支）
ATH10K_HW_FILE="./package/kernel/ath10k/src/ath10k/hw2.0/qca988x/hw.c"
# 路径2：ath10k-ct 驱动（若使用 CT 版驱动）
ATH10K_CT_HW_FILE="./package/kernel/ath10k-ct/src/ath10k-ct/hw2.0/qca988x/hw.c"
# 路径3：全局头文件（备选）
ATH10K_H_FILE="./package/kernel/ath10k/src/ath10k/ath10k.h"

# 1. 修改官方 ath10k 驱动的 VAP 数量
if [ -f "$ATH10K_HW_FILE" ]; then
    echo "✅ 找到官方 ath10k 驱动文件，修改 qca9880 VAP 数量..."
    # 替换 MAX_VAPS 宏（适配代码中不同的写法）
    sed -i 's/MAX_VAPS[[:space:]]*=[[:space:]]*8/MAX_VAPS = 24/g' "$ATH10K_HW_FILE"
    sed -i 's/QCA9880_MAX_VAPS[[:space:]]*8/QCA9880_MAX_VAPS 24/g' "$ATH10K_HW_FILE"
fi

# 2. 修改 CT 版 ath10k 驱动的 VAP 数量（若使用）
if [ -f "$ATH10K_CT_HW_FILE" ]; then
    echo "✅ 找到 CT 版 ath10k 驱动文件，修改 qca9880 VAP 数量..."
    sed -i 's/MAX_VAPS[[:space:]]*=[[:space:]]*8/MAX_VAPS = 24/g' "$ATH10K_CT_HW_FILE"
    sed -i 's/QCA9880_MAX_VAPS[[:space:]]*8/QCA9880_MAX_VAPS 24/g' "$ATH10K_CT_HW_FILE"
fi

# 3. 备选：修改头文件中的全局 MAX_VAPS 定义
if [ -f "$ATH10K_H_FILE" ]; then
    echo "✅ 找到 ath10k 头文件，兜底修改 MAX_VAPS..."
    sed -i 's/#define[[:space:]]*MAX_VAPS[[:space:]]*8/#define MAX_VAPS 24/g' "$ATH10K_H_FILE"
fi

# ==================== 可选：刷新 feeds 确保驱动完整 ====================
./scripts/feeds update -a
./scripts/feeds install -a

echo "✅ DIY 脚本执行完成：qca9880 VAP 数量已修改为 24"
# 请在下方输入自定义命令(一般用来安装第三方插件)(可以留空)
# 首页和网络向导
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-quickstart-zh-cn"
# 高级卸载 by YT Vedio Talk
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-uninstall"
# 极光主题 by github eamonxg
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-theme-aurora"
# 去广告adghome
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-adguardhome"
# 代理相关
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-passwall-zh-cn"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ssr-plus"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-passwall2"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-nikki-zh-cn"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-nekobox"
#CUSTOM_PACKAGES="$CUSTOM_PACKAGES momo luci-app-momo luci-i18n-momo-zh-cn"
# Please enter the custom command below (usually used to install third-party plugins) (can be left blank)
# git clone --depth=1 https://github.com/EOYOHOO/UA2F.git package/UA2F
# git clone --depth=1 https://github.com/EOYOHOO/rkp-ipid.git package/rkp-ipid
