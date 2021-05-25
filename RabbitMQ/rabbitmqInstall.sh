#!/bin/bash

:<<MARK
MARK

SCRIPT_PATH=$(pwd)

#準備環境
function CommonInit {
	yum -y install erlang
	# -----
	# http://erlang.org/download
	# yum -y install build-essential openssl openssl-devel unixODBC unixODBC-devel make gcc gcc-c++ kernel-devel m4 ncurses-devel libxslt fop
	# tar -xvf otp_src_22.0.tar.gz -C /usr/local/src
	# cd /usr/local/src/otp_src_22.0
	# ./configure \
	# --prefix=/usr/local/erlang \
	# --with-ssl= \
	# --enable-threads \
	# --enable-smmp-support \
	# --enable-kernel-poll \
	# --enable-hipe \
	# --without-javac
	# make -j8 && make install
	# echo 'export PATH=/usr/local/erlang/bin:$PATH' >> /etc/profile
	# source /etc/profile
	# ln -s /usr/local/erlang/bin/erl /usr/bin/erl
}

function BaseInstall() {
	SCRIPT_PATH=$1
	# https://www.rabbitmq.com/releases/rabbitmq-server/current/
	cd $SCRIPT_PATH
	xz -d rabbitmq-server-generic-unix-3.6.15.tar.xz
	tar -xvf rabbitmq-server-generic-unix-3.6.15.tar -C /usr/local/src
	# -----
	ln -s /usr/local/src/rabbitmq_server-3.6.15 /usr/local/rabbitmq
	ln -s /usr/local/src/rabbitmq_server-3.6.15/sbin/* /usr/local/bin/
	# -----
	rabbitmq-server -detached
	# rabbitmq-server start
}

function Configuration() {
	# 安裝管理界面
	rabbitmq-plugins enable rabbitmq_management
	# 安裝監控工具
	rabbitmq-plugins enable rabbitmq_tracing
	# 添加用戶
	rabbitmqctl add_user admin 0000
	# 設置權限
	rabbitmqctl set_user_tags admin administrator
	# rabbitmqctl stop
echo 'server {
	listen       80;
	server_name  localhost.rabbitmq.com;
	location /{
	        access_log off;
	        proxy_pass http://localhost:15672;
	        client_max_body_size 30m;
	        proxy_set_header Host $host;
	        proxy_set_header X-Real-IP $remote_addr;
	        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	}
}' > /usr/local/nginx1170/conf/virtualhost/rabbitmq.conf
	systemctl restart nginx1170.service
}

CommonInit
BaseInstall $SCRIPT_PATH
# Configuration

echo "--------------------------------------------------"
echo "$0 success"
echo "--------------------------------------------------"
cd $SCRIPT_PATH