#!/bin/bash

SCRIPT_PATH=$(pwd)

function ComposerInstall {
:<<MARK
局部安裝
//於composer.json同級目錄
wget https://dl.laravel-china.org/composer.phar
su - zengweitao
php7280 composer.phar install
//-----
刷新自動加載配置
php7280 composer.phar dump-autoload
MARK
	ls /usr/local/bin/composer 2> /dev/null
	if [ $? -ne 0 ];then
		wget https://dl.laravel-china.org/composer.phar -O /usr/local/bin/composer
		chmod 777 /usr/local/bin/composer
	fi
}

#protoc編輯器
function ProtocInstall() {
	SCRIPT_PATH=$1
	cd $SCRIPT_PATH && tar -xvf protobuf-all-3.7.1.tar.gz -C /usr/local/src/ && cd /usr/local/src/protobuf-3.7.1
	./autogen.sh
	./configure
	make -j8 && make install
	echo "--------------------------------------------------"
	protoc --version
	echo "--------------------------------------------------"
}

ComposerInstall
ProtocInstall $SCRIPT_PATH

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"
cd $SCRIPT_PATH