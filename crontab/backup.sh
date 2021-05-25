#!/bin/bash

#config,start-----
currentDate=$(date +"%Y%m%d")
backupDirectory='/home/backup/'
#-----
dbPassword='0000'
dbBackupLimit=31
#-----
#interval/備份週期（單位:天）
codeBackupStep=7
codeBackupLimit=4
codeSourceDirectory='/data/website/'
#config,end-----

#database,start-----
mkdir -p $backupDirectory'/mariadb' && mysqldump --all-databases -uroot -p$dbPassword > $backupDirectory/mariadb/$currentDate'.sql'
if [ $(ls -l $backupDirectory"/mariadb/" | grep "^-" | wc -l) -gt $dbBackupLimit ];then
	dbMinDate=0
	for dbHistoryfilename in `ls $backupDirectory'/mariadb' 2> /dev/null`
	do
		dbHistoryDate=${dbHistoryfilename:0:$[$(#dbHistoryfilename)-4]}
		if [ $[$dbHistoryDate-$dbMinDate] -eq $dbHistoryDate ] || [ $[$dbHistoryDate-$dbMinDate] -le 0 ];then
			dbMinDate=$dbHistoryDate
		fi
	done
	rm -rf $backupDirectory'/mariadb/'$dbMinDate'.sql'
fi
#database,end-----

#website,start-----
codeMinDate=0
codeMaxDate=0
for historyDate in `ls $backupDirectory'/website' 2> /dev/null`
do
	if [ $[$historyDate-$codeMaxDate] -ge 0 ];then
		codeMaxDate=$historyDate
	fi
	if [ $[$historyDate-$codeMinDate] -eq $historyDate ] || [ $[$historyDate-$codeMinDate] -le 0 ];then
		codeMinDate=$historyDate
	fi
done
#是否達到週期
if [ "$[$currentDate-$codeMaxDate]" -ge $codeBackupStep ];then
	mkdir -p $backupDirectory'/website/'$currentDate && cp -rfp $codeSourceDirectory'*' $backupDirectory'/website/'$currentDate
	#是否達到上限
	if [ $(ls -l $backupDirectory"/website/" | grep "^d" | wc -l) -gt $codeBackupLimit ];then
		rm -rf $backupDirectory'/website/'$codeMinDate
	fi
fi
#website,end-----