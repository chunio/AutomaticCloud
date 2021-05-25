#!/bin/bash

:<<MARK
./configure後面選項鍵值中間的等號兩邊不支持空格
MARK

rm -f /var/run/yum.pid
RESOURCE_PATH=$(cd resource && pwd)

function PrepareEnvironment() {
    RESOURCE_PATH=$1
    yum -y install gcc gcc-c++ utoconf automake make openssl openssl-devel libxml2-devel libxslt-devel perl-devel perl-ExtUtils-Embed libtool zlib zlib-devel pcre pcre-devel patch libxslt
    # pcre(rewrite功能),start-----
    cd $RESOURCE_PATH && tar -xvf pcre-8.42.tar.gz -C /usr/local/src/ && cd /usr/local/src/pcre-8.42
    ./configure && make -j8 && make install
    # zlib(gzip壓縮功能)，start-----
    cd $RESOURCE_PATH && tar -xvf zlib-1.2.11.tar.gz -C /usr/local/src/ && cd /usr/local/src/zlib-1.2.11
    ./configure && make -j8 && make install
    # openssl，start-----
    # 檢測是否重複安裝（php7150Install.sh）
    ls /usr/local/src/openssl-1.1.1-pre8
    if [ $? -ne 0 ];then
    cd $RESOURCE_PATH && tar -xvf openssl-1.1.1-pre8.tar.gz -C /usr/local/src/ && cd /usr/local/src/openssl-1.1.1-pre8
    ./config && make -j8 && make install
    fi
    # nginx-sticky-module(會話保持)，start-----
    cd $RESOURCE_PATH && tar -xvf nginx-goodies-nginx-sticky-module-ng-08a395c66e42.tar.gz -C /usr/local/src/
    #cd /usr/local/src && mv nginx-goodies-nginx-sticky-module-ng-08a395c66e42 nginx-sticky-module
    id nginx 2> /dev/null
    if [ $? ];then
        useradd -s /bin/false -M nginx
    fi
}

function BaseInstall() {
    RESOURCE_PATH=$1
    #ls $RESOURCE_PATH/nginx-1.17.0.tar.gz &> /dev/null
    # if [ $? -ne 0 ];then
    #     wget http://nginx.org/download/nginx-1.17.0.tar.gz -O /data/download/nginx-1.17.0.tar.gz
    # fi
    cd $RESOURCE_PATH && tar -xvf nginx-1.17.0.tar.gz -C /usr/local/src
    cd /usr/local/src/nginx-1.17.0
    #stub_status/性能統計模塊

    ./configure \
    --prefix=/usr/local/nginx1170 \
    --sbin-path=/usr/local/nginx1170/sbin/nginx \
    --conf-path=/usr/local/nginx1170/conf/nginx.conf \
    --error-log-path=/usr/local/nginx1170/log/error.log \
    --http-log-path=/usr/local/nginx1170/log/access.log \
    --pid-path=/usr/local/nginx1170/runtime/nginx.pid \
    --lock-path=/usr/local/nginx1170/runtime/nginx.lock \
    --user=nginx \
    --group=nginx \
    --with-mail \
    --with-stream \
    --with-file-aio \
    --with-ld-opt="-Wl,-E" \
    --with-mail_ssl_module \
    --with-mail_ssl_module \
    --with-pcre=/usr/local/src/pcre-8.42 \
    --with-zlib=/usr/local/src/zlib-1.2.11 \
    --with-openssl=/usr/local/src/openssl-1.1.1-pre8 \
    --with-http_v2_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_ssl_module \
    --with-http_sub_module \
    --with-http_perl_module \
    --with-http_xslt_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_stub_status_module \
    --with-http_random_index_module \
    --with-http_degradation_module \
    --with-http_secure_link_module \
    --with-http_gzip_static_module \
    --http-scgi-temp-path=/usr/local/nginx1170/runtime/scgi \
    --http-uwsgi-temp-path=/usr/local/nginx1170/runtime/uwsgi \
    --http-proxy-temp-path=/usr/local/nginx1170/runtime/proxy \
    --http-fastcgi-temp-path=/usr/local/nginx1170/runtime/fastcgi \
    --http-client-body-temp-path=/usr/local/nginx1170/runtime/client_body \
    --add-module=/usr/local/src/nginx-goodies-nginx-sticky-module-ng-08a395c66e42
    
    make -j8 && make install
}

function Configuration {

    mkdir -p /usr/local/nginx1170/conf/virtualhost

echo 'worker_processes 1;

events {
    worker_connections 1024;
}

http {
    include              mime.types;
    default_type         application/octet-stream;
    sendfile             on;
    keepalive_timeout    65;
    client_max_body_size 50m;
    include             /usr/local/nginx1170/conf/virtualhost/*.conf;
    #配置虛擬主機，start-----
    #配置虛擬主機，end-----
}' > /usr/local/nginx1170/conf/nginx.conf

echo '#虛擬主機1，start-----
server {      

    listen              80;
    server_name         localhost.chunio.com;
    root                /windows/website/chunio;
    
    #開啟laravel路由方式支持1，start-----
    #try_files $uri $uri/ @rewrite;
    #location @rewrite {
    #    rewrite ^/(.*)$ /index.php?_url=/$1;
    #}
    #開啟laravel路由方式支持1，end-----

    location / {
        
        index           index.php index.html;
        #開啟laravel路由方式支持2
        #thinkphp/yii2開啟一般會觸發302
        #try_files $uri $uri/ /index.php?$query_string;

        #thinkphp僞靜態，start-----
        #if (!-e $request_filename) {
        #        rewrite ^/index.php(.*)$ /index.php?s=$1 last;
        #        rewrite ^(.*)$ /index.php?s=$1 last;
        #        break;
        #}
        #thinkphp僞靜態，end-----

    }

    location ~ \.php(.*)$ {

        #監聽方式1，不建議使用
        #fastcgi_pass   127.0.0.1:9000;
        #監聽方式2，需同步設置從php-fpm.conf加載的www.conf
        fastcgi_pass    unix:/usr/local/php7280/runtime/php-fpm.sock;
        fastcgi_index   index.php;

        #解決循環重定向/302/thinkphp(1),start-----
        #fastcgi_split_path_info ^((?U).+\.php)(/?.+)$;
        #解決循環重定向/302/thinkphp(1),end-----

        fastcgi_param   SCRIPT_FILENAME $document_root$fastcgi_script_name;

        #解決循環重定向/302/thinkphp(2),start-----
        #fastcgi_param   PATH_INFO $fastcgi_path_info;
        #fastcgi_param   PATH_TRANSLATED $document_root$fastcgi_path_info;
        #解決循環重定向/302/thinkphp(2),end-----

        include         fastcgi.conf;
    }

    #error_log          /usr/local/src/log/CurrentServerName.error.log;
    #access_log         /usr/local/src/log/CurrentServerName.access.log;

}
#虛擬主機1，end-----' > /usr/local/nginx1170/conf/virtualhost/example.txt

}

function RegisterService {
    echo '[Unit]
Description=nginx 
After=network.target 
[Service] 
Type=forking 
ExecStart=/usr/local/nginx1170/sbin/nginx
ExecReload=/usr/local/nginx1170/sbin/nginx reload
ExecStop=/usr/local/nginx1170/sbin/nginx quit
PrivateTmp=true 
[Install] 
WantedBy=multi-user.target' > /lib/systemd/system/nginx1170.service
    chmod 754 /usr/lib/systemd/system/nginx1170.service
    systemctl daemon-reload
    systemctl enable nginx1170.service
    systemctl restart nginx1170.service
    ln -sf /usr/local/nginx1170/sbin/nginx /usr/local/bin
}

PrepareEnvironment $RESOURCE_PATH
BaseInstall $RESOURCE_PATH
Configuration
RegisterService

echo "--------------------------------------------------"
echo "$0 success"
echo "--------------------------------------------------"