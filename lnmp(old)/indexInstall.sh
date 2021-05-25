#!/bin/bash
echo "--------------------------------------------------"
echo "must run like : . indexInstall.sh , continue ? ( y/n )"
read continueStatus leftover
if [ $continueStatus == "y" ];then
	bash shell/nginx1155Install.sh
	bash shell/mysql5725Install.sh
	#-----
	bash shell/php7150Install.sh
	#-----
	bash commonInstall.sh
	echo "--------------------------------------------------"
	echo "$0 , success"
	echo "--------------------------------------------------"
fi