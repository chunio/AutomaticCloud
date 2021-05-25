#!/bin/bash

RESOURCE_PATH=$(cd resource && pwd)

function ComposerInstall {
	# composer,start-----
	ls /usr/local/bin/composer 2> /dev/null
	if [ $? -ne 0 ];then
		wget https://dl.laravel-china.org/composer.phar -O /usr/local/bin/composer
		chmod 777 /usr/local/bin/composer
	fi
}

function NVMInstall {
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
	source ~/.bashrc
}

function NodejsInstall {
	nvm --version 2> /dev/null
	if [ $? -ne 0 ];then
		wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
		source ~/.bashrc
	fi
	nvm install v12.3.1
	nvm alias default v12.3.1
	nvm use v12.3.1
}

function GITInstall() {
	yum -y install git
	# 初始化
	git config --global user.name "chunio"
	git config --global user.email "1545883@qq.com"
}

function RedisInstall {
	. shell/redisInstall.sh
}

#protoc編輯器
function ProtocInstall() {
	RESOURCE_PATH=$1
	cd $RESOURCE_PATH && tar -xvf protobuf-all-3.7.1.tar.gz -C /usr/local/src/ && cd /usr/local/src/protobuf-3.7.1
	./autogen.sh
	./configure
	make -j8 && make install
	echo "--------------------------------------------------"
	echo "TODO : reboot"
	echo "--------------------------------------------------"
}

# ComposerInstall
# NVMInstall
# NodejsInstall
# GITInstall $RESOURCE_PATH
RedisInstall

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"