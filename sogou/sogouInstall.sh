#!/bin/bash
#sogouInstall,start-----
echo "需於圖形界面執行 , 是否繼續（y/n）"
read reply leftover
case $reply in
    y* | Y*)
    	;;
    *)
	    exit 1
	    ;;
esac
rm -f /var/run/yum.pid
# yum list installed | grep ibus &> /dev/null
# if [ $? -eq 0 ];then
# 	yum -y remove ibus
# fi
yum -y remove ibus 2> /dev/null
#安裝fcitx相關/dpkg
installStatus=true
whileNum=1
while $installStatus
do
    yum -y install fcitx fcitx-pinyin fcitx-configtool dpkg
    if [ $? -eq 0 ];then
        installStatus=false
    else
    	echo "網絡出錯 , 進行記憶安裝($whileNum)"
    	let whileNum++
    fi
done
mkdir -p /usr/local/src/sogou && cp sogoupinyin_2.2.0.0108_amd64.deb /usr/local/src/sogou && cd /usr/local/src/sogou
#wget http://cdn2.ime.sogou.com/dl/index/1524572264/sogoupinyin_2.2.0.0108_amd64.deb
ar vx sogoupinyin_2.2.0.0108_amd64.deb
tar -Jxvf data.tar.xz  -C /
cp /usr/lib/x86_64-linux-gnu/fcitx/fcitx-sogoupinyin.so /usr/lib64/fcitx/
#-----
#ldd /usr/bin/sogou-qimpanel（查看是否缺失文件）
#非必要，如提示缺失libQtWebKit.so.4，start-----
mkdir -p /data/download &> /dev/null && cd /data/download
wget ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/Ledest:/misc/CentOS_7/x86_64/qtwebkit-2.3.4-6.el7.1.x86_64.rpm
rpm -Uvh qtwebkit-2.3.4-6.el7.1.x86_64.rpm
#非必要，如提示缺失libQtWebKit.so.4，end-----
imsettings-switch fcitx
#如提示文件未發現，無需理會
fcitx -r;fcitx-configtool
#mv /usr/local/sogou/sogoupinyin_2.2.0.0108_amd64.deb /data/download/
echo "--------------------------------------------------"
echo "TODO : 選擇添加搜狗輸入法 >> 重啟電腦"
echo "$0 , success"
echo "--------------------------------------------------"
exit 0
#sogouInstall,start-----