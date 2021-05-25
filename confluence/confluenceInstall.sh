#!/bin/bash

<<MARK
自行執行：
1，訪問{IPAddress}:8090
2，
MARK

SCRIPT_PATH=$(pwd)

function CommonInit {
    yum -y install epel-release
    yum -y install jdk-8u201-linux-x64.rpm
    # -----
    # memo:使用/usr/local/mysql5725/bin/mysql啟動，可能會失敗（已驗證：失敗）
# expect << EOF
# spawn /usr/local/mysql5725/bin/mysql -uroot -p
# expect "Enter password*" { send "0000\r" }
# expect "mysql*" { send "create database confluence character set utf8 collate utf8_bin;\r" }
# expect "mysql*" { send "EXIT;\r" }
# expect eof
# EOF
    # 目標數據庫添加配置選項,start-----
    # sed -i '/\[mysqld\]/a# confluence,start-----' /usr/local/mysql5725/mysql.conf
    # sed -i '/^# confluence,start-----$/acharacter_set_server = utf8' /usr/local/mysql5725/mysql.conf
    # sed -i '/^character_set_server.*/acollation-server = utf8_unicode_ci' /usr/local/mysql5725/mysql.conf
    # sed -i '/^collation-server.*/atransaction-isolation = READ-COMMITTED' /usr/local/mysql5725/mysql.conf
    # sed -i '/^transaction-isolation.*/a# confluence,end-----' /usr/local/mysql5725/mysql.conf
    # systemctl restart mysqld5725.service
    # 目標數據庫添加配置選項,end-----
    # 域名轉發需在數據庫初始化完畢再進行（否則數據庫初始化的時候，報錯504），start-----
# echo 'server {
#     listen       80;
#     server_name  localhost.confluence.com;
#     location /{
#             access_log off;
#             proxy_pass http://localhost:8090;
#             client_max_body_size 30m;
#             proxy_set_header Host $host;
#             proxy_set_header X-Real-IP $remote_addr;
#             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#     }
# }' > /usr/local/nginx1170/conf/virtualhost/confluence.conf
#     systemctl restart nginx1170.service
    # 域名轉發需在數據庫初始化完畢再進行，end-----
}

function BashInstall {
    cp atlassian-confluence-6.7.1-x64.bin /usr/local/src/
    cd /usr/local/src/
    chmod +x atlassian-confluence-6.7.1-x64.bin
expect << EOF
spawn ./atlassian-confluence-6.7.1-x64.bin
expect "This will install Confluence 6.7.1 on your computer" { send "o\r" }
expect "Choose the appropriate installation or upgrade option" { send "2\r" }
expect "Where should Confluence 6.7.1 be installed" { send "/usr/local/atlassian/confluence\r" }
expect "Default location for Confluence data" { send "/usr/local/atlassian/data\r" }
expect "Use default ports" { send "1\r" }
expect "Install Confluence as Service" { send "y\r" }
expect "Start Confluence now" { send "y\r" }
expect eof
EOF
    # service confluence restart
}

function PrepareActivate {
    mkdir /usr/local/atlassian/backup
    cp /usr/local/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.3.0.jar /usr/local/atlassian/backup
    cd /usr/local/atlassian/backup
    mv atlassian-extras-decoder-v2-3.3.0.jar atlassian-extras-2.4.jar
}

function Activate {
    service confluence stop
    cd /usr/local/atlassian/backup
    cp mysql-connector-java-5.1.47-bin.jar /usr/local/atlassian/confluence/confluence/WEB-INF/lib/
expect << EOF
spawn cp atlassian-extras-2.4.jar /usr/local/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.3.0.jar
expect "*overwrite*" { send "y\r" }
expect eof
EOF
    service confluence start
}

CommonInit
BashInstall
PrepareActivate
# Activate

echo ""
echo "--------------------------------------------------"
echo "TODO : [ service confluence restart ]"
echo "$0 success"
echo "--------------------------------------------------"
cd $SCRIPT_PATH