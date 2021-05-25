#!/bin/bash

:<<MARK
http://pecl.php.net/package/xhprof（博客：https://blog.csdn.net/qq_21891743/article/details/82990475）
MARK

function BaseInstall {
	#mkdir -p /usr/local/src/PHPExtension/php5445
	#wget http://pecl.php.net/get/xhprof-0.9.4.tgz(php5.4)
	tar -zxf xhprof-0.9.4.tgz -C /usr/local/src/PHPExtension/php5445
	cd /usr/local/src/PHPExtension/php5445/xhprof-0.9.4
	cp -r xhprof_html xhprof_lib /windows/LocalBranch/37/quantum
	cd extension
	/usr/local/php5445/bin/phpize
	./configure \
	--with-php-config=/usr/local/php5445/bin/php-config
	make -j8 && make install
}

BaseInstall