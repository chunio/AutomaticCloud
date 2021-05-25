#!/bin/bash
#mongodbInstal,start-----
#resourceDirectory=$(cd resource && pwd)
#cd $resourceDirectory && tar -xvf mongodb-linux-x86_64-rhel70-4.1.11.tgz -C /usr/local/src 
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-4.1.11.tgz && tar -xvf mongodb-linux-x86_64-rhel70-4.1.11.tgz -C /usr/local/src 
cp -r /usr/local/src/mongodb-linux-x86_64-rhel70-4.1.11/ /usr/local/mongodb
mkdir -p /usr/local/mongodb/data/example/db
mkdir -p /usr/local/mongodb/data/example/logs

echo "#設置數據文件存放目錄
dbpath = /usr/local/mongodb/bin/data/example/db
#設置日誌文件存放目錄及日誌文件名稱
logpath = /usr/local/mongodb/bin/data/example/logs/mongodb.log
#以天爲單位自動切割日誌
logappend = true  
#本地監聽IP，0.0.0.0表示本地所有IP
bind_ip = 0.0.0.0 
#設置端口號（默認:27017）
port = 27017
#設置以守護進程方式運行（即後台運行）
fork = true
#是否需要驗證權限登錄(用户/密碼)
#noauth = true
auth = true  
journal = true
#關閉http接口，默認關閉27018端口訪問
nohttpinterface = true" > /usr/local/mongodb/bin/mongodb.conf

# echo "[Unit]
# Description=mongodb
# After=network.target remote-fs.target nss-lookup.target
# [Service]
# Type=forking
# RuntimeDirectory=mongodb
# PIDFile=/usr/local/mongodb/data/example/db/mongod.lock
# ExecStart=/usr/local/mongodb/bin/mongod --config /usr/local/mongodb/bin/mongodb.conf
# ExecStop=/usr/local/mongodb/bin/mongod --shutdown --config /usr/local/mongodb/bin/mongodb.conf
# PrivateTmp=true
# [Install]  
# WantedBy=multi-user.target" > /lib/systemd/system/mongodb.service

# echo "[Unit]
# Documentation=man:systemd-sysv-generator(8)
# SourcePath=/usr/local/mongodb
# Description=SYSV: Mongo is a scalable, document-oriented database.
# Before=runlevel3.target runlevel5.target shutdown.target
# After=network-online.target vmware-tools-thinprint.service iprupdate.service vmware-tools.service network.service iprdump.service iprinit.service
# Conflicts=shutdown.target

# [Service]
# Type=forking
# Restart=no
# TimeoutSec=5min
# IgnoreSIGPIPE=no
# KillMode=process
# GuessMainPID=no
# RemainAfterExit=yes
# ExecStart=/usr/local/mongodb/bin/mongod start
# ExecStop=/usr/local/mongodb/bin/mongod stop
# ExecReload=/usr/local/mongodb/bin/mongod reload" > /lib/systemd/system/mongodb.service

echo "[Unit]
Description=mongodb
After=network.target remote-fs.target nss-lookup.target
[Service]
Type=forking
RuntimeDirectory=mongodb
ExecStart=/usr/local/mongodb/bin/mongod start
ExecStop=/usr/local/mongodb/bin/mongod stop
ExecReload=/usr/local/mongodb/bin/mongod reload
PrivateTmp=true
[Install]  
WantedBy=multi-user.target" > /lib/systemd/system/mongodb.service

systemctl daemon-reload
systemctl enable mongodb.service
systemctl start mongodb.service
