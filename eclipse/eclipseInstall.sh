#!/bin/bash
#eclipseInstall,start-----
#http://www.eclipse.org/downloads/packages/release/Luna/SR2

rm -f /var/run/yum.pid

# echo "需自行準備程序資源 , 是否繼續（y/n）"
# read reply leftover
# case $reply in
#     y* | Y*)
#     	;;
#     *)
# 	    echo "##################################################"
# 		echo "$0,end-----"
# 	    exit 0;;
# esac
# yum -y insatll java
# ls /data/download/eclipse-php-photon-R-linux-gtk-x86_64.tar.gz &> /dev/null
# if [ $? -ne 0 ];then
# 	echo "##################################################"
# 	echo "出錯 : /data/download/eclipse-php-photon-R-linux-gtk-x86_64.tar.gz not found"
# 	echo "資源地址 : https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/photon/R/eclipse-php-photon-R-linux-gtk-x86_64.tar.gz&mirror_id=105"
# 	echo "$0 , end-----"
# 	exit 1
# fi

#cd /data/download && tar -xvf eclipse-php-photon-R-linux-gtk-x86_64.tar.gz -C /usr/local/src
tar -xvf eclipse-php-photon-R-linux-gtk-x86_64.tar.gz -C /usr/local/src
ln -sf /usr/local/src/eclipse/eclipse /usr/local/bin/eclipse &> /dev/null

#-----

# echo '[Desktop Entry]
# Version=1.0
# Encoding=UTF-8
# Name=eclipse
# Terminal=false
# Type=Application
# Categories=Application;Development
# Icon=/usr/local/src/eclipse/icon.xpm
# Exec=/usr/local/src/eclipse/eclipse' > /usr/share/applications/eclipse.desktop

ln -s /usr/local/src/eclipse/eclipse ~/home

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"
exit 0
#eclipseInstall,end-----