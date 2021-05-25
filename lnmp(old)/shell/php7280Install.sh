#!/bin/bash

:<<MARK
--with-mysql=shared,mysqlnd/雖然提示錯誤（configure: WARNING: unrecognized options），但是讓然需要設置，否則編譯失敗
--enable-fastcgi/5.3+可省略此參數
需先於nginx安裝，因與其依賴（openssl-1.1.1-pre8）存在衝突
MARK

rm -f /var/run/yum.pid
RESOURCE_PATH=$(cd resource && pwd)
SRC_NAME='php-7.2.8'
BIN_NAME='php7280'

function PrepareEnvironment() {

	RESOURCE_PATH=$1
	SRC_NAME=$2
	BIN_NAME=$3

	yum -y install libxml2 libxml2-devel openssl openssl-devel curl-devel libjpeg-devel libpng-devel freetype-devel libmcrypt libmcrypt-devel bzip2 bzip2-devel re2c libiconv mhash

	#-----
	ls $RESOURCE_PATH/${SRC_NAME}.tar.gz &> /dev/null
	if [ $? -ne 0 ];then
	    downloadStatus=true
	    whileNum=1
	    while $downloadStatus
	    do
	        wget http://cn2.php.net/get/${SRC_NAME}.tar.gz/from/this/mirror -O $RESOURCE_PATH/${SRC_NAME}.tar.gz
	        if [ $? -eq 0 ];then
	            downloadStatus=false
	        else
	        	rm -rf $RESOURCE_PATH/${SRC_NAME}.tar.gz
	        	echo "##################################################"
	        	echo "網絡出錯 , 進行重獲資源($whileNum)"
	        	let whileNum++
	        fi
	    done
	fi
	#-----
	
	# --with-openssl,start----
	# 檢測是否重複安裝（nginx1155Install.sh）
	# ls /usr/local/src/openssl-1.1.1-pre8
 #    if [ $? -ne 0 ];then
 #    cd $RESOURCE_PATH && tar -xvf openssl-1.1.1-pre8.tar.gz -C /usr/local/src/ && cd /usr/local/src/openssl-1.1.1-pre8
 #    ./config && make -j8 && make install
 #    fi
 #    ls /usr/lib/libssl.so
 #    if [ $? -ne 0 ];then
 #    	ln -s /usr/local/src/openssl-1.1.1-pre8/libssl.so /usr/lib
	# fi
	# --with-openssl,end----
	# ln -s /usr/lib64/libssl.so /usr/lib/libssl.so 

	#新建一個所屬組是www的php用戶，且不創建家目錄
	#groupadd -r www && useradd -r -g www -s /bin/false -d /usr/local/php7 -M php
	id www 2> /dev/null
	if [ $? ];then
		useradd -s /bin/false -M www
	fi

}

function BaseInstall() {

	RESOURCE_PATH=$1
	SRC_NAME=$2
	BIN_NAME=$3

	#參看編譯安裝時候的參數：${BIN_NAME} -i | grep configure 
	cd $RESOURCE_PATH && tar -xvf ${SRC_NAME}.tar.gz -C /usr/local/src && cd /usr/local/src/${SRC_NAME}
	./configure \
	--prefix=/usr/local/${BIN_NAME} \
	--exec-prefix=/usr/local/${BIN_NAME} \
	--bindir=/usr/local/${BIN_NAME}/bin \
	--sbindir=/usr/local/${BIN_NAME}/sbin \
	--includedir=/usr/local/${BIN_NAME}/include \
	--libdir=/usr/local/${BIN_NAME}/lib \
	--mandir=/usr/local/${BIN_NAME}/man \
	--with-fpm-user=www \
	--with-fpm-group=www \
	--with-config-file-path=/usr/local/${BIN_NAME}/etc \
	--with-mysql-sock=/usr/local/mysql/runtime/mysql.sock \
	--with-mcrypt=/usr/include \
	--with-mhash \
	--with-openssl \
	--with-mysql=shared,mysqlnd \
	--with-mysqli=shared,mysqlnd \
	--with-pdo-mysql=shared,mysqlnd \
	--with-gd \
	--with-curl \
	--with-zlib \
	--with-iconv \
	--with-xmlrpc \
	--with-gettext \
	--with-jpeg-dir \
	--with-freetype-dir \
	--without-gdbm \
	--without-pear \
	--enable-ftp \
	--enable-zip \
	--enable-xml \
	--enable-fpm \
	--enable-soap \
	--enable-shmop \
	--enable-pcntl \
	--disable-debug \
	--disable-rpath \
	--enable-shared \
	--enable-bcmath \
	--enable-sysvsem \
	--enable-mbregex \
	--enable-sockets \
	--enable-session \
	--enable-opcache \
	--enable-mbstring \
	--enable-calendar \
	--enable-gd-native-ttf \
	--enable-inline-optimization \
	--disable-fileinfo

	make -j8 && make install

}

function Configuration() {

	RESOURCE_PATH=$1
	SRC_NAME=$2
	BIN_NAME=$3

#基礎配置,start##################################################
mkdir -p /usr/local/${BIN_NAME}/{log,runtime,session}
chown -R www:www /usr/local/${BIN_NAME}
#-----
touch /usr/local/${BIN_NAME}/runtime/php-fpm.sock
chmod 777 /usr/local/${BIN_NAME}/runtime/php-fpm.sock
chown www:www /usr/local/${BIN_NAME}/runtime/php-fpm.sock
#-----
touch /usr/local/${BIN_NAME}/log/xdebug.log
chmod 777 /usr/local/${BIN_NAME}/log/xdebug.log

#cp /usr/local/php7/etc/php-fpm.conf.default /usr/local/php7/etc/php-fpm.conf
#cp /usr/local/php7/etc/php-fpm.d/www.conf.default /usr/local/php7/etc/php-fpm.d/www.conf
#cp /data/download/${SRC_NAME}/php.ini-production /usr/local/php7/etc/php.ini

#php.ini-----
echo '[PHP]
;避免信息暴露於http頭中
expose_php = Off

engine = On
short_open_tag = On
precision = 14
output_buffering = 4096
zlib.output_compression = Off
implicit_flush = Off
unserialize_callback_func =
serialize_precision = -1
disable_functions =
disable_classes =
zend.enable_gc = On
max_execution_time = 300
max_input_time = 60
memory_limit = 512M
error_reporting = E_ALL & ~E_NOTICE
display_errors = Off
display_startup_errors = Off
log_errors = On
log_errors_max_len = 1024
ignore_repeated_errors = On
ignore_repeated_source = On
report_memleaks = On
html_errors = Off
variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On
post_max_size = 32M
auto_prepend_file =
auto_append_file =
default_mimetype = "text/html"
default_charset = "UTF-8"
doc_root =
user_dir =
enable_dl = Off
file_uploads = On
upload_max_filesize = 8M
max_file_uploads = 20
allow_url_fopen = On
allow_url_include = Off
default_socket_timeout = 60

;常用配置
error_log = /usr/local/'${BIN_NAME}'/log/error.log
upload_tmp_dir = /data/download

;設置擴展
extension_dir = "/usr/local/'${BIN_NAME}'/lib/extensions/no-debug-non-zts-20160303"
extension = geoip.so
extension = redis.so
extension = swoole.so
extension = mcrypt.so
extension = mysqli.so
extension = mongodb.so
extension = phptars.so
extension = pdo_mysql.so
zend_extension = xdebug.so
zend_extension = opcache.so

;設置時區
date.timezone = Asia/Shanghai

;設置腳本允許訪問的目錄（根据實際情況）
open_basedir = /tmp:/windows:/usr/local/src

[CLI Server]
cli_server.color = On
[Date]
[filter]
[iconv]
[intl]
[sqlite3]
[Pcre]
[Pdo]
[Pdo_mysql]
pdo_mysql.cache_size = 2000
pdo_mysql.default_socket = /usr/local/mysql/runtime/mysql.sock
[Phar]
[mail function]
SMTP = localhost
smtp_port = 25
mail.add_x_header = Off
[ODBC]
odbc.allow_persistent = On
odbc.check_persistent = On
odbc.max_persistent = -1
odbc.max_links = -1
odbc.defaultlrl = 4096
odbc.defaultbinmode = 1
[Interbase]
ibase.allow_persistent = 1
ibase.max_persistent = -1
ibase.max_links = -1
ibase.timestampformat = "%Y-%m-%d %H:%M:%S"
ibase.dateformat = "%Y-%m-%d"
ibase.timeformat = "%H:%M:%S"
[MySQLi]
mysqli.max_persistent = -1
mysqli.allow_persistent = On
mysqli.max_links = -1
mysqli.cache_size = 2000
mysqli.default_port = 3306
mysqli.default_socket =
mysqli.default_host =
mysqli.default_user =
mysqli.default_pw =
mysqli.reconnect = Off
;mysql.default_socket = /usr/local/mysql/runtime/mysql.sock
mysqli.default_socket = /usr/local/mysql/runtime/mysql.sock
[mysqlnd]
mysqlnd.collect_statistics = On
mysqlnd.collect_memory_statistics = Off
[OCI8]
[PostgreSQL]
pgsql.allow_persistent = On
pgsql.auto_reset_persistent = Off
pgsql.max_persistent = -1
pgsql.max_links = -1
pgsql.ignore_notice = 0
pgsql.log_notice = 0
[bcmath]
bcmath.scale = 0
[browscap]
[Session]
;##################################################
;session.save_handler = redis
;session.save_path = "tcp://127.0.0.1:6379?auth=0000"
;##################################################
session.save_handler = files
session.use_strict_mode = 0
session.use_cookies = 1
session.use_only_cookies = 1
session.name = PHPSESSID
session.auto_start = 1
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_domain =
session.cookie_httponly =
session.serialize_handler = php
session.gc_probability = 1
session.gc_divisor = 1000
session.gc_maxlifetime = 14400
session.referer_check =
session.cache_limiter = nocache
session.cache_expire = 180
session.use_trans_sid = 0
session.sid_length = 26
session.trans_sid_tags = "a=href,area=href,frame=src,form="
session.sid_bits_per_character = 5
[Assertion]
zend.assertions = -1
[COM]
[mbstring]
[gd]
[exif]
[Tidy]
tidy.clean_output = Off
[soap]
soap.wsdl_cache_enabled = 1
soap.wsdl_cache_dir = "/tmp"
soap.wsdl_cache_ttl = 86400
soap.wsdl_cache_limit = 5
[sysvshm]
[ldap]
ldap.max_links = -1
[dba]

[xdebug]
;基本調試
xdebug.auto_trace = on
xdebug.collect_params = on
xdebug.collect_return = on
xdebug.profiler_enable = on
xdebug.trace_output_dir = "/usr/local/'${BIN_NAME}'/log"
xdebug.profiler_output_dir ="/usr/local/'${BIN_NAME}'/log"
xdebug.profiler_output_name = "profiler.output.%t-%s"
;遠程調試
xdebug.remote_enable = on
;RemoteHost爲IDE所在主機IPAddress
xdebug.remote_host = 0.0.0.0
xdebug.remote_port = 9500
xdebug.remote_autostart = on
xdebug.remote_handler = "dbgp"
xdebug.remote_log = /usr/local/'${BIN_NAME}'/log/xdebug.log
xdebug.idekey= PHPSTORM

[opcache]
;開啟opcache則代碼延時更新（存在緩存）
opcache.enable = 0
opcache.enable_cli = 0
opcache.huge_code_pages = 0
opcache.file_cache = /tmp
;##################################################
;推薦設置（未驗證）
opcache.memory_consumption = 128
opcache.interned_strings_buffer = 8
opcache.max_accelerated_files = 4000
;OpcacheRevalidateFreq默認2，檢查腳本時間戳是否有更新的周期，0時會導致針對每個請求opcache都會檢查腳本更新，单位/秒
opcache.revalidate_freq = 60
opcache.fast_shutdown = 1
;##################################################

[curl]
[openssl]' > /usr/local/${BIN_NAME}/etc/php.ini
#基礎配置，end##################################################

#php-fpm.conf-----
echo 'pid = /usr/local/'${BIN_NAME}'/runtime/php-fpm.pid
error_log = /usr/local/'${BIN_NAME}'/log/php-fpm-error.log
;如開啟加載，且無對應子配置文件時產生警告
;include=/usr/local/${BIN_NAME}/etc/php-fpm.d/*.conf

[www]
user = www
group = www

;監聽方式1，不建議使用
;listen = 127.0.0.1:9000

;監聽方式2，需同步設置nginx.conf中fastcgi_pass unix:/dev/shm/php-fpm.sock,start-----
listen = /usr/local/'${BIN_NAME}'/runtime/php-fpm.sock
listen.owner = www
listen.group = www
listen.mode = 0777
listen.allowed_clients = /usr/local/'${BIN_NAME}'/runtime/php-fpm.sock
;end-----

;動態進程模式-----
pm = dynamic
pm.start_servers = 10
pm.min_spare_servers = 5
pm.max_spare_servers = 50
;靜態進程模式（pm.max_children={內存/512},且需大於pm.max_spare_servers）-----
;pm = static
pm.max_children = 50

pm.max_requests = 0
pm.status_path = /fpmStatus

;開啟慢日誌
request_slowlog_timeout = 15s
request_terminate_timeout = 0
slowlog = /usr/local/'${BIN_NAME}'/log/php-fpm-slow.log' > /usr/local/${BIN_NAME}/etc/php-fpm.conf

	cp /usr/local/src/${SRC_NAME}/sapi/fpm/php-fpm.service /lib/systemd/system/php-fpm-${BIN_NAME}.service
	chmod 745 /lib/systemd/system/php-fpm-${BIN_NAME}.service
	systemctl enable php-fpm-${BIN_NAME}.service
	systemctl restart php-fpm-${BIN_NAME}.service

	ln -s /usr/local/${BIN_NAME}/bin/php /usr/local/bin/${BIN_NAME}

}

function ExtensionInstall() {

	RESOURCE_PATH=$1
	SRC_NAME=$2
	BIN_NAME=$3

	#安裝擴展，start##################################################
	mkdir -p /usr/local/src/PHPExtension/${BIN_NAME}

	# mcrypt（備註：解決7.2+移除mcrypt(加密支持)導致的兼容性問題）,start-----
	# ls $RESOURCE_PATH/mcrypt-1.0.1.tgz &> /dev/null
	# if [ $? -ne 0 ];then
	#     wget http://pecl.php.net/get/mcrypt-1.0.1.tgz
	# fi
	cd $RESOURCE_PATH && tar -xvf mcrypt-1.0.1.tgz -C /usr/local/src/PHPExtension/${BIN_NAME} && cd /usr/local/src/PHPExtension/${BIN_NAME}/mcrypt-1.0.1
	/usr/local/${BIN_NAME}/bin/phpize 
	./configure --with-php-config=/usr/local/${BIN_NAME}/bin/php-config
	make -j8 && make install

	# redis,start-----
	# ls $RESOURCE_PATH/phpredis-4.1.1.tar.gz &> /dev/null
	# if [ $? -ne 0 ];then
	#     wget https://github.com/phpredis/phpredis/archive/4.1.1.tar.gz -O /data/download/phpredis-4.1.1.tar.gz
	# fi
	cd $RESOURCE_PATH && tar -xvf phpredis-4.3.0.tar.gz -C /usr/local/src/PHPExtension/${BIN_NAME} && cd /usr/local/src/PHPExtension/${BIN_NAME}/phpredis-4.3.0
	/usr/local/${BIN_NAME}/bin/phpize
	./configure --with-php-config=/usr/local/${BIN_NAME}/bin/php-config
	make -j8 && make install

	# mongodb,start-----
	# wget https://pecl.php.net/get/mongodb-1.5.3.tgz
	cd $RESOURCE_PATH && tar -xvf mongodb-1.5.3.tgz -C /usr/local/src/PHPExtension/${BIN_NAME} && cd /usr/local/src/PHPExtension/${BIN_NAME}/mongodb-1.5.3
	/usr/local/${BIN_NAME}/bin/phpize
	./configure --with-php-config=/usr/local/${BIN_NAME}/bin/php-config
	make -j8 && make install

	# xdebug,start-----
	cd $RESOURCE_PATH && tar -xvf xdebug-2.6.1.tgz -C /usr/local/src/PHPExtension/${BIN_NAME} && cd /usr/local/src/PHPExtension/${BIN_NAME}/xdebug-2.6.1
	/usr/local/${BIN_NAME}/bin/phpize
	./configure --enable-xdebug --with-php-config=/usr/local/${BIN_NAME}/bin/php-config
	make -j8 && make install

	# swoole,start-----
	# wget http://pecl.php.net/get/swoole-4.3.2.tgz
	cd $RESOURCE_PATH && tar -xvf swoole-4.3.2.tgz -C /usr/local/src/PHPExtension/${BIN_NAME} && cd /usr/local/src/PHPExtension/${BIN_NAME}/swoole-4.3.2
	/usr/local/${BIN_NAME}/bin/phpize
	./configure \
	--with-php-config=/usr/local/${BIN_NAME}/bin/php-config \
	--with-libpq-dir \
	--enable-http2  \
	--enable-openssl  \
	--enable-mysqlnd  \
	--enable-sockets \
	--enable-debug-log \
	--enable-trace-log
	make clean && make -j8 && make install

	# geoip,start-----
	# ip database file : /usr/share/GeoIP
	yum -y install geoip geoip-devel
	cd $RESOURCE_PATH && tar -xvf geoip-1.1.1.tgz -C /usr/local/src/PHPExtension/${BIN_NAME} && cd /usr/local/src/PHPExtension/${BIN_NAME}/geoip-1.1.1
	/usr/local/${BIN_NAME}/bin/phpize
	./configure --with-php-config=/usr/local/${BIN_NAME}/bin/php-config
	make -j8 && make install
	
	# tars,start-----
	# git clone https://github.com/TarsPHP/tars-extension.git
	# 20190530版本
	cd $RESOURCE_PATH && tar -xvf tars-extension.tar -C /usr/local/src/PHPExtension/${BIN_NAME} && cd /usr/local/src/PHPExtension/${BIN_NAME}/tars-extension
	/usr/local/${BIN_NAME}/bin/phpize
	./configure --with-php-config=/usr/local/${BIN_NAME}/bin/php-config
	make -j8 && make install

	#inotify,start-----
	cd $RESOURCE_PATH && tar -xvf inotify-2.0.0.tgz -C /usr/local/src/PHPExtension/${BIN_NAME} && cd /usr/local/src/PHPExtension/${BIN_NAME}/inotify-2.0.0
	/usr/local/${BIN_NAME}/bin/phpize
	./configure \
	--with-php-config=/usr/local/${BIN_NAME}/bin/php-config \
	--enable-inotify
	make -j8 && make install

	#安裝擴展，end##################################################

}

PrepareEnvironment $RESOURCE_PATH $SRC_NAME $BIN_NAME
BaseInstall $RESOURCE_PATH $SRC_NAME $BIN_NAME
Configuration $RESOURCE_PATH $SRC_NAME $BIN_NAME
ExtensionInstall $RESOURCE_PATH $SRC_NAME $BIN_NAME

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"