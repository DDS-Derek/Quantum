#!/usr/bin/env bash
Green="\033[32m"
Font="\033[0m"
Red="\033[31m" 

WDaan_VueTorrent_url=https://github.com/WDaan/VueTorrent
CzBiX_qb_web_url=https://github.com/CzBiX/qb-web
bill_ahmed_qbit_matUI_url=https://github.com/bill-ahmed/qbit-matUI
ntoporcov_iQbit_url=https://github.com/ntoporcov/iQbit

# 软件包安装
package_installation(){
_os=`uname`
echo -e "${Green}use system: ${_os}${Font}"
if [ ${_os} == "Darwin" ]; then
	OSNAME='macos'
    echo -e "${Red}错误：此系统无法使用此脚本${Font}"
    exit 1
elif grep -Eq "openSUSE" /etc/*-release; then
	OSNAME='opensuse'
	zypper refresh
elif grep -Eq "FreeBSD" /etc/*-release; then
	OSNAME='freebsd'
elif grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
	OSNAME='centos'
	yum install -y wget zip unzip curl
elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
	OSNAME='fedora'
	yum install -y wget zip unzip curl
elif grep -Eqi "Rocky" /etc/issue || grep -Eq "Rocky" /etc/*-release; then
	OSNAME='rocky'
	yum install -y wget zip unzip curl
elif grep -Eqi "AlmaLinux" /etc/issue || grep -Eq "AlmaLinux" /etc/*-release; then
	OSNAME='alma'
	yum install -y wget zip unzip curl
elif grep -Eqi "Amazon Linux" /etc/issue || grep -Eq "Amazon Linux" /etc/*-release; then
	OSNAME='amazon'
	yum install -y wget zip unzip curl
elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
	OSNAME='debian'
	apt update -y
	apt install -y devscripts
	apt install -y wget zip unzip curl
elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
	OSNAME='ubuntu'
	apt install -y wget zip unzip curl
else
	OSNAME='unknow'
    echo -e "${Red}错误：此系统无法使用此脚本${Font}"
    exit 1
fi
}

#root权限
root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "${Red}错误：此脚本必须以 root 身份运行！${Font}"
        exit 1
    fi
}

# PUID PGID 获取
get_uid(){
read -p "PUID:" qb_PUID
read -p "PGID:" qb_PGID
}

# qb config 目录获取
get_qb_dir(){
read -p "qBittorrent config 目录:" qb_config_dir
}

# 获取所有数据
get_all_ma(){
# 获取PUID PGID
get_uid
# 获取qb config 目录
get_qb_dir
}

# WDaan/VueTorrent UI 安装
WDaan_VueTorrent_install(){
# 获取最新版本
WDaan_VueTorrent_tag=$(wget --no-check-certificate -qO- https://api.github.com/repos/WDaan/VueTorrent/tags | grep 'name' | cut -d\" -f4 | head -1)
# 下载
wget \
    https://github.com/WDaan/VueTorrent/releases/download/${WDaan_VueTorrent_tag}/vuetorrent.zip \
    -O /tmp/vuetorrent.zip
# 解压
unzip \
    -d ${qb_config_dir} \
    /tmp/vuetorrent.zip > /dev/null
# 删除安装文件
rm -rf /tmp/vuetorrent.zip
# 给权限
chown -R ${qb_PUID}:${qb_PGID} ${qb_config_dir}/vuetorrent

echo -e "${Green}WDaan/VueTorrent 安装成功${Font}"
echo -e "${Green}接下请进入qBittorrent Web UI 设置以下内容${Font}"
echo -e "${Green}1.设置--Web UI--勾选 使用备用 Web UI${Font}"
echo -e "${Green}2.设置--Web UI--使用备用 Web UI的文件路径设置为 /config/vuetorrent ${Font}"
}

# CzBiX/qb-web UI 安装
CzBiX_qb_web_install(){
# 获取最新版本
CzBiX_qb_web_tag=$(wget --no-check-certificate -qO- https://api.github.com/repos/CzBiX/qb-web/tags | grep 'name' | cut -d\" -f4 | head -1)
# 下载
wget \
    https://github.com/CzBiX/qb-web/releases/download/${CzBiX_qb_web_tag}/qb-web-${CzBiX_qb_web_tag}.zip \
    -O /tmp/qb-web-${CzBiX_qb_web_tag}.zip
# 解压
unzip \
    -d ${qb_config_dir} \
    /tmp/qb-web-${CzBiX_qb_web_tag}.zip > /dev/null
mv ${qb_config_dir}/dist ${qb_config_dir}/CzBiX_qb_web
# 删除安装文件
rm -rf /tmp/qb-web-${CzBiX_qb_web_tag}.zip
# 给权限
chown -R ${qb_PUID}:${qb_PGID} ${qb_config_dir}/CzBiX_qb_web

echo -e "${Green}CzBiX/qb-web 安装成功${Font}"
echo -e "${Green}接下请进入qBittorrent Web UI 设置以下内容${Font}"
echo -e "${Green}1.设置--Web UI--勾选 使用备用 Web UI${Font}"
echo -e "${Green}2.设置--Web UI--使用备用 Web UI的文件路径设置为 /config/CzBiX_qb_web ${Font}"
}

# bill-ahmed/qbit-matUI UI 安装
bill_ahmed_qbit_matUI_install(){
# 获取最新版本
bill_ahmed_qbit_matUI_tag=$(wget --no-check-certificate -qO- https://api.github.com/repos/bill-ahmed/qbit-matUI/tags | grep 'name' | cut -d\" -f4 | head -1 | cut -c2-)
# 下载
wget \
    https://github.com/bill-ahmed/qbit-matUI/releases/download/v${bill_ahmed_qbit_matUI_tag}/qbit-matUI_Unix_${bill_ahmed_qbit_matUI_tag}.zip \
    -O /tmp/qbit-matUI_Unix_${bill_ahmed_qbit_matUI_tag}.zip
# 解压
unzip \
    -d ${qb_config_dir} \
    /tmp/qbit-matUI_Unix_${bill_ahmed_qbit_matUI_tag}.zip > /dev/null
mv ${qb_config_dir}/qbit-matUI_Unix_${bill_ahmed_qbit_matUI_tag} ${qb_config_dir}/qbit_matUI
# 删除安装文件
rm -rf /tmp/qbit-matUI_Unix_${bill_ahmed_qbit_matUI_tag}.zip
# 给权限
chown -R ${qb_PUID}:${qb_PGID} ${qb_config_dir}/qbit_matUI

echo -e "${Green}bill-ahmed/qbit-matUI 安装成功${Font}"
echo -e "${Green}接下请进入qBittorrent Web UI 设置以下内容${Font}"
echo -e "${Green}1.设置--Web UI--勾选 使用备用 Web UI${Font}"
echo -e "${Green}2.设置--Web UI--使用备用 Web UI的文件路径设置为 /config/qbit_matUI ${Font}"
}

# ntoporcov/iQbit UI 安装
ntoporcov_iQbit_install(){
# 下载
git clone https://github.com/ntoporcov/iQbit /tmp/iQbit
mv /tmp/iQbit/release ${qb_config_dir}/iQbit
# 删除安装文件
rm -rf /tmp/iQbit
# 给权限
chown -R ${qb_PUID}:${qb_PGID} ${qb_config_dir}/iQbit

echo -e "${Green}ntoporcov/iQbit 安装成功${Font}"
echo -e "${Green}接下请进入qBittorrent Web UI 设置以下内容${Font}"
echo -e "${Green}1.设置--Web UI--勾选 使用备用 Web UI${Font}"
echo -e "${Green}2.设置--Web UI--使用备用 Web UI的文件路径设置为 /config/iQbit ${Font}"
}

# 主菜单
main(){
# 检测是否为 root 用户
root_need
# 清理命令行
clear
# 安装软件包
package_installation
# 清理命令行
clear
echo -e "${Green}use os: ${OSNAME}${Font}"
# 输出主菜单
echo -e "———————————————————————————————————————"
echo -e "${Green}Linux qBittorrent Web UI 一键安装脚本${Font}"
echo -e "${Green}1、WDaan/VueTorrent ${WDaan_VueTorrent_url}${Font}"
echo -e "${Green}2、CzBiX/qb-web ${CzBiX_qb_web_url}${Font}"
echo -e "${Green}3、bill-ahmed/qbit-matUI ${bill_ahmed_qbit_matUI_url}${Font}"
echo -e "${Green}4、ntoporcov/iQbit ${ntoporcov_iQbit_url}${Font}"
echo -e "${Green}5、退出脚本${Font}"
echo -e "———————————————————————————————————————"
read -p "请输入数字 [1-5]:" num
case "$num" in
    1)
    # 获取所有数据
    get_all_ma
    # 安装
    WDaan_VueTorrent_install
    ;;
    2)
    # 获取所有数据
    get_all_ma
    # 安装
    CzBiX_qb_web_install
    ;;
    3)
    # 获取所有数据
    get_all_ma
    # 安装
    bill_ahmed_qbit_matUI_install
    ;;
    4)
    # 获取所有数据
    get_all_ma
    # 安装
    ntoporcov_iQbit_install
    ;;
    5)
    # 退出
    exit 0
    ;;
    *)
    clear
    echo -e "${Green}请输入正确数字 [1-5]${Font}"
    main
    ;;
    esac
}

main