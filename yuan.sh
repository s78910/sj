#!/system/bin/sh
echo
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo

#获取本地ip
IPMAIN=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
echo "\033[32m您的ip地址：\033[0m"$IPMAIN

# 检查第一个目标目录是否存在，并删除除了UE4Game之外的所有文件和文件夹
TARGET_DIR1="/data/data/com.tencent.tmgp.dfm/"

# 检查第一个目标目录是否存在，并删除除了UE4Game之外的所有文件和文件夹
if [ -d "$TARGET_DIR1" ]; then
    echo "\033[32m开始删除 $TARGET_DIR1 目录下除了UE4Game之外的所有文件和文件夹...\033[0m"
    find "$TARGET_DIR1" -mindepth 1 -maxdepth 1 ! -name '' ! -name '..' -exec rm -rf {} \;
    echo "\033[32m清理完成\033[0m"
else
    echo "\033[32m第三个目标目录不存在: $TARGET_DIR1\033[0m"
fi

echo
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo

#------------------------------------------------------------------------------------------


# 检查第二个目标目录是否存在，并删除除了files之外的所有文件和文件夹
TARGET_DIR2="/data/user_de/0/com.tencent.tmgp.dfm/"

# 检查第二个目标目录是否存在，并删除除了files之外的所有文件和文件夹
if [ -d "$TARGET_DIR2" ]; then
    echo "\033[32m开始删除 $TARGET_DIR2 目录下除了files之外的所有文件和文件夹...\033[0m"
    find "$TARGET_DIR2" -mindepth 1 -maxdepth 1 ! -name '' ! -name '..' -exec rm -rf {} \;
    echo "\033[32m清理完成\033[0m"
else
    echo "\033[32m第三个目标目录不存在: $TARGET_DIR2\033[0m"
fi

echo
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo

#------------------------------------------------------------------------------------------



# 检查第三个目标目录是否存在，并删除除了UE4Game之外的所有文件和文件夹
TARGET_DIR3="/storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/"

# 检查第三个目标目录是否存在，并删除除了UE4Game之外的所有文件和文件夹
if [ -d "$TARGET_DIR3" ]; then
    echo "\033[32m开始删除 $TARGET_DIR3 目录下除了UE4Game之外的所有文件和文件夹...\033[0m"
    find "$TARGET_DIR3" -mindepth 1 -maxdepth 1 ! -name 'UE4Game' ! -name 'AppVersionCache.txt' ! -name 'ProgramBinaryCache' ! -name 'g6_player_prefs.ini' -exec rm -rf {} \;
    echo "\033[32m清理完成\033[0m"
else
    echo "\033[32m第三个目标目录不存在: $TARGET_DIR3\033[0m"
fi


echo
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo
#------------------------------------------------------------------------------------------



# 第四个目标目录，删除所有子文件夹
TARGET_DIR4="/storage/emulated/0/Android/data/com.tencent.tmgp.dfm/"

# 检查第四个目标目录是否存在，并删除了所有文件和文件夹
if [ -d "$TARGET_DIR4" ]; then
    echo "\033[32m开始删除 $TARGET_DIR4 清理目录下所有文件和文件夹...\033[0m"
    find "$TARGET_DIR4" -mindepth 1 -maxdepth 1 ! -name 'files' ! -name '..' -exec rm -rf {} \;
    echo "\033[32m清理完成\033[0m"
else
    echo "\033[32m第三个目标目录不存在: $TARGET_DIR4\033[0m"
fi


echo
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo

# 第五个目标目录，删除所有子文件夹
TARGET_DIR5="/storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/"

# 检查第四个目标目录是否存在，并删除了所有文件和文件夹
if [ -d "$TARGET_DIR5" ]; then
    echo "\033[32m开始删除 $TARGET_DIR5 清理目录下所有文件和文件夹...\033[0m"
    find "$TARGET_DIR5" -mindepth 1 -maxdepth 1 ! -name 'UAGame' ! -name 'Engine' -exec rm -rf {} \;
    echo "\033[32m清理完成\033[0m"
else
    echo "\033[32m第三个目标目录不存在: $TARGET_DIR5\033[0m"
fi


echo
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo



# 第六个目标目录，删除所有子文件夹
TARGET_DIR6="/data/miuilog/stability/scout/app/"

# 检查第四个目标目录是否存在，并删除了所有文件和文件夹
if [ -d "$TARGET_DIR6" ]; then
    echo "\033[32m开始删除 $TARGET_DIR6 清理目录下所有文件和文件夹...\033[0m"
    find "$TARGET_DIR6" -mindepth 1 -maxdepth 1 ! -name '' ! -name '' -exec rm -rf {} \;
    echo "\033[32m清理完成\033[0m"
else
    echo "\033[32m第三个目标目录不存在: $TARGET_DIR5\033[0m"
fi

echo
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo
#
iptables -F 
iptables -X 
iptables -Z
iptables -t nat -F 
ip6tables -F
ip6tables -X
ip6tables -Z
ip6tables=/system/bin/ip6tables
iptables=/system/bin/iptables



rm -rf /storage/emulated/0/Documents
#删除data内部垃圾
rm -rf /data/app/~~FHb1d8xe1FtQcfYMwGll2Q==/com.tencent.tmgp.dfm-SwyOZkxCpE4DFb9gVSxZ2Q==/oat/arm64/*
rm -rf /data/per_boot
rm -rf /data/server_configurable_flags
rm -rf /data/apk-tmp
rm -rf /data/dpm
rm -rf /data/bootanim
rm -rf /data/rollback-history
rm -rf /data/rollback
rm -rf /data/incremental
rm -rf /data/ss
rm -rf /data/ota_package
rm -rf /data/ota
rm -rf /data/mediadrm
rm -rf /data/preloads
rm -rf /data/fonts
rm -rf /data/app-private
rm -rf /data/app-lib
rm -rf /data/app-ephemeral
rm -rf /data/app-asec
rm -rf /data/app-staging
rm -rf /data/miui
rm -rf /data/anr
rm -rf /data/bootchart
rm -rf /data/rollback-observer
rm -rf /data/cache/*
rm -rf /data/system/dropbox/*
echo
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo
echo "\033[32m修复完成\033[0m"

echo "\033[32m操作完成\033[0m"
#随机序列号
    name=$(tr -dc '1-9' < /dev/urandom | head -c 8)
    while echo "$name" | grep -q "'"; do
        name=$(tr -dc '1-9' < /dev/urandom | head -c 8)
    done 
    resetprop ro.serialno $name
    echo -e "\033[32mSuccess_FTP|随机序列号:$name\033[0m"

echo 正在清理...
am force-stop com.tencent.tmgp.dfm
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Logs/*
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Pandora/Logs/*
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Pandora/Cookies/*
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Pandora/Caches/*
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/patch/apollo_reslist.flist
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/patch/filelist.json
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/CDNCached
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Pandora
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/puffer_progress
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/1.0.62.62
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/patch
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Logs
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Config
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/cache
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/Engine
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/Manifest_UFSFiles_Android.txt
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/program_version.txt
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/AppVersionCache.txt
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/g6_player_prefs.ini
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/log
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/ProgramBinaryCache
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/TGPA
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/RookieIdTimes.json
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/TriggerTimes.json
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/CacheShowMovie
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Config
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/patch
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Pandora 
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/pixuicache
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Gamelet
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/CDNCached
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/MailJson
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/NotAllowedUnattendedBugReports
echo
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo

echo
echo 清除封号日志成功√
echo
echo 请修改设备ID后再上游戏
echo
echo 否则游戏又会在本地生成该设备的封禁信息日志

echo -e "\033[41m---全部完成---\033[0m"
echo -e "\033[41m---准备更改设备ID---\033[0m"
echo -e "\033[41m---稍等---\033[0m"

sleep 3s


echo -e "\033[41m---即将更改你的aid---\033[0m"
echo -e "\033[41m---请稍等---\033[0m"

sleep 3s



PKG=com.tencent.tmgp.dfm
ID=$(grep $PKG /data/system/users/0/settings_ssaid.xml | awk -F'"' '{print $6}')
for i in $(seq 16)
do P=$P$(uuidgen|head -c 1|tr '-' -d)
done
sed -i s/$ID/$P/g /data/system/users/0/settings_ssaid.xml

echo -e "\033[41m---aid更改成功---\033[0m"
echo -e "\033[41m---重启即可---\033[0m"

echo 正在清理...
am force-stop com.tencent.tmgp.dfm
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Logs/*
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Pandora/Logs/*
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Pandora/Cookies/*
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Pandora/Caches/*
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/patch/apollo_reslist.flist
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/patch/filelist.json
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/CDNCached
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Pandora
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/puffer_progress
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/1.0.62.62
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/patch
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Logs
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Config
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/cache
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/Engine
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/Manifest_UFSFiles_Android.txt
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/program_version.txt
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/AppVersionCache.txt
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/g6_player_prefs.ini
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/log
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/ProgramBinaryCache
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/TGPA
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/RookieIdTimes.json
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/TriggerTimes.json
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/CacheShowMovie
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Config
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/patch
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Pandora 
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/pixuicache
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/Gamelet
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/CDNCached
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/UAGame/Saved/MailJson
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files/UE4Game/UAGame/NotAllowedUnattendedBugReports
echo
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo
echo 清除封号日志成功√
echo
echo 请修改设备ID后再上游戏
echo
echo 否则游戏又会在本地生成该设备的封禁信息日志

echo -e "\033[41m---全部完成---\033[0m"
echo -e "\033[41m---准备更改设备ID---\033[0m"
echo -e "\033[41m---稍等---\033[0m"

sleep 3s


echo -e "\033[41m---即将更改你的aid---\033[0m"
echo -e "\033[41m---请稍等---\033[0m"

sleep 3s



PKG=com.tencent.tmgp.dfm
ID=$(grep $PKG /data/system/users/0/settings_ssaid.xml | awk -F'"' '{print $6}')
for i in $(seq 16)
do P=$P$(uuidgen|head -c 1|tr '-' -d)
done
sed -i s/$ID/$P/g /data/system/users/0/settings_ssaid.xml

echo -e "\033[41m---aid更改成功---\033[0m"
echo -e "\033[41m---重启即可---\033[0m"

APP_UID=$(dumpsys package com.tencent.tmgp.dfm | grep uid= | awk '{print $1}' | cut -d'=' -f2 | uniq)


sleep 1
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜
echo "获取到三角洲UID $APP_UID"

echo "已开始清理"
echo "1"
sleep 1
rm -rf /data/data/com.tencent.tmgp.dfm/app_crashrecord
rm -rf /data/data/com.tencent.tmgp.dfm/app_crashSight
rm -rf /data/data/com.tencent.tmgp.dfm/app_dex
rm -rf /data/data/com.tencent.tmgp.dfm/app_midaslib_0
rm -rf /data/data/com.tencent.tmgp.dfm/app_midaslib_1
rm -rf /data/data/com.tencent.tmgp.dfm/app_midasodex
rm -rf /data/data/com.tencent.tmgp.dfm/app_midasplugins
rm -rf /data/data/com.tencent.tmgp.dfm/app_tbs
rm -rf /data/data/com.tencent.tmgp.dfm/app_tbs_64
rm -rf /data/data/com.tencent.tmgp.dfm/app_midasodex
rm -rf /data/data/com.tencent.tmgp.dfm//data/data/com.tencent.tmgp.dfm/app_texturespp_tbs_64
rm -rf /data/data/com.tencent.tmgp.dfm/app_tbs_common_share
rm -rf /data/data/com.tencent.tmgp.dfm/app_textures
rm -rf /data/data/com.tencent.tmgp.dfm/app_turingdfp
rm -rf /data/data/com.tencent.tmgp.dfm/app_turingfd
rm -rf /data/data/com.tencent.tmgp.dfm/app_webview
rm -rf /data/data/com.tencent.tmgp.dfm/app_x5webview
rm -rf /data/data/com.tencent.tmgp.dfm/cache
rm -rf /data/data/com.tencent.tmgp.dfm/code_cache
rm -rf /data/data/com.tencent.tmgp.dfm/databases
rm -rf /data/data/com.tencent.tmgp.dfm/filescommonCache
rm -rf /data/data/com.tencent.tmgp.dfm/shared_prefs
rm -rf /data/data/com.tencent.tmgp.dfm/files/app
rm -rf /data/data/com.tencent.tmgp.dfm/files/beacon
rm -rf /data/data/com.tencent.tmgp.dfm/files/com.gcloudsdk.gcloud.gvoice
rm -rf /data/data/com.tencent.tmgp.dfm/files/data
rm -rf /data/data/com.tencent.tmgp.dfm/files/live_log
rm -rf /data/data/com.tencent.tmgp.dfm/files/popup
rm -rf /data/data/com.tencent.tmgp.dfm/files/tbs
rm -rf /data/data/com.tencent.tmgp.dfm/files/qm
rm -rf /data/data/com.tencent.tmgp.dfm/files/tdm_tmp
rm -rf /data/data/com.tencent.tmgp.dfm/files/wupSCache
rm -rf /data/user/0/com.tencent.tmgp.dfm/files/ano_tmp/
rm -rf /data/data/com.tencent.tmgp.dfm/files/apm_qcc_finally
rm -rf /data/data/com.tencent.tmgp.dfm/files/apm_qcc
rm -rf /data/data/com.tencent.tmgp.dfm/files/hawk_data
rm -rf /data/data/com.tencent.tmgp.dfm/files/itop_login.txt
rm -rf /data/data/com.tencent.tmgp.dfm/files/jwt_token.txt
rm -rf /data/data/com.tencent.tmgp.dfm/files/MSDK.mmap3
rm -rf /data/data/com.tencent.tmgp.dfm/files/com.tencent.tdm.qimei.sdk.QimeiSDK
rm -rf /data/data/com.tencent.tmgp.dfm/files/com.tencent.tbs.qimei.sdk.QimeiSDK
rm -rf /data/data/com.tencent.tmgp.dfm/files/com.tencent.qimei.sdk.QimeiSDK
rm -rf /data/data/com.tencent.tmgp.dfm/files/com.tencent.open.config.json.1110543085
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files
rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files
rm -rf /data/data/com.oplus.games/files/com.tencent.tmgp.dfm
rm -rf /data/system/package_cache/7f4bacfec0aa8e58b7f30cf1f047f542fff9a98f/com.tencent.tmgp.dfm-q4p54fjyLp6_3YN76Upiug==-0--1909443268
 rm -rf /data/system/graphicsstats/1728345600000/com.tencent.tmgp.dfm
 rm -rf /data/system/package_cache/7f4bacfec0aa8e58b7f30cf1f047f542fff9a98f/com.tencent.tmgp.dfm-Rz73Td_hPHY51Mg-Ww72nA==-0--1765356360
 rm -rf /data/misc/iopgp/com.tencent.tmgp.dfm
 rm -rf /data/system/graphicsstats/1728432000000/com.tencent.tmgp.dfm
 rm -rf /storage/emulated/0/Android/data/com.oplus.games/files/funcMonitor/com.tencent.tmgp.dfm-game_func_rec
echo 16384 > /proc/sys/fs/inotify/max_queued_events
echo 128 > /proc/sys/fs/inotify/max_user_instances
echo 8192 > /proc/sys/fs/inotify/max_user_watches


echo 清理完成
echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜

echo 刷机做环境找微信S78910JQKKKAA
echo 更新日期:2025年10月03号
echo 姜太公钓瑜

chmod 777 *.sh
MATRIX="0123456789qwertyuiopasdfghjklzxcvbnm"
LENGTH="16"
while [ "${n:=1}" -le "$LENGTH" ]
do
        PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
        let n+=1
done
        settings put secure android_id "$PASS"
echo 采用$RANDOM变量随机
echo 设备ID已更改
echo 当前ID


MATRIX="0123456789qwertyuiopasdfghjklzxcvbnm"
LENGTH="16"
while [ "${n:=1}" -le "$LENGTH" ]
do
        PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
        let n+=1
done
        echo "$PASS"

echo 
prog_name="/data/temp"
name=$(tr -dc \'1-9\' < /dev/urandom | head -c 8)
while echo "$name" | grep -q "'"
do
name=$(tr -dc \'1-9\' < /dev/urandom | head -c 8)
done 
yy=$(getprop ro.serialno)
echo "原值：ro.serialno:$yy"
resetprop ro.serialno $name
echo 
yy=$(getprop ro.serialno)
echo "修改后：ro.serialno:$yy"
#getprop ro.serialno

echo "刷机做环境找微信S78910JQKKKAA"
echo "更新日期:2025年10月03号"
echo "姜太公钓瑜"
echo
echo "因为重启恢复的缘故，所以每次重启都要执行一遍该脚本。"
echo 
prog_name="/data/temp"
name=$(tr -dc \'1-9\' < /dev/urandom | head -c 8)
while echo "$name" | grep -q "'"
do
name=$(tr -dc \'1-9\' < /dev/urandom | head -c 8)
done 
yy=$(getprop ro.serialno)
echo "原值：ro.serialno:$yy"
resetprop ro.serialno $name
echo 
yy=$(getprop ro.serialno)
echo "修改后：ro.serialno:$yy"
#getprop ro.serialno

echo "刷机做环境找微信S78910JQKKKAA"
echo "更新日期:2025年10月03号"
echo "姜太公钓瑜"
prog_name="/data/temp"
name=$(tr -dc \'1-9\' < /dev/urandom | head -c 8)
while echo "$name" | grep -q "'"
do
name=$(tr -dc \'1-9\' < /dev/urandom | head -c 8)
done 
yy=$(getprop ro.serialno)
echo "原值：ro.serialno:$yy"
resetprop ro.serialno $name
echo 
yy=$(getprop ro.serialno)
echo "修改后：ro.serialno:$yy"
#getprop ro.serialno

echo
echo "刷机做环境找微信S78910JQKKKAA"
echo "更新日期:2025年10月03号"
echo "姜太公钓瑜"
echo 
prog_name="/data/temp"
name=$(tr -dc \'1-9\' < /dev/urandom | head -c 8)
while echo "$name" | grep -q "'"
do
name=$(tr -dc \'1-9\' < /dev/urandom | head -c 8)
done 
yy=$(getprop ro.serialno)
echo "原值：ro.serialno:$yy"
resetprop ro.serialno $name
echo 
yy=$(getprop ro.serialno)
echo "修改后：ro.serialno:$yy"
#getprop ro.serialno

echo "刷机做环境找微信S78910JQKKKAA"
echo "更新日期:2025年10月03号"
echo "姜太公钓瑜"
echo '旧android_id '$(settings get secure android_id)
settings put secure android_id $(tr -cd 'abcdef0123456789' < /dev/urandom | head -c 16)
echo '新android_id '$(settings get secure android_id)





ID_TYPE=global
ID_NAME=gcbooster_uuid
echo "旧${ID_NAME} "$(settings get ${ID_TYPE} ${ID_NAME})
settings put ${ID_TYPE} ${ID_NAME} $(uuidgen)
echo "新${ID_NAME} "$(settings get ${ID_TYPE} ${ID_NAME})




ID_TYPE=global
ID_NAME=extm_uuid
echo "旧${ID_NAME} "$(settings get ${ID_TYPE} ${ID_NAME})
settings put ${ID_TYPE} ${ID_NAME} $(uuidgen)
echo "新${ID_NAME} "$(settings get ${ID_TYPE} ${ID_NAME})

ID_TYPE=system
ID_NAME=key_mqs_uuid
echo "旧${ID_NAME} "$(settings get ${ID_TYPE} ${ID_NAME})
settings put ${ID_TYPE} ${ID_NAME} $(uuidgen)
echo "新${ID_NAME} "$(settings get ${ID_TYPE} ${ID_NAME})

ID_TYPE=system
ID_NAME=local_uuid
echo "旧${ID_NAME} "$(settings get ${ID_TYPE} ${ID_NAME})
settings put ${ID_TYPE} ${ID_NAME} $(uuidgen)
echo "新${ID_NAME} "$(settings get ${ID_TYPE} ${ID_NAME})

{
    APP_UID=$(dumpsys package com.tencent.tmgp.dfm | grep uid= | awk '{print $1}' | cut -d'=' -f2 | uniq)
    sleep 1
    echo "姜太公一键清理-当前三角洲Uid $APP_UID"
    echo "姜太公一键清理-三角洲清理  $APP_UID"
    sleep 1
    rm -rf /data/*/com.tencent.tmgp.dfm/app_crashrecord
    rm -rf /data/*/com.tencent.tmgp.dfm/app_crashSight
    rm -rf /data/*/com.tencent.tmgp.dfm/app_dex
    rm -rf /data/*/com.tencent.tmgp.dfm/app_midaslib_0
    rm -rf /data/*/com.tencent.tmgp.dfm/app_midaslib_1
    rm -rf /data/*/com.tencent.tmgp.dfm/app_midasodex
    rm -rf /data/*/com.tencent.tmgp.dfm/app_midasplugins
    rm -rf /data/*/com.tencent.tmgp.dfm/app_tbs
    rm -rf /data/*/com.tencent.tmgp.dfm/app_tbs_64
    rm -rf /data/*/com.tencent.tmgp.dfm/app_midasodex
    rm -rf /data/*/com.tencent.tmgp.dfm//data/*/com.tencent.tmgp.dfm/app_texturespp_tbs_64
    rm -rf /data/*/com.tencent.tmgp.dfm/app_tbs_common_share
    rm -rf /data/*/com.tencent.tmgp.dfm/app_textures
    rm -rf /data/*/com.tencent.tmgp.dfm/app_turingdfp
    rm -rf /data/*/com.tencent.tmgp.dfm/app_turingfd
    rm -rf /data/*/com.tencent.tmgp.dfm/app_webview
    rm -rf /data/*/com.tencent.tmgp.dfm/app_x5webview
    rm -rf /data/*/com.tencent.tmgp.dfm/cache
    rm -rf /data/*/com.tencent.tmgp.dfm/code_cache
    rm -rf /data/*/com.tencent.tmgp.dfm/databases
    rm -rf /data/*/com.tencent.tmgp.dfm/filescommonCache
    rm -rf /data/*/com.tencent.tmgp.dfm/shared_prefs
    rm -rf /data/*/com.tencent.tmgp.dfm/files/app
    rm -rf /data/*/com.tencent.tmgp.dfm/files/beacon
    rm -rf /data/*/com.tencent.tmgp.dfm/files/com.gcloudsdk.gcloud.gvoice
    rm -rf /data/*/com.tencent.tmgp.dfm/files/data
    rm -rf /data/*/com.tencent.tmgp.dfm/files/live_log
    rm -rf /data/*/com.tencent.tmgp.dfm/files/popup
    rm -rf /data/*/com.tencent.tmgp.dfm/files/tbs
    rm -rf /data/*/com.tencent.tmgp.dfm/files/qm
    rm -rf /data/*/com.tencent.tmgp.dfm/files/tdm_tmp
    rm -rf /data/*/com.tencent.tmgp.dfm/files/wupSCache
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/ano_tmp/
    rm -rf /data/*/com.tencent.tmgp.dfm/files/apm_qcc_finally
    rm -rf /data/*/com.tencent.tmgp.dfm/files/apm_qcc
    rm -rf /data/*/com.tencent.tmgp.dfm/files/hawk_data
    rm -rf /data/*/com.tencent.tmgp.dfm/files/itop_login.txt
    rm -rf /data/*/com.tencent.tmgp.dfm/files/jwt_token.txt
    rm -rf /data/*/com.tencent.tmgp.dfm/files/MSDK.mmap3
    rm -rf /data/*/com.tencent.tmgp.dfm/files/com.tencent.tdm.qimei.sdk.QimeiSDK
    rm -rf /data/*/com.tencent.tmgp.dfm/files/com.tencent.tbs.qimei.sdk.QimeiSDK
    rm -rf /data/*/com.tencent.tmgp.dfm/files/com.tencent.qimei.sdk.QimeiSDK
    rm -rf /data/*/com.tencent.tmgp.dfm/files/com.tencent.open.config.json.1110543085
    rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files
    rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files
    rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/cache
    rm -rf /storage/emulated/0/Android/data/com.tencent.tmgp.dfm/files
    rm -rf /data/user/*/com.tencent.tmgp.dfm/app_crashrecord
    rm -rf /data/user/*/com.tencent.tmgp.dfm/app_crashSight
    rm -rf /data/user/*/com.tencent.tmgp.dfm/app_databases
    rm -rf /data/user/*/com.tencent.tmgp.dfm/app_msdk
    rm -rf /data/user/*/com.tencent.tmgp.dfm/app_turingdfp
    rm -rf /data/user/*/com.tencent.tmgp.dfm/app_turingfd
    rm -rf /data/user/*/com.tencent.tmgp.dfm/app_turingsmi
    rm -rf /data/user/*/com.tencent.tmgp.dfm/cache
    rm -rf /data/user/*/com.tencent.tmgp.dfm/databases
    rm -rf /data/user/*/com.tencent.tmgp.dfm/shared_prefs
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/app
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/beacon
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/com.gcloudsdk.gcloud.gvoice
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/data
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/popup
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/qm
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/tdm_tmp 
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/.iii
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/.system_android_l2
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/ace_shell_di.dat
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/apm_qcc
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/apm_qcc_finally
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/apm_qcc_preonce
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/apm_qcc_preonce_cache
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/com.tencent.qimei.sdk.QimeiSDK
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/com.tencent.tdm.qimei.sdk.QimeiSDK
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/com.tencent.tmgp.dfm_core_godcmd_history
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/libwbsafeedit_64.so
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/login-identifier.txt
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/MSDK.mmap3
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/tdm_counter
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/tdm_track.dat
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/TRI_CM_AUDIT
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/tri_init

    rm -rf /data/*/com.tencent.tmgp.pubgmhd/files/ano_tmp
    rm -rf /data/user/*/com.tencent.tmgp.pubgmhd/files/ano_tmp
        rm -rf /data/*/com.tencent.tmgp.cf/files/ano_tmp
    rm -rf /data/user/*/com.tencent.tmgp.cf/files/ano_tmp
    rm -rf /data/*/com.tencent.tmgp.dfm/files/ano_tmp
    rm -rf /data/*/com.proximabeta.mf.uamo/files/ano_tmp
    rm -rf /data/user/*/com.proximabeta.mf.uamo/files/ano_tmp
    rm -rf /data/user/*/com.tencent.tmgp.dfm/files/ano_tmp
    rm -rf /data/*/com.tencent.tmgp.cf/files/ano_tmp
    rm -rf /data/user/*/com.tencent.tmgp.cf/files/ano_tmp
    echo 16384 > /proc/sys/fs/inotify/max_queued_events
    echo 128 > /proc/sys/fs/inotify/max_user_instances
    echo 8192 > /proc/sys/fs/inotify/max_user_watches
    
    iptables -F
    iptables -X 
    iptables -Z
    iptables -t nat -F 
    echo "姜太公一键清理-本地缓存数据处理成功"
    #清楚iptables规则
    iptables -F
    echo "姜太公一键清理-iptables规则清除成功"
    ip6tables=/system/bin/ip6tables
    iptables=/system/bin/iptables
    
    echo "姜太公一键清理-执行初始化IP..."
    INTERFACE="wlan0"
    IP=$(ip addr show $INTERFACE | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1)
    IP_PREFIX=$(echo $IP | cut -d. -f1-3)
    NEW_IP_LAST_PART1=$(($RANDOM % 254 + 1))
    NEW_IP_LAST_PART2=$(($RANDOM % 254 + 1))
    NEW_IP1="${IP_PREFIX}.${NEW_IP_LAST_PART1}"
    NEW_IP2="${IP_PREFIX}.${NEW_IP_LAST_PART2}"
    ip addr add $NEW_IP1/24 dev $INTERFACE
    ip addr add $NEW_IP2/24 dev $INTERFACE
    
    echo "原始网络IP地址是: $IP"
             
    settings put global airplane_mode_on 1
    am broadcast -a android.intent.action.AIRPLANE_MODE --ez state true         
    prog_name="/data/temp"
    name=$(tr -dc \'1-9\' < /dev/urandom | head -c 8)
    while echo "$name" | grep -q "'"
    do
    name=$(tr -dc \'1-9\' < /dev/urandom | head -c 8)
    done 
    yy=$(getprop ro.serialno)
    resetprop ro.serialno $name
    echo 
    yy=$(getprop ro.serialno)
    settings put global airplane_mode_on 0
    am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false
    echo "姜太公一键清理-改变IP完毕"            

	clear
	Pf_R() { sleep 0.$RANDOM ;echo "\a\033[5m\033[31m[-]$@" ;sleep 0.$RANDOM ;echo "\033[1A\033[2K\r\a\033[33m[\\]$@\033[K" ;}
	Pf_A() { sleep 0.$RANDOM ;echo "\033[1A\033[2K\r\a\033[32m[+]$*\033[K" ;echo ;}
	Id_Path=/data/system/users/0
	rm -rf $Id_Path/registered_services $Id_Path/app_idle_stats.xml
	Id_File=$Id_Path/settings_ssaid.xml
	abx2xml -i $Id_File
	View_id() { grep $1 $Id_File | awk -F '"' '{print $6}' ;}
	Random_Id_1() { cat /proc/sys/kernel/random/uuid ;}
	Amend_Id() { sed -i "s#$1#$2#g" $Id_File ;}
	Userkey_Uid=`View_id userkey`
	Pf_R 系统UUID：$Userkey_Uid
	Amend_Id $Userkey_Uid $(echo `Random_Id_1``Random_Id_1` | tr -d - | tr a-z A-Z)
	printf "\033[1A\033[2K"
	printf "\033[1A\033[2K"
	Pf_A 系统UUID：`View_id userkey`
	Pf_R 姜太公一键清理-三角洲清理中
	Pf_A 姜太公一键清理-已三角洲清理
	Pkg_Aid=`View_id com.tencent.tmgp.dfm`
	Pf_R 三角洲AID：$Pkg_Aid
	Amend_Id $Pkg_Aid `Random_Id_1 | tr -d - | head -c 16`
	Pf_A 三角洲AID：`View_id com.tencent.tmgp.dfm`
	xml2abx -i $Id_File
	Random_Id_2() {
		Min=$1
		Max=$(($2 - $Min + 1))
		Num=`cat /dev/urandom | head | cksum | awk -F ' ' '{print $1}'`
		echo $(($Num % $Max + $Min))
	}
	Serial_Id=/sys/devices/soc0/serial_number
	Pf_R 主板ID：`cat $Serial_Id`
	Tmp=/sys/devices/virtual/kgsl/kgsl/full_cache_threshold
	Random_Id_2 1100000000 2000000000 > $Tmp
	mount | grep -q $Serial_Id && umount $Serial_Id
	mount --bind $Tmp $Serial_Id
	Pf_A 主板ID：`cat $Serial_Id`
	IFS=$'\n'
	for i in `getprop | grep imei | awk -F '[][]' '{print $2}'`
	do
		Imei=`getprop $i`
		[ `echo $Imei | wc -c` -lt 16 ] && continue
		let a++
		printf "\r\033[31m[-]IMEI：$Imei\033[K"
		printf "\r\033[33m[\\]IMEI：$Imei\033[K"
		resetprop $i `echo $((RANDOM % 80000 + 8610000))00000000`
		printf "\r\033[32m[+]IMEI：`getprop $i`\033[K"
	done
	sleep 0.88s
	printf "\r[+]IMEI：Reset $a⁺\033[K"
	echo \\n
	Oa_Id=/data/system/oaid_persistence_0
	Pf_R OAID：`cat $Oa_Id`
	printf `Random_Id_1 | tr -d - | head -c 16` > $Oa_Id
	Pf_A OAID：`cat $Oa_Id`
	Va_Id=/data/system/vaid_persistence_platform
	Pf_R VAID：`cat $Va_Id`
	printf `Random_Id_1 | tr -d - | head -c 16` > $Va_Id
	Pf_A VAID：`cat $Va_Id`
	Pf_R 序列号：`getprop ro.serialno`
	resetprop ro.serialno `Random_Id_1 | head -c 8`
	Pf_A 序列号：`getprop ro.serialno`
	Pf_R 设备ID：`settings get secure android_id`
	settings put secure android_id `Random_Id_1 | tr -d - | head -c 16`
	Pf_A 设备ID：`settings get secure android_id`
	Pf_R 版本ID：`getprop ro.build.id`
	resetprop ro.build.id UKQ1.$((RANDOM % 20000 + 30000)).001
	Pf_A 版本ID：`getprop ro.build.id`
	Pf_R CPU_ID：`getprop ro.boot.cpuid`
	resetprop ro.boot.cpuid 0x00000`Random_Id_1 | tr -d - | head -c 11`
	Pf_A CPU_ID：`getprop ro.boot.cpuid`
	Pf_R OEM_ID：`getprop ro.ril.oem.meid`
	resetprop ro.ril.oem.meid 9900$((RANDOM % 8000000000 + 1000000000))
	Pf_A OEM_ID：`getprop ro.ril.oem.meid`
	Pf_R 广告ID：`settings get global ad_aaid`
	settings put global ad_aaid `Random_Id_1`
	Pf_A 广告ID：`settings get global ad_aaid`
	Pf_R UUID：`settings get global extm_uuid`
	settings put global extm_uuid `Random_Id_1`
	Pf_A UUID：`settings get global extm_uuid`
	Pf_R 指纹UUID：`settings get system key_mqs_uuid`
	settings put system key_mqs_uuid `Random_Id_1`
	Pf_A 指纹UUID：`settings get system key_mqs_uuid`
	Sum=$(getprop ro.build.fingerprint)
	sleep 0.$RANDOM
	echo "\a\033[5m\033[31m[-]指纹密钥：$Sum"
	sleep 0.$RANDOM
	printf "\033[1A\033[2K"
	echo "\033[1A\033[2K\a\033[5m\033[33m[\\]指纹密钥：$Sum"
	sleep 0.$RANDOM
	printf "\033[1A\033[2K"
	for i in $(seq 1 $(echo "$Sum" | grep -o [0-9] | wc -l))
	do
		Sum=$(echo "$Sum" | sed "s/[0-9]/$(($RANDOM % 10))/$i")
	done
	resetprop ro.build.fingerprint "$Sum"
	echo "\033[1A\033[2K\a\033[5m\033[32m[+]指纹密钥：$(getprop ro.build.fingerprint)\n"
	Pf_R GC驱动器ID：`settings get global gcbooster_uuid`
	settings put global gcbooster_uuid `Random_Id_1`
	Pf_A GC驱动器ID：`settings get global gcbooster_uuid`
	Pf_R IP地址：`curl -s ipinfo.io/ip`
	svc data disable
	svc wifi disable
	sleep 5
	svc data enable
	svc wifi enable
	until ping -c 1 223.5.5.5 &>/dev/null
	do
		sleep 1
	done
	Pf_A IP地址：`curl -s ipinfo.io/ip`
	IFS=$'\n'
	Mac_File=/sys/class/net/wlan0/address
	Pf_R Wifi_Mac地址：`cat $Mac_File`
	mount | grep -q $Mac_File && umount $Mac_File
	svc wifi disable
	ifconfig wlan0 down
	sleep 1
	Mac=`Random_Id_1 | sed 's/-//g ;s/../&:/g' | head -c 17`
	ifconfig wlan0 hw ether $Mac
	for Wlan_Path in `find /sys/devices -name wlan0`
	do
		[ -f "$Wlan_Path/address" ] && {
			chmod 644 "$Wlan_Path/address"
			echo $Mac > "$Wlan_Path/address"
		}
	done
	chmod 0755 $Mac_File
	echo $Mac > $Mac_File
	for Wlan_Path in `find /sys/devices -name '*,wcnss-wlan'`
	do
		[ -f "$Wlan_Path/wcnss_mac_addr" ] && {
			chmod 644 "$Wlan_Path/wcnss_mac_addr"
			echo $Mac > "$Wlan_Path/wcnss_mac_addr"
		}
	done
	Tmp=/data/local/tmp/Mac_File
	echo $Mac > $Tmp
	mount --bind $Tmp $Mac_File
	ifconfig wlan0 up
	svc wifi enable
	sleep 1
	Pf_A Wifi_Mac地址：`cat $Mac_File`
	echo \\033[38m已完成，请重启设备
} 2>/dev/null