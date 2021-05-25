#!/bin/bash
cd /windows/shell/swoole/ && tar -xvf hiredis-0.14.0.tar.gz -C /usr/local/src/PHPExtension/php7208 && cd /usr/local/src/PHPExtension/php7208/hiredis-0.14.0

#-----
cd /windows/shell/swoole/ && tar -xvf swoole-4.3.2.tgz -C /usr/local/src/PHPExtension/php7208 && cd /usr/local/src/PHPExtension/php7208/swoole-4.3.2
/usr/local/php7208/bin/phpize
./configure \
--with-php-config=/usr/local/php7208/bin/php-config \
--enable-openssl  \
--enable-http2  \
--enable-mysqlnd  \
--with-libpq-dir \
--enable-sockets \
--enable-debug-log \
--enable-trace-log && \
make clean && make && make install


#7124-----
cd /windows/shell/swoole/ && tar -xvf swoole-4.3.2.tgz -C /usr/local/src/PHPExtension/php7124 && cd /usr/local/src/PHPExtension/php7124/swoole-4.3.2
/usr/local/php7124/bin/phpize
./configure \
--with-php-config=/usr/local/php7124/bin/php-config \
--enable-openssl  \
--enable-http2  \
--enable-mysqlnd  \
--with-libpq-dir \
--enable-sockets \
--enable-debug-log \
--enable-trace-log && \
make clean && make && make install