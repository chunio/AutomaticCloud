#!/bin/bash

:<<MARK
1，TARS_PATH -> git clone https://github.com/TarsCloud/Tars.git --recursive
2，Bind();重置密碼邏輯塊未能通過
3，啟動服務：cd /usr/local/app/tars && ./tars_install.sh
cd /usr/local/app/tars && ./tarsnode_install.sh
4，開啟後臺；cd /usr/local/src/TarsCloud/web && npm run prd
MARK

SCRIPT_PATH=$(pwd)
# master controller/主控IP
MC_IP='10.0.0.100'
# database/數據庫IP
DB_IP='10.0.0.100'
DB_OLD_PASSWORD='0000'
DB_NEW_PASSWORD='root@appinside'
BACKEND_USERNAME='tars'
BACKEND_PASSWORD='tars2015'
TARS_CLOUD_PATH='/usr/local/src/TarsCloud'
MYSQL_LIB_PATH='/usr/local/mysql5725/lib'
MYSQL_INCLUDE_PATH='/usr/local/mysql5725/include'

echo "--------------------------------------------------"
# echo "準備事項 :"
# echo "1，需設置DB密碼 : root@appinside"
# echo "2，調整BindDB()中的本機IP地址"
echo "continue ? ( y/n )"
read continueStatus leftover
if [ $continueStatus == "y" ];then

#準備環境
function CommonInit {
	TARS_CLOUD_PATH=$1
	ls $TARS_CLOUD_PATH 2> /dev/null
	if [ $? -eq 0 ];then
		rm -rf $TARS_CLOUD_PATH
	fi
	rm -rf $TARS_CLOUD_PATH 2> /dev/null
	cp -r /windows/shell/TarsCloud/Tars.backup $TARS_CLOUD_PATH
	# 項目依賴，start-----
	# 1，linux内核版本:								2.6.18及以上版本
	# 2，gcc版本:									4.8.2及以上版本、glibc-devel（c++語言框架依賴）
	# 3，bison工具版本:								2.5及以上版本（語法分析器/生成器）
	# 4，flex工具版本:								2.5及以上版本（生成詞法分析器，利用正則表達式來生成匹配相應字符串的C語言代碼）
	# 5，cmake版本：								2.8.8及以上版本（tars框架服務依賴的編譯環境）
	# 6，mysql版本:									4.1.17及以上版本
	# 7，rapidjson版本:								1.0.2版本（C++JSON解釋/生成器）
	# 8，nvm版本：									0.33.11及以上版本（node多版本管理器）
	# 9，node版本：									8.11.3及以上版本
	# 10，pm2
	# 11，protoc編譯器								3.0+
	# current version,start-----
	# cat /proc/version								3.10.0
	# gcc -v 										4.8.5
	# bison -V 										3.0.4
	# yum list installed | grep flex				2.5.37
	# cmake -version								2.8.12.2
	# inside>>status;								8.0.15
	# -----
	# yum list installed | grep rapidjson			1.1.0
	# yum provides */rapidjson
	# -----
	# nvm											0.34.0
	# node											12.3.1
	# pm2
	# protoc 										3.7.1
	yum -y install gcc gcc-c++ flex bison make cmake perl zlibc gzip protobuf-c-compiler protobuf-compiler rapidjson-devel glibc-devel ncurses-devel zlib-devel
	nvm --version 2> /dev/null
	if [ $? -ne 0 ];then
		wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
		source ~/.bashrc
		nvm install v12.3.1
		nvm use v12.3.1
	fi
	protoc --version 2> /dev/null
	if [ $? -ne 0 ];then
		RESOURCE_PATH='/windows/shell/LnmpVersion2.0/common/multi'
		cd $RESOURCE_PATH && tar -xvf protobuf-all-3.7.1.tar.gz -C /usr/local/src/ && cd /usr/local/src/protobuf-3.7.1
		./autogen.sh
		./configure
		make -j8 && make install
	fi
	systemctl enable rsyncd
	systemctl restart rsyncd
}

function BindDB() {

	TARS_CLOUD_PATH=$1
	DB_OLD_PASSWORD=$2
	DB_NEW_PASSWORD=$3
	BACKEND_USERNAME=$4
	BACKEND_PASSWORD=$5
	DB_IP=$6
	MC_IP=$7

expect << EOF
spawn mysql -uroot -p
expect "Enter password*" { send "${DB_OLD_PASSWORD}\r" }
expect "mysql*" { send "USE mysql;\r" }
expect "mysql*" { send "UPDATE user SET authentication_string=password('${DB_NEW_PASSWORD}'), password_expired='N' WHERE user='root';\r" }
expect "mysql*" { send "GRANT ALL PRIVILEGES ON *.* TO '${BACKEND_USERNAME}'@'%' IDENTIFIED BY '${BACKEND_PASSWORD}';\r" }
expect "mysql*" { send "GRANT ALL PRIVILEGES ON *.* TO '${BACKEND_USERNAME}'@'${DB_IP}' IDENTIFIED BY '${BACKEND_PASSWORD}';\r" }
expect "mysql*" { send "GRANT ALL PRIVILEGES ON *.* TO '${BACKEND_USERNAME}'@'localhost' IDENTIFIED BY '${BACKEND_PASSWORD}';\r" }
expect "mysql*" { send "FLUSH PRIVILEGES;\r" }
expect "mysql*" { send "EXIT;\r" }
expect eof
EOF

	sed -i 's/# bind-address/bind-address/g' /usr/local/mysql5725/mysql.conf

	sed -i "s@/usr/local/mysql/lib@/usr/local/mysql5725/lib@g" $TARS_CLOUD_PATH/framework/CMakeLists.txt
	sed -i "s@/usr/local/mysql/include@/usr/local/mysql5725/include@g" $TARS_CLOUD_PATH/framework/CMakeLists.txt
	sed -i "s@/usr/local/mysql/lib@/usr/local/mysql5725/lib@g" $TARS_CLOUD_PATH/framework/tarscpp/CMakeLists.txt
	sed -i "s@/usr/local/mysql/include@/usr/local/mysql5725/include@g" $TARS_CLOUD_PATH/framework/tarscpp/CMakeLists.txt

	echo "include /usr/local/mysql5725/lib/" >> /etc/ld.so.conf && ldconfig

	cd $TARS_CLOUD_PATH/framework/sql
	sed -i "s/192.168.2.131/${MC_IP}/g" `grep 192.168.2.131 -rl ./*`			#主控IP
	sed -i "s/db.tars.com/${DB_IP}/g" `grep db.tars.com -rl ./*`				#數據庫IP
	sed -i "s/10.120.129.226/${DB_IP}/g" `grep 10.120.129.226 -rl ./*`			#數據庫IP
	sed -i "s/uroot/u${BACKEND_USERNAME}/g" exec-sql.sh
	sed -i "s/p${DB_NEW_PASSWORD}/p${BACKEND_PASSWORD}/g" exec-sql.sh
	sed -i "s/mysql/mysql -h ${DB_IP}/g" exec-sql.sh  							#數據庫IP
	./exec-sql.sh

	systemctl restart mysqld.service
	
:<<MARK
//自行執行,start----

//1更新密碼，2添加用戶
mysql -uroot -p
0000
USE mysql;
UPDATE user SET authentication_string=password('root@appinside'), password_expired='N' WHERE user='root';
GRANT ALL PRIVILEGES ON *.* TO tars@'%' IDENTIFIED BY 'tars2015';
GRANT ALL PRIVILEGES ON *.* TO tars@'10.0.0.100' IDENTIFIED BY 'tars2015';
GRANT ALL PRIVILEGES ON *.* TO tars@'localhost' IDENTIFIED BY 'tars2015';
FLUSH PRIVILEGES;
EXIT;

//3編輯mysql.conf，開啟bind address

//4調整lib/include路徑
sed -i "s@/usr/local/mysql/lib@/usr/local/mysql5725/lib@g" /usr/local/src/TarsCloud/framework/CMakeLists.txt
sed -i "s@/usr/local/mysql/include@/usr/local/mysql5725/include@g" /usr/local/src/TarsCloud/framework/CMakeLists.txt
sed -i "s@/usr/local/mysql/lib@/usr/local/mysql5725/lib@g" /usr/local/src/TarsCloud/framework/tarscpp/CMakeLists.txt
sed -i "s@/usr/local/mysql/include@/usr/local/mysql5725/include@g" /usr/local/src/TarsCloud/framework/tarscpp/CMakeLists.txt


//5添加mysql/lib路徑
echo "include /usr/local/mysql5725/lib/" >> /etc/ld.so.conf && ldconfig

//6調整寫入參數
cd /usr/local/src/TarsCloud/framework/sql
sed -i "s/192.168.2.131/10.0.0.100/g" `grep 192.168.2.131 -rl ./*`		主控IP
sed -i "s/db.tars.com/10.0.0.100/g" `grep db.tars.com -rl ./*`			數據庫IP
sed -i "s/10.120.129.226/10.0.0.100/g" `grep 10.120.129.226 -rl ./*`	數據庫IP
sed -i "s/uroot/utars/g" exec-sql.sh
sed -i "s/proot@appinside/ptars2015/g" exec-sql.sh
sed -i "s/mysql/mysql -h 10.0.0.100/g" exec-sql.sh  					數據庫IP
./exec-sql.sh

systemctl restart mysqld.service

//自行執行,end----
MARK

}

function FrameworkInstall() {
	TARS_CLOUD_PATH=$1
	DB_IP=$2
	MC_IP=$3
	mkdir -p /data/log/tars /home/tarsproto/protocol /usr/local/{tars,app/tars}
	chown -R zengweitao. /data/log/tars /home/tarsproto/protocol /usr/local/{tars,app/tars}
	cd $TARS_CLOUD_PATH/framework/build
	./build.sh all
	./build.sh install
	make framework-tar
	# -----
	make tarslog-tar
	make tarsstat-tar
	make tarsnotify-tar
	make tarsproperty-tar
	make tarsquerystat-tar
	make tarsqueryproperty-tar
	mv *.tgz /windows/shell/TarsCloud/TGZ/
	# -----
	mv framework.tgz /usr/local/app/tars
	cd /usr/local/app/tars
	tar -xvf framework.tgz
	sed -i "s/192.168.2.131/${DB_IP}/g" `grep 192.168.2.131 -rl ./*`			#本機地址
	sed -i "s/db.tars.com/${DB_IP}/g" `grep db.tars.com -rl ./*`				#數據庫地址
	sed -i "s/registry.tars.com/${MC_IP}/g" `grep registry.tars.com -rl ./*`	#主控地址
	sed -i "s/web.tars.com/${MC_IP}/g" `grep web.tars.com -rl ./*`				#主控地址
	# 自行確認
	# grep dbpass -rl ./*
	./tars_install.sh
	./tarspatch/util/init.sh
	./tarsnode_install.sh
	echo '* * * * * /usr/local/app/tars/tarsnode/util/monitor.sh' >> /etc/crontab
	crontab /etc/crontab														#刷新任務清單
}

function WEBInstall() {
	TARS_CLOUD_PATH=$1
	DB_IP=$2
	MC_IP=$3
	cd $TARS_CLOUD_PATH/web
	sed -i "s/db.tars.com/${DB_IP}/g" config/webConf.js 						#數據庫IP
	sed -i "s/registry.tars.com/${MC_IP}/g" config/tars.conf 					#主控IP
	npm install -g pm2 --registry=https://registry.npm.taobao.org
	npm install --registry=https://registry.npm.taobao.org
	npm run prd
}

CommonInit $TARS_CLOUD_PATH
BindDB $TARS_CLOUD_PATH $DB_OLD_PASSWORD $DB_NEW_PASSWORD $BACKEND_USERNAME $BACKEND_PASSWORD $DB_IP $MC_IP
FrameworkInstall $TARS_CLOUD_PATH $DB_IP $MC_IP
WEBInstall $TARS_CLOUD_PATH $DB_IP $MC_IP

fi