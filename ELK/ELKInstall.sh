#!/bin/bash
# echo "--------------------------------------------------"
# echo "must run like : . unitInstall.sh , continue ? ( y/n )"
# read continueStatus leftover
# if [ $continueStatus == "y" ];then
# 	echo "--------------------------------------------------"
# 	for item in `ls -l | grep -v '\.sh' | awk '{print $9}'`
# 	do
# 		echo ${item}
# 	done
# 	echo "--------------------------------------------------"
# 	echo "enter the item name ( example : elasticsearch ) :"
# 	read item leftover
# 	cd $item 
# 	. ${item}Install.sh
# 	cd ..
# 	echo "--------------------------------------------------"
# 	echo "$0 , success"
# 	echo "--------------------------------------------------"
# fi

echo "--------------------------------------------------"
echo "must run like : . ELKInstall.sh , continue ? ( y/n )"
read continueStatus leftover
if [ $continueStatus == "y" ];then
	echo "--------------------------------------------------"
	cd filebeat
		. filebeatInstall.sh
	cd ..
	cd logstash
	 	. logstashInstall.sh
	cd ..
	cd elasticsearch 
		. elasticsearchInstall.sh
	cd ..
	cd kibana
		. kibanaInstall.sh
	cd ..
	systemctl status filebeat.service
	systemctl status logstash.service
	systemctl status elasticsearch.service
	systemctl status kibana.service
	echo "--------------------------------------------------"
	echo "$0 , success"
	echo "kibana.service is starting , need to wait for a while"
	echo "--------------------------------------------------"
fi