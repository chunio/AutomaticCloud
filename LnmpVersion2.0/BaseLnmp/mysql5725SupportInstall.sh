#!/bin/bash

:<<MARK
編譯參數文檔
http://www.mysql.com >> Documentation >> 目標版本（5.7）Installation & Upgrades >> Installing MySQL from Source >> MySQL Source-Configuration Options
例：https://dev.mysql.com/doc/refman/5.7/en/source-configuration-options.html  
#-----
5.7.25版本說明：
1，選項-DBUILD_CONFIG=mysql_release與boost衝突
2，必須-DDOWNLOAD_BOOST=1，否則提示boost缺失（即使設置-DWITH_BOOST）
3，配置文件中，開啟bin log必須設置server id
4，{--defaults-file=/usr/local/mysql5725/mysql.conf}存在的話，必須作爲mysqld第一個參數，或者直接省略
MARK

# echo "--------------------------------------------------"
# echo "set the database new password :"
# read NEW_PASSWORD leftover

PWD_PATH=$(pwd)
RESOURCE_PATH=$(cd BaseLnmp/resource && pwd)
NEW_PASSWORD='0000'

function ResetVersion {
	yum list installed | grep Maria
	if [ $? -eq 0 ];then
		systemctl stop mariadb.service
		yum remove -y Maria*
		rm -rf /etc/my.cnf.rpmsave 2> /dev/null
		rm -rf /etc/yum.repos.d/mariadb.repo 2> /dev/null
		# -----
		rm -rf /usr/lib/systemd/system/mariadb.service 2> /dev/null
		rm -rf /etc/systemd/system/multi-user.target.wants/mariadb.service 2> /dev/null
		# -----
	fi
	id mysql 2> /dev/null
	if [ $? -eq 0 ];then
		userdel -r mysql 2> /dev/null
		groupdel mysql 2> /dev/null
	fi
	useradd -s /bin/false -M mysql
}

function CommonInit {
	yum -y install perl cmake glibc-devel ncurses-devel zlib-devel libaio-devel openssl openssl-devel
	yum -y install gcc gcc-c++ make perl autoconf automake libxml libgcrypt libtool bison
}

function DevtoolsetInit {
	yum -y install centos-release-scl-rh centos-release-scl
	yum -y install devtoolset-7-gcc devtoolset-7-gcc-c++
	source /opt/rh/devtoolset-7/enable
}

function SourceCodeCompilation() {
	cd $1 && tar -xvf mysql-boost-5.7.25.tar.gz -C /usr/local/src/
	mkdir /usr/local/src/mysql-5.7.25/debug && cd /usr/local/src/mysql-5.7.25/debug
	chown -R mysql:mysql /usr/local/src/mysql-5.7.25
	# -----
	cmake .. \
	-DCMAKE_INSTALL_PREFIX=/usr/local/mysql5725 \
	-DSYSCONFDIR=/usr/local/mysql5725 \
	-DMYSQL_DATADIR=/usr/local/mysql5725/data \
	-DWITH_BOOST=/usr/local/src/mysql-5.7.25/boost \
	-DMYSQL_UNIX_ADDR=/usr/local/mysql5725/runtime/mysql.sock \
	-DDEFAULT_CHARSET=utf8 \
	-DDEFAULT_COLLATION=utf8_general_ci \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
	-DDOWNLOAD_BOOST=1
	# -DEXTRA_CHARSETS=all \
	# -DENABLED_LOCAL_INFILE=ON \
	# -DWITH_MYISAM_STORAGE_ENGINE=1 \
	# -DWITH_ARCHIVE_STORAGE_ENGINE=1 \
	# -DWITH_INNOBASE_STORAGE_ENGINE=1 \
	# -DWITH_PARTITION_STORAGE_ENGINE=1 \
	# -DWITH_FEDERATED_STORAGE_ENGINE=1 \
	# -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
	# -DWITH_PERFSCHEMA_STORAGE_ENGINE=1 \
	# -DWITHOUT_EXAMPLE_STORAGE_ENGINE=1 \
	# -DWITH_SSL=system \
	# -DWITH_ZLIB=system \
	# -----
	make -j8 && make install
}

function DBConfiguration {

echo '[client]

port = 3307
socket = /usr/local/mysql5725/runtime/mysql.sock

#--------------------------------------------------

[mysqld]

# validate_password=off

port = 3307
user = mysql
socket = /usr/local/mysql5725/runtime/mysql.sock
pid-file = /usr/local/mysql5725/runtime/mysql.pid
basedir = /usr/local/mysql5725
datadir = /usr/local/mysql5725/data
# tmpdir = /usr/local/mysql5725/temp
server-id = 20
character-set-server = utf8
default-storage-engine = InnoDB
init_connect = "SET NAMES utf8"

#--------------------

# log_output = FILE
general_log = 1
general_log_file = /usr/local/mysql5725/log/general.log
long_query_time = 1
slow_query_log = 1
slow_query_log_file = /usr/local/mysql5725/log/slow.log
log-error = /usr/local/mysql5725/log/error.log

#binlog,start-----
log_bin = /usr/local/mysql5725/log/LogBin
binlog_format = mixed
max_binlog_size = 512m
binlog_cache_size = 32m
max_binlog_cache_size = 64m
#binlog,end-----

# relay-log = /usr/local/mysql5725/log/RelayBin
# relay-log-index = /usr/local/mysql5725/log/RelayBinIndex

#innodb,start-----
# innodb_data_file_path = ibdata1:2048M:autoextend
# # innodb_data_home_dir = /usr/local/mysql5725/data/innodb
# # innodb_log_group_home_dir = /usr/local/mysql5725/log/innodb
# innodb_log_file_size = 128M
# innodb_log_buffer_size = 16M
# innodb_log_files_in_group = 3
# innodb_thread_concurrency = 8
# innodb_flush_method = O_DIRECT
# innodb_buffer_pool_size = 128M
# innodb_max_dirty_pages_pct = 70
# innodb_flush_log_at_trx_commit = 2
#innodb,end-----

# tars example,start-----
# #log_bin
# #basedir = /usr/local/mysql5725
# #datadir = /usr/local/mysql5725/data
# #socket = /usr/local/mysql5725/runtime/mysql.sock
innodb_buffer_pool_size = 128M
sort_buffer_size = 2M
join_buffer_size = 128M
read_rnd_buffer_size = 2M
# bind-address = 10.0.0.100
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
# default-authentication-plugin = mysql_native_password
# tars example,end-----

#--------------------------------------------------

[mysql]

socket = /usr/local/mysql5725/runtime/mysql.sock

#命令自動補全
auto-rehash
#no-auto-rehash
#自定義登錄摘要信息
#prompt = (\u@\h) [\d]>\_
#default-character-set = gbk

#跳過密碼（首次）
#skip-grant-tables

#!includedir /etc/my.cnf.d' > /usr/local/mysql5725/mysql.conf

}

function ACL {
	mkdir -p /usr/local/mysql5725/{runtime,data,temp,log/innodb}
	touch /usr/local/mysql5725/runtime/mysql.sock
	chmod 777 /usr/local/mysql5725/runtime/mysql.sock
	chown mysql:mysql /usr/local/mysql5725/runtime/mysql.sock
	#-----
	chown -R mysql:mysql /usr/local/mysql5725
	chmod -R 777 /usr/local/mysql5725
	chmod 644 /usr/local/mysql5725/mysql.conf
}

function RegisterService {

	# echo 'PATH=$PATH:/usr/local/mysql5725/bin:/usr/local/mysql5725/lib' >> /etc/profile
	# echo 'export PATH MYSQL_HOME=/usr/local/mysql5725' >> /etc/profile
	# source /etc/profile

	# cp /usr/local/mysql5725/support-files/mysql.server /etc/init.d/mysqld
	# #/etc/init.d/mysqld 與 /etc/rc.d/init.d/mysqld 關聯
	# chmod +x /etc/init.d/mysqld
	# chkconfig --add mysqld
	# chkconfig mysqld on
	# chkconfig --list
	
	/usr/local/mysql5725/bin/mysqld --defaults-file=/usr/local/mysql5725/mysql.conf \
	--user=mysql \
	--initialize
	
	echo '[Unit]
Description=MySQL Server
Documentation=man:mysqld(5.7)
Documentation=http://dev.mysql.com/doc/refman/en/using-systemd.html
After=network.target
After=syslog.target
[Install]
WantedBy=multi-user.target
[Service]
User=mysql
Group=mysql
ExecStart=/usr/local/mysql5725/bin/mysqld --defaults-file=/usr/local/mysql5725/mysql.conf
LimitNOFILE = 5000' > /usr/lib/systemd/system/mysqld5725.service
	# 設置開機自啟	
	ln -s /usr/lib/systemd/system/mysqld5725.service /etc/systemd/system/multi-user.target.wants/mysqld5725.service
	systemctl restart mysqld5725.service
	
}

function EditPassword() {
	NEW_PASSWORD=$1	
	# -----
	ln -s /usr/local/mysql5725/bin/mysqladmin /usr/local/bin/mysqladmin5725
	ln -s /usr/local/mysql5725/bin/mysql /usr/local/bin/mysql5725
	# -----
	randomPassword=$(expr substr `cat /usr/local/mysql5725/log/error.log | grep 'A temporary password is generated for root@localhost' | tail -1 |cut -d ":" -f 4` 1 12)
	echo "--------------------------------------------------"
	echo $randomPassword
	echo "--------------------------------------------------"
expect << EOF
spawn mysqladmin5725 -u root -p password $NEW_PASSWORD
expect "Enter password*" { send "${randomPassword}\r" }
expect eof
EOF
expect << EOF
spawn mysql5725 -uroot -p
expect "Enter password*" { send "${NEW_PASSWORD}\r" }
expect "mysql*" { send "ALTER user 'root'@'localhost' IDENTIFIED BY '${NEW_PASSWORD}';\r" }
expect "mysql*" { send "USE mysql;\r" }
expect "mysql*" { send "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${NEW_PASSWORD}';\r" }
expect "mysql*" { send "FLUSH PRIVILEGES;\r" }
expect "mysql*" { send "EXIT;\r" }
expect eof
EOF
}

ResetVersion
CommonInit
DevtoolsetInit
SourceCodeCompilation $RESOURCE_PATH
DBConfiguration
ACL
RegisterService
# EditPassword $NEW_PASSWORD

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"