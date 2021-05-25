#!/bin/bash

:<<MARK
useradd $username -s /sbin/nologin			->	報錯：fatal: protocol error: bad line length character: This
useradd $username -s /usr/bin/git-shell	->	報錯：需要輸入密碼，且正確密碼無效
#配置權限##################################################
#收集用戶公鑰，start-----
#1,新建公鑰，備註：適用於linux/windows客戶端
#ssh-keygen -t rsa [ -C "zengweitao" -f "c:\id_rsa" ]
#2,添加至服務端
#cat /root/.ssh/id_rsa.pub >> /home/$username/.ssh/authorized_keys
#收集用戶公鑰，end-----
#windows git bash-----
#檢測公私鑰是否生效:
#ssh -vT git@192.168.238.138

# 非必要配置(vim /etc/ssh/sshd_config)，start-----
# 開啟ssh中RSA認證
# vim /etc/ssh/sshd_config
# 開啟公私鑰配對認證
# PubkeyAuthentication yes
# 開啟RSA算法驗證
# RSAAuthentication yes
# AuthorizedKeysFile .ssh/authorized_keys
# 非必要配置(vim /etc/ssh/sshd_config)，end-----

#新建倉庫##################################################
# cd /data/website && git init --bare website.git
# chown -R $username:$username /data/website/website.git
# systemctl restart sshd

#git clone ssh://git@211.149.128.20:22000/windows/GitRepository/chunio/.git --recursive

#before push,start-----
#git config --global user.name zengweitao
#git config --global user.email zengweitao@lenovo.com
#git config --global color.ui true
#before push,end-----
MARK

CURRENT_PATH=$(pwd)
username='git'

function PrepareEnvironment() {
	CURRENT_PATH=$1
	yum -y remove git
	yum -y install curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-devel
	#安裝字符編碼轉換庫-----
	cd $CURRENT_PATH && tar -xvf libiconv-1.15.tar.gz -C /usr/local/src && cd /usr/local/src/libiconv-1.15
	./configure --prefix=/usr/local/libiconv && make -j8 && make install
}

function BaseInstall() {
	CURRENT_PATH=$1
	cd $CURRENT_PATH && tar -xvf git-2.21.0.tar.gz -C /usr/local/src && cd /usr/local/src/git-2.21.0
	make configure && ./configure --prefix=/usr/local --with-iconv=/usr/local/libiconv/ && make install
}

function Configuration() {
	id $username 2> /dev/null
	if [ $? -ne 0 ];then
		useradd $username 2> /dev/null
	fi
	mkdir -p /home/$username/.ssh && touch /home/$username/.ssh/authorized_keys
	chmod 700 /home/$username/.ssh && chmod 600 /home/$username/.ssh/authorized_keys && chown -R $username:$username /home/$username
	git config --global user.name chunio
	git config --global user.email chunio@virtualv2.2.com
	git config --global color.ui true
}

PrepareEnvironment $CURRENT_PATH
BaseInstall $CURRENT_PATH
Configuration $username

echo "--------------------------------------------------"
git --version
echo "--------------------------------------------------"
echo "TODO : reboot"
echo "$0 success"
echo "--------------------------------------------------"