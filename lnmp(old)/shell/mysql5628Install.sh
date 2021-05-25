#!/bin/bash

PWD_PATH=$(pwd)
RESOURCE_PATH=$(cd resource && pwd)

function ResetVersion {
	yum list installed | grep Maria
	if [ $? -eq 0 ];then
		systemctl stop mariadb.service
		yum remove -y Maria*
		rm -rf /etc/my.cnf.rpmsave 2> /dev/null
		rm -rf /etc/yum.repos.d/mariadb.repo 2> /dev/null
	fi
	id mysql
	if [ $? -eq 0 ];then
		userdel -r mysql 2> /dev/null
		groupdel mysql 2> /dev/null
	fi
	useradd -s /bin/false -M mysql
}

function CommonInit {
	yum -y install gcc gcc-c++ perl cmake glibc-devel ncurses-devel zlib-devel libaio-devel openssl openssl-devel autoconf
}

function DevtoolsetInit {
	yum -y install centos-release-scl-rh centos-release-scl
	yum -y install devtoolset-7-gcc devtoolset-7-gcc-c++
	source /opt/rh/devtoolset-7/enable
}

function SourceCodeCompilation() {
	cd $1 && tar -xvf mysql-5.6.28.tar.gz -C /usr/local/src/ && cd /usr/local/src/mysql-5.6.28
	#mkdir /usr/local/src/mysql-5.6.28/debug && cd /usr/local/src/mysql-5.6.28/debug
	chown -R mysql:mysql /usr/local/src/mysql-5.6.28
	#-----
	#當前版本不支持選項：WITH_MEMORY_STORAGE_ENGINE
	cmake \
	-DCMAKE_INSTALL_PREFIX=/usr/local/mysql5628 \
	-DSYSCONFDIR=/usr/local/mysql5628 \
	-DMYSQL_DATADIR=/usr/local/mysql5628/data \
	-DWITH_MYISAM_STORAGE_ENGINE=1 \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
	-DWITH_PARTITION_STORAGE_ENGINE=1 \
	-DMYSQL_UNIX_ADDR=/usr/local/mysql5628/3306/mysql.sock \
	-DMYSQL_TCP_PORT=3306 \
	-DENABLED_LOCAL_INFILE=1 \
	-DEXTRA_CHARSETS=all  \
	-DDEFAULT_CHARSET=utf8  \
	-DDEFAULT_COLLATION=utf8_general_ci
	#-----
	make -j8 && make install
}

function DBConfiguration {
echo '[client]

port = 3306
socket = /usr/local/mysql5628/3306/mysql.sock

#--------------------------------------------------

[mysqld]

port = 3306
user = mysql
socket = /usr/local/mysql5628/3306/mysql.sock
pid-file = /usr/local/mysql5628/3306/mysql.pid
basedir = /usr/local/mysql5628
datadir = /usr/local/mysql5628/data
tmpdir = /usr/local/mysql5628/temp
server-id = 1
character-set-server = utf8mb4
default-storage-engine = InnoDB
init_connect = "SET NAMES utf8"

#--------------------

log_output = FILE
long_query_time = 1
log-error = /usr/local/mysql5628/log/error.log
general_log = 1
general_log_file = /usr/local/mysql5628/log/general.log
slow_query_log = 1
slow_query_log_file = /usr/local/mysql5628/log/slow.log

#binlog,start-----
log_bin = /usr/local/mysql5628/log/LogBin
binlog_format = mixed
max_binlog_size = 512m
binlog_cache_size = 32m
max_binlog_cache_size = 64m
#binlog,end-----

relay-log = /usr/local/mysql5628/log/RelayBin
relay-log-index = /usr/local/mysql5628/log/RelayBinIndex

#innodb,start-----
innodb_data_file_path = ibdata1:2048M:autoextend
# innodb_data_home_dir = /usr/local/mysql5628/data/innodb
# innodb_log_group_home_dir = /usr/local/mysql5628/log/innodb
innodb_log_file_size = 128M
innodb_log_buffer_size = 16M
innodb_log_files_in_group = 3
innodb_thread_concurrency = 8
innodb_flush_method = O_DIRECT
innodb_buffer_pool_size = 128M
innodb_max_dirty_pages_pct = 70
innodb_flush_log_at_trx_commit = 2
#innodb,end-----

# tars example,start-----
# #log_bin
# #basedir = /usr/local/mysql5628
# #datadir = /usr/local/mysql5628/data
# #socket = /usr/local/mysql5628/3306/mysql.sock
# #innodb_buffer_pool_size = 128M
sort_buffer_size = 2M
join_buffer_size = 128M
read_rnd_buffer_size = 2M
bind-address = 192.168.181.131
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
# default-authentication-plugin = mysql_native_password
# tars example,end-----

#--------------------------------------------------

[mysql]

socket = /usr/local/mysql5628/3306/mysql.sock

#命令自動補全
auto-rehash
#no-auto-rehash
#自定義登錄摘要信息
prompt = (\u@\h) [\d]>\_
#default-character-set = gbk

#跳過密碼（首次）
#skip-grant-tables

#!includedir /etc/my.cnf.d' > /usr/local/mysql5628/mysql.conf
}

function ACL {
	mkdir -p /usr/local/mysql5628/{3306,data,temp,log/innodb}
	chown -R mysql:mysql /usr/local/mysql5628
	chmod -R 777 /usr/local/mysql5628
	chmod 644 /usr/local/mysql5628/mysql.conf
}

function RegisterService {
	cd /usr/local/mysql5628

	echo 'PATH=$PATH:/usr/local/mysql5628/bin:/usr/local/mysql5628/lib' >> /etc/profile
	echo 'export PATH MYSQL_HOME=/usr/local/mysql5628' >> /etc/profile
	source /etc/profile

	./scripts/mysql_install_db --user=mysql --datadir=/usr/local/mysql5628/data --no-defaults

	# cp -a /usr/local/mysql5628/support-files/mysql.server /etc/init.d/mysqld
	# chmod +x /etc/rc.d/init.d/mysqld  
	# chkconfig --add mysqld
	# chkconfig --list
	# service mysqld start

	echo '[Unit]
Description=MySQL Server
Documentation=man:mysqld(8)
Documentation=http://dev.mysql.com/doc/refman/en/using-systemd.html
After=network.target
After=syslog.target
[Install]
WantedBy=multi-user.target
[Service]
User=mysql
Group=mysql
ExecStart=/usr/local/mysql5628/bin/mysqld --defaults-file=/usr/local/mysql5628/mysql.conf
LimitNOFILE = 5000' > /etc/systemd/system/mysqld.service
	systemctl start mysqld.service
	
}

function EditPassword() {
expect << EOF
spawn mysql -uroot -p
expect "*Enter password*" { send "\r" }
expect "*mysql*" { send "ALTER user 'root'@'localhost' IDENTIFIED BY '$1';\r" }
expect "*mysql*" { send "USE mysql;\r" }
expect "*mysql*" { send "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$1';\r" }
expect "*mysql*" { send "FLUSH PRIVILEGES;\r" }
expect "*mysql*" { send "EXIT;\r" }
expect eof
EOF
}

# ResetVersion
# CommonInit
# DevtoolsetInit
SourceCodeCompilation $RESOURCE_PATH
# DBConfiguration
# ACL
#RegisterService
#EditPassword cfcd208495d565ef66e7dff9f98764da

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"
exit 0
