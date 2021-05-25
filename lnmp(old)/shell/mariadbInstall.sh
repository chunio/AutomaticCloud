#!/bin/bash
#mariadbInstall,start-----
rm -f /var/run/yum.pid
ls /etc/yum.repos.d/mariadb.repo &> /dev/null

#repo配置需置頂行首
if [ $? -ne 0 ];then
echo '[mariadb]
name = mariadb
baseurl = http://yum.mariadb.org/10.2/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=0' > /etc/yum.repos.d/mariadb.repo
fi
installStatus=true
whileNum=1
while $installStatus
do
    yum -y install MariaDB-client MariaDB-server
    if [ $? -eq 0 ];then
        installStatus=false
    else
    	echo "網絡出錯 , 進行記憶安裝($whileNum)"
    	let whileNum++
    fi
done

#默認配置，start
echo '[client]
default_character_set = utf8
[mysqld]
character_set_server = utf8
init_connect = "SET NAMES utf8"
general_log = on
general_log_file = /var/lib/mysql/general.log
[client-server]
!includedir /etc/my.cnf.d' > /etc/my.cnf
mkdir /usr/local/mariadb
ln -s /etc/my.cnf /usr/local/mariadb/mariadb.conf
#默認配置，end

systemctl enable mariadb.service
systemctl start mariadb.service

#開啟遠程連接，start-----
DBPassword=cfcd208495d565ef66e7dff9f98764da
expect << EOF
spawn mysqladmin -u root -p password $DBPassword
expect "*password*" { send "\r" }
spawn mysql -uroot -p$DBPassword
expect "*MariaDB*" { send "USE mysql;\r" }
expect "*mysql*" { send "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DBPassword';\r" }
expect "*mysql*" { send "FLUSH PRIVILEGES;\r" }
expect "*mysql*" { send "EXIT;\r" }
expect eof
EOF
#開啟遠程連接，end-----

#創建軟鏈接
ln -s /var/lib/mysql /usr/local/mariadb

echo "--------------------------------------------------"
echo "password : $DBPassword"
echo "$0 success"
echo "--------------------------------------------------"
#mariadbInstall,end-----