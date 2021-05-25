#!/bin/bash
echo "--------------------------------------------------"
echo "must run like : . unitInstall.sh , continue ? ( y/n )"
read continueStatus leftover
if [ $continueStatus == "y" ];then
	echo "--------------------------------------------------"
	ls -l BaseLnmp
	echo "--------------------------------------------------"
	echo "enter the script name ( example : nginx1155Install.sh ) :"
	read scriptName leftover
	chmod -R 755 `pwd`/BaseLnmp
	. BaseLnmp/${scriptName}
	echo "--------------------------------------------------"
	echo "$0 , success"
	echo "--------------------------------------------------"
fi