#!/bin/bash
#sogouInstall,start-----
echo "��춈D�ν������ , �Ƿ��^�m��y/n��"
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
#���bfcitx���P/dpkg
installStatus=true
whileNum=1
while $installStatus
do
    yum -y install fcitx fcitx-pinyin fcitx-configtool dpkg
    if [ $? -eq 0 ];then
        installStatus=false
    else
    	echo "�W�j���e , �M��ӛ�����b($whileNum)"
    	let whileNum++
    fi
done
mkdir -p /usr/local/src/sogou && cp sogoupinyin_2.2.0.0108_amd64.deb /usr/local/src/sogou && cd /usr/local/src/sogou
#wget http://cdn2.ime.sogou.com/dl/index/1524572264/sogoupinyin_2.2.0.0108_amd64.deb
ar vx sogoupinyin_2.2.0.0108_amd64.deb
tar -Jxvf data.tar.xz  -C /
cp /usr/lib/x86_64-linux-gnu/fcitx/fcitx-sogoupinyin.so /usr/lib64/fcitx/
#-----
#ldd /usr/bin/sogou-qimpanel���鿴�Ƿ�ȱʧ�ļ���
#�Ǳ�Ҫ������ʾȱʧlibQtWebKit.so.4��start-----
mkdir -p /data/download &> /dev/null && cd /data/download
wget ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/Ledest:/misc/CentOS_7/x86_64/qtwebkit-2.3.4-6.el7.1.x86_64.rpm
rpm -Uvh qtwebkit-2.3.4-6.el7.1.x86_64.rpm
#�Ǳ�Ҫ������ʾȱʧlibQtWebKit.so.4��end-----
imsettings-switch fcitx
#����ʾ�ļ�δ�l�F���o�����
fcitx -r;fcitx-configtool
#mv /usr/local/sogou/sogoupinyin_2.2.0.0108_amd64.deb /data/download/
echo "--------------------------------------------------"
echo "TODO : �x������ѹ�ݔ�뷨 >> �؆���X"
echo "$0 , success"
echo "--------------------------------------------------"
exit 0
#sogouInstall,start-----