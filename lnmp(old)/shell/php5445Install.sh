#!/bin/bash
#phpInstall,start-----
rm -f /var/run/yum.pid
resourceDirectory=$(cd resource && pwd)
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
# 兼容mcrypt/re2c/bison安裝失敗，start-----
# tar -xvf libmcrypt-2.5.8.tar.gz -C /usr/local/src && cd /usr/local/src/libmcrypt-2.5.8
# ./configure --prefix=/usr/local
# make && make install
# # -----
# tar -xvf re2c-0.13.4.tar.gz -C /usr/local/src && cd /usr/local/src/re2c-0.13.4
# ./configure
# make && make install
# # -----
# tar -xvf bison-2.4.1.tar.gz -C /usr/local/src && cd /usr/local/src/bison-2.4.1
# ./configure
# make && make install
# 兼容mcrypt/re2c/bison安裝失敗，end-----
#-----

#解決報錯(onfigure: WARNING: bison versions supported for regeneration of the Zend/PHP parsers xxxx (found: 3.0)),start-----
#wget http://ftp.gnu.org/gnu/bison/bison-2.4.1.tar.gz
cd $resourceDirectory && tar -xvf bison-2.4.1.tar.gz -C /usr/local/src/ && cd /usr/local/src/bison-2.4.1
./configure
make && make install
#end-----

id www
if [ $? ];then
	useradd -s /bin/false -M www
fi
#-----
cd $resourceDirectory && tar -xvf php-5.4.45.tar.gz -C /usr/local/src && cd /usr/local/src/php-5.4.45

./configure \
--prefix=/usr/local/php5445 \
--exec-prefix=/usr/local/php5445 \
--bindir=/usr/local/php5445/bin \
--sbindir=/usr/local/php5445/sbin \
--includedir=/usr/local/php5445/include \
--libdir=/usr/local/php5445/lib/php \
--mandir=/usr/local/php5445/php/man \
--with-config-file-path=/usr/local/php5445/etc \
--with-mysql-sock=/var/lib/mysql/mysql.sock \
--with-mcrypt=/usr/include \
--with-mhash \
--with-openssl \
--with-mysql=shared,mysqlnd \
--with-mysqli=shared,mysqlnd \
--with-pdo-mysql=shared,mysqlnd \
--with-gd \
--with-iconv \
--with-zlib \
--enable-zip \
--enable-inline-optimization \
--disable-debug \
--disable-rpath \
--enable-shared \
--enable-xml \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-mbregex \
--enable-mbstring \
--enable-ftp \
--enable-gd-native-ttf \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-soap \
--without-pear \
--with-gettext \
--enable-session \
--with-curl \
--with-jpeg-dir \
--with-freetype-dir \
--enable-fpm \
--with-fpm-user=www \
--with-fpm-group=www \
--without-gdbm \
--enable-fileinfo \
--enable-calendar \
--with-bz2 \
--enable-wddx \

# ./configure \
# --prefix=/usr/local/php5445 \
# --exec-prefix=/usr/local/php5445 \
# --bindir=/usr/local/php5445/bin \
# --sbindir=/usr/local/php5445/sbin \
# --includedir=/usr/local/php5445/include \
# --libdir=/usr/local/php5445/lib/php \
# --mandir=/usr/local/php5445/php/man \
# --with-config-file-path=/usr/local/php5445/etc \
# --with-mysql-sock=/var/lib/mysql/mysql.sock \
# --with-mcrypt=/usr/include \
# --with-mhash \
# --with-openssl \
# --with-mysql=shared,mysqlnd \
# --with-mysqli=shared,mysqlnd \
# --with-pdo-mysql=shared,mysqlnd \
# --with-gd \
# --with-iconv \
# --with-zlib \
# --enable-zip \
# --enable-inline-optimization \
# --disable-debug \
# --disable-rpath \
# --enable-shared \
# --enable-xml \
# --enable-bcmath \
# --enable-shmop \
# --enable-sysvsem \
# --enable-mbregex \
# --enable-mbstring \
# --enable-ftp \
# --enable-gd-native-ttf \
# # 多進程？
# --enable-pcntl \
# --enable-sockets \
# --with-xmlrpc \
# --enable-soap \
# --without-pear \
# --with-gettext \
# --enable-session \
# --with-curl \
# --with-jpeg-dir \
# --with-freetype-dir \
# --enable-fpm \
# --with-fpm-user=www \
# --with-fpm-group=www \
# --without-gdbm \
# --enable-fileinfo \
# --enable-calendar \
# --with-bz2 \
# --enable-wddx \
# # odbc,start-----
# --with-sapdb \
# --with-solid \
# --with-ibm-db2 \
# --with-empress \
# --with-empress-bcs \
# --with-birdstep \
# --with-custom-odbc \
# --with-iodbc \
# --with-esoob \
# --with-unixODBC \
# --with-openlink \
# --with-dbmaker 
# # --with-adabas
# # odbc,end-----
# # --with-libzip 
# # 需要:mysql odbc

make && make install
#基礎配置,start##################################################
mkdir -p /run/php-fpm-5445/
mkdir -p /usr/local/php5445/logs
mkdir -p /var/lib/php5445/session
chown -R www:www /var/lib/php5445
#-----
touch /dev/shm/php-fpm-5445.sock
chmod 777 /dev/shm/php-fpm-5445.sock
chown www:www /dev/shm/php-fpm-5445.sock
#-----
touch /usr/local/php5445/logs/xdebug.log
chmod 777 /usr/local/php5445/logs/xdebug.log

#php-fpm.conf-----
echo 'pid = run/php-fpm.pid
error_log = /usr/local/php5445/logs/php-fpm-error.log
;如開啟加載，且無對應子配置文件時產生警告
;include=/usr/local/php5445/etc/php-fpm.d/*.conf

[www]
user = www
group = www

;監聽方式1，不建議使用
;listen = 127.0.0.1:9000

;監聽方式2，需同步設置nginx.conf中fastcgi_pass unix:/dev/shm/php-fpm.sock,start-----
listen = /dev/shm/php-fpm-5445.sock
listen.owner = www
listen.group = www
listen.mode = 0777
listen.allowed_clients = /dev/shm/php-fpm-5445.sock
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
slowlog = /usr/local/php5445/logs/slow.log
request_slowlog_timeout = 30s
request_terminate_timeout = 0' > /usr/local/php5445/etc/php-fpm.conf

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
error_log = /usr/local/php5445/logs/error.log
upload_tmp_dir = /tmp/www

;設置擴展
extension_dir = "/usr/local/php5445/lib/php/extensions/no-debug-non-zts-20100525"
extension = redis.so
extension = mysql.so
extension = mysqli.so
extension = pdo_mysql.so

;設置時區
date.timezone = Asia/Shanghai

;設置腳本允許訪問的目錄（根据實際情況）
open_basedir = /windows:/data:/tmp

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
pdo_mysql.default_socket=
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

;##################################################
;推薦設置（未驗證）
;opcache.memory_consumption = 128
;opcache.interned_strings_buffer = 8
;opcache.max_accelerated_files = 4000
;OpcacheRevalidateFreq默認2，檢查腳本時間戳是否有更新的周期，0時會導致針對每個請求opcache都會檢查腳本更新，单位/秒
;opcache.revalidate_freq = 60
;opcache.fast_shutdown = 1
;opcache.enable_cli = 1
;##################################################

[curl]
[openssl]' > /usr/local/php5445/etc/php.ini
#基礎配置，end##################################################

#安裝擴展，start##################################################
mkdir -p /usr/local/src/PHPExtension/php5445
# redis,start-----
# cd $resourceDirectory
# tar -xvf phpredis-2.2.4.tar.gz -C /usr/local/src/PHPExtension/php5445 && cd /usr/local/src/PHPExtension/php5445/phpredis-2.2.4
# /usr/local/php5445/bin/phpize
# ./configure --with-php-config=/usr/local/php5445/bin/php-config
# make && make install
#安裝擴展，end##################################################

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

ln -s /usr/local/php5445/bin/php /usr/local/bin/php5445

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"

:<<MARK
常見錯誤:
#configure: WARNING: unrecognized options: --with-mcrypt, --enable-gd-native-ttf
#configure: WARNING: You will need re2c 0.13.4 or later if you want to regenerate PHP parsers.
library containing opendir... none required
checking for valgrind header... not found
#configure: WARNING: Use of bundled libzip is deprecated and will be removed.
configure: WARNING: Some features such as encryption and bzip2 are not available.
#configure: WARNING: Use system library and --with-libzip is recommended.
MARK