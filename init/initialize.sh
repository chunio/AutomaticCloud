#!/bin/bash

:<<MARK
自行執行
#安裝vim/wget/table鍵補全/netstat/自主交互
yum -y install vim wget bash-completion net-tools expect tree
//-----
PING不通外網排查步驟：
0，是否支持：curl http://www.baidu.com
0，是否能PING通網關
1，排除是否網段衝突引起
2，ip a //查看網卡地址，如存在地址不對稱，則隨意更新/etc/sysconfig/network-scripts/ifcfg-ens33的uuid重啟解決
3，traceroute www.baidu.com //查看路由走向，如網關超時，則本地問題
4，終端1：tcpdump -i ens33，終端2：ping baidu.com 
5，uuidgen ens33 //重置網卡UUID
MARK

#變量配置,start-----
CURRENT_PATH=$(pwd)
echo "--------------------------------------------------"
echo "hostname :"
read hostname leftover
# echo "--------------------------------------------------"
# echo "ip address ( 10.0.0.0 ) :"
# read IPAddress leftover
echo "--------------------------------------------------"
echo "do you need to install graphical desktop?（y/n）"
read graphicalDesktopInstallStatus leftover
echo "--------------------------------------------------"
echo "do you need to install vnc?（y/n）"
read vncInstallStatus leftover
if [ $vncInstallStatus == "y" ];then
echo "--------------------------------------------------"
echo "vnc index ( 5 9 - - ) :"
read vncIndex leftover
echo "--------------------------------------------------"
echo "vnc password :"
read vncPassword leftover
fi
#變量配置,end-----

function DesktopInstall() {
	#最小安裝>>安裝係統桌面，start-----
	#yum -y update
	yum -y install epel-release
	yum -y groupinstall "X Window system"
	yum -y groupinstall "GNOME Desktop"
	systemctl set-default graphical.target
	#最小安裝>>安裝係統桌面，end-----
#-----
echo '#!/bin/bash
case "$1" in
3 | command)
	systemctl set-default multi-user.target
    reboot
	;;
5 | graphical)
	systemctl set-default graphical.target
	reboot
	;;
*)
	echo "usage : switchRunlevel { 3/command | 5/graphical }"
    exit 1
	;;
esac' > /usr/local/bin/switchRunlevel
	chmod 755 /usr/local/bin/switchRunlevel
#-----
}

function VNCInstall() {

	VNC_INDEX=$1
	VNC_PASSWORD=$2

	yum -y install tigervnc-server
	yum -y install expect
expect << EOF
spawn vncserver
expect "*Password*" { send "$VNC_PASSWORD\r" }
expect "*Verify*" { send "$VNC_PASSWORD\r" }
expect "*view-only*" { send "n\r" }
expect eof
EOF
	vncPort="59$VNC_INDEX"
echo '#默認開啟vnc,start-----
netstat -ntlp | grep '$vncPort' &> /dev/null
if [ $? -ne 0 ];then
vnc'$vncPort'
fi
#默認開啟vnc,end-----' >> /etc/profile
echo "vncserver :$VNC_INDEX
iptables -I INPUT -p tcp --dport $vncPort -j ACCEPT" > /usr/local/bin/vnc$vncPort
chmod 755 /usr/local/bin/vnc$vncPort

}

function Initialize {
	#檢測基礎目錄，start-----
	folderList='/windows /SambaLinux /data/download'
	for folder in $folderList
	do
		ls $folder &> /dev/null
		if [ $? -ne 0 ];then
			mkdir -p $folder
			# setfacl -d --set u:root:rwx -R /data/shell/ &> /dev/null
			# setfacl -d --set u:root:rwx -R /usr/local/bin/ &> /dev/null
		fi
	done
	#檢測基礎目錄，end-----
	#默認配置,start-----
	#編輯主機名稱
	echo "$hostname" > /etc/hostname
	echo 'set nu' >> ~/.vimrc
	#切換語言，中文(台灣):LANG=zh_TW.UTF-8
	#echo 'LANG=en_US.UTF-8' > /etc/locale.conf
	#默認配置,end-----
	#關閉SELINUX
	setenforce 0
	sed -i "s@SELINUX=enforcing@SELINUX=Permissive@g" /etc/selinux/config
	#關閉防火墻
	systemctl stop firewalld.service
	systemctl disable firewalld.service
}

function YumRepoInstall() {
	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
	#163-----
	wget http://mirrors.163.com/.help/CentOS7-Base-163.repo -O /etc/yum.repos.d/CentOS-Base.repo
	#epel-----
	yum -y install epel-release-7-11.noarch
	#rpmforge-----
	yum -y localinstall --nogpgcheck http://repository.it4i.cz/mirrors/repoforge/redhat/el7/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
	#nuxDextop-----
	wget http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm -O /data/download/nux-dextop-release-0-5.el7.nux.noarch.rpm
	rpm -Uvh /data/download/nux-dextop-release-0-5.el7.nux.noarch.rpm
	#elrepo-----
	rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
	rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
	yum clean all && yum makecache
}

function BaseInstall() {

	CURRENT_PATH=$1

	yum -y group install "Development Tools"
	yum -y group install "Compatibility Libraries"
	yum -y install dos2unix
	# find / -type f -exec dos2unix {} \;

	#cmake/ccmake?,start-----
	#https://cmake.org/download/
	# yum -y remove cmake
	# cd $CURRENT_PATH && tar -xvf cmake-3.14.4.tar.gz -C /usr/local/src && cd /usr/local/src/cmake-3.14.4
	# ./configure
	# gmake && make install
	# bison,start-----
	# 解決安裝PHP5445的報錯(onfigure: WARNING: bison versions supported for regeneration of the Zend/PHP parsers xxxx (found: 3.0))
	# wget http://ftp.gnu.org/gnu/bison/bison-2.4.1.tar.gz
	# cd $CURRENT_PATH && tar -xvf bison-2.4.1.tar.gz -C /usr/local/src/ && cd /usr/local/src/bison-2.4.1
	# ./configure
	# make -j8 && make install

}

function FolderMount() {
	#share /windows to linux，start-----
	# temp mount
	# mount -t cifs -o username=zengweitao,password=20190517,rw,file_mode=0777,dir_mode=0777,uid=1001,gid=1001 //192.168.228.1/CodeRepository /windows
	# uid=1001,gid=1001選項可省略
	echo '#//10.0.0.1/CodeRepository /windows cifs dir_mode=0777,file_mode=0777,username=zengweitao,password=0000,uid=1001,gid=1001,vers=3.0 0 0' >> /etc/fstab
	#share /data to windows，start-----
	yum -y install samba
echo "
[data]
        path = /SambaLinux
        public = yes
        writable = yes
        read only = no
        browseable = yes
        workgroup = WORKGROUP" >> /etc/samba/smb.conf
	useradd samba
expect << EOF
spawn smbpasswd -a samba
expect "*password*" { send "0000\r" }
expect "*password*" { send "0000\r" }
expect eof
EOF
	systemctl enable smb
	systemctl restart smb
	chown -R samba:samba /SambaLinux
}

function Network {
	IPAddress=$1
	echo 'TYPE=Ethernet
NAME=ens33
DEVICE=ens33
DEFROUTE=yes
BOOTPROTO=none
BROWSER_ONLY=no
PROXY_METHOD=none
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_PRIVACY=no
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
ONBOOT=yes
PREFIX=24
IPADDR='${IPAddress}'
NETMASK=255.0.0.0
GATEWAY=10.0.0.254
DNS1=114.114.114.114
UUID=ff0191ec-6709-4b23-93a2-9060de6d3f87' > /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'search localhost
nameserver 114.114.114.114' > /etc/resolv.conf
systemctl restart network.service
# -----
# nmcli connection show
# nmcli connection modify 'ens33' ipv4.method manual ipv4.addresses 192.168.181.121/24 ipv4.gateway 192.168.181.255 connection.autoconnect yes
# nmcli connection up 'ens33'
# -----
}

if [ $graphicalDesktopInstallStatus == "y" ];then
	DesktopInstall
fi
if [ $vncInstallStatus == "y" ];then
	VNCInstall $vncIndex $vncPassword
fi
Initialize
YumRepoInstall
BaseInstall $CURRENT_PATH
FolderMount
#Network $IPAddress

echo "--------------------------------------------------"
echo "TODO : 1vim /etc/fstab , 2reboot"
echo "$0 , success"
echo "--------------------------------------------------"


