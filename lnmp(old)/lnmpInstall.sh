#!/bin/bash
#lnmpInstall,start-----
echo "--------------------------------------------------"
echo "must run like : . lnmpInstall.sh , continue ? ( y/n )"
read continueStatus leftover
if [ $continueStatus == "y" ];then
	chmod -R 755 `pwd`/shell
	echo "--------------------------------------------------"
	echo "enter { index } to complete installation :"
	echo "10.code index"
	echo "11.rpm index"
	echo "----------"
	echo "1.nginx(1.15.2)"
	echo "2.mariadb(10.2.17)"
	echo "----------"
	echo "3A.php(5.4.45/extensions:redis)"
	echo "3B.php(7.1.24/extensions:redis,xdebug,swoole)"
	echo "3C.php(7.1.50/extensions:redis,mcrypt,xdebug)"
	echo "3D.php(7.2.80/extensions:redis,mcrypt,xdebug,swoole)"
	echo "----------"
	echo "4.redis(5.0.5)"
	echo "5.install all"
	read reply leftover
	case $reply in
		10)
			bash shell/mysql5725Install.sh
			;;
		11)
			bash shell/mysqlRPMInstall.sh
			;;
	    1)
			bash shell/nginxInstall.sh
	    	;;
	    2)
			bash shell/mariadbInstall.sh
	    	;;
	    3)
			bash shell/php5445Install.sh
			bash shell/php7124Install.sh
			bash shell/php7208Install.sh
	    	;;
		4)
			bash shell/redisInstall.sh
	    	;;
	    5)
			bash shell/nginxInstall.sh
			bash shell/mariadbInstall.sh
			#-----
			bash shell/php5445Install.sh
			bash shell/php7032Install.sh
			bash shell/php7124Install.sh
			bash shell/php7150Install.sh
			bash shell/php7280Install.sh
			#-----
			bash shell/redisInstall.sh
	    	;;
	    *)
			echo "usage : $0 >> { 0 | 1 | 2 | 3 | 4 | 5 }"
			;;
	esac
	echo "$0 , success"
	echo "--------------------------------------------------"
fi