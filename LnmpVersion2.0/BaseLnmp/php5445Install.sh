#!/bin/bash

:<<MARK
//
MARK

RESOURCE_PATH=$(cd BaseLnmp/resource && pwd)
SRC_NAME='php-5.4.45'
BIN_NAME='php5445'

function PrepareEnvironment() {
	installStatus=true
	whileNum=1
	while $installStatus
	do
	    yum -y --nogpgcheck install libxml2 libxml2-devel openssl openssl-devel curl-devel libjpeg-devel libpng-devel freetype-devel libmcrypt libmcrypt-devel bzip2 bzip2-devel re2c libiconv
	    if [ $? ];then
	        installStatus=false
	    else
	    	echo "網絡出錯 , 進行記憶安裝($whileNum)"
	    	let whileNum++
	    fi
	done
	# 解決報錯(onfigure: WARNING: bison versions supported for regeneration of the Zend/PHP parsers xxxx (found: 3.0)),start-----
	# wget http://ftp.gnu.org/gnu/bison/bison-2.4.1.tar.gz
	# cd $RESOURCE_PATH && tar -xvf bison-2.4.1.tar.gz -C /usr/local/src/ && cd /usr/local/src/bison-2.4.1
	# ./configure
	# make -j8 && make install
	#end-----
	id www 2> /dev/null
	if [ $? ];then
		useradd -s /bin/false -M www
	fi
}

function BaseInstall() {
	RESOURCE_PATH=$1
	SRC_NAME=$2
	BIN_NAME=$3
	cd $RESOURCE_PATH && tar -xvf php-5.4.45.tar.gz -C /usr/local/src && cd /usr/local/src/php-5.4.45
	./configure \
	--prefix=/usr/local/${BIN_NAME} \
	--exec-prefix=/usr/local/${BIN_NAME} \
	--bindir=/usr/local/${BIN_NAME}/bin \
	--sbindir=/usr/local/${BIN_NAME}/sbin \
	--includedir=/usr/local/${BIN_NAME}/include \
	--libdir=/usr/local/${BIN_NAME}/lib \
	--mandir=/usr/local/${BIN_NAME}/man \
	--with-freetype-dir \
	--with-fpm-user=www \
	--with-fpm-group=www \
	--with-config-file-path=/usr/local/${BIN_NAME}/etc \
	--with-mysql-sock=/usr/local/mysql/runtime/mysql.sock \
	--with-mcrypt=/usr/include \
	--with-mysql=shared,mysqlnd \
	--with-mysqli=shared,mysqlnd \
	--with-pdo-mysql=shared,mysqlnd \
	--with-gd \
	--with-bz2 \
	--with-zlib \
	--with-curl \
	--with-iconv \
	--with-mhash \
	--with-xmlrpc \
	--with-openssl \
	--with-gettext \
	--with-jpeg-dir \
	--without-pear \
	--without-gdbm \
	--enable-xml \
	--enable-zip \
	--enable-ftp \
	--enable-fpm \
	--enable-soap \
	--enable-wddx \
	--enable-shmop \
	--enable-pcntl \
	--enable-bcmath \
	--enable-shared \
	--enable-sysvsem \
	--enable-mbregex \
	--enable-session \
	--enable-sockets \
	--enable-mbstring \
	--enable-fileinfo \
	--enable-calendar \
	--enable-gd-native-ttf \
	--enable-inline-optimization \
	--disable-debug \
	--disable-rpath
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

;gzip,start-----
;gzip功能開關
zlib.output_compression = On
;gzip壓縮級別（1--9）
zlib.output_compression_level = 4
;gzip壓縮方式（建議注釋）
;zlib.output_handler =
;gzip,end-----

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
extension_dir = "/usr/local/'${BIN_NAME}'/lib/extensions/no-debug-non-zts-20100525"
extension = mcrypt.so
extension = mysql.so
extension = mysqli.so
extension = pdo_mysql.so

;設置時區
date.timezone = Asia/Shanghai

;設置腳本允許訪問的目錄（根据實際情況）
;open_basedir = /tmp:/windows:/usr/local/src
open_basedir = /

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
session.auto_start = 0
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
;include=/usr/local/'${BIN_NAME}'/etc/php-fpm.d/*.conf

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

	# -----

	echo '[Unit]
Description=The PHP FastCGI Process Manager
After=syslog.target network.target

[Service]
PIDFile=/usr/local/php5445/var/run/php-fpm.pid
ExecStart=/usr/local/php5445/sbin/php-fpm --nodaemonize --fpm-config /usr/local/php5445/etc/php-fpm.conf
ExecReload=/bin/kill -USR2 $MAINPID

[Install]
WantedBy=multi-user.target' > /lib/systemd/system/php-fpm-5445.service
	chmod 745 /lib/systemd/system/php-fpm-5445.service
	systemctl enable php-fpm-5445.service
	systemctl start php-fpm-5445.service

	ln -s /usr/local/${BIN_NAME}/bin/php /usr/local/bin/${BIN_NAME}

}

PrepareEnvironment
BaseInstall $RESOURCE_PATH $SRC_NAME $BIN_NAME
Configuration $RESOURCE_PATH $SRC_NAME $BIN_NAME

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"