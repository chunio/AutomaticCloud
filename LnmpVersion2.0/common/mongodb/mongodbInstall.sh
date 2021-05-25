#!/bin/bash

:<<MARK
問題1：	由於網絡下載（wget）可能會導致資源缺失，解壓時將出現如下錯誤：
		tar: Skipping to next header
		tar: Exiting with failure status due to previous errors
解決1：	通過瀏覽器自行下載（https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-4.4.5.tgz）
MARK

VERSION_NUMBER='mongodb-linux-x86_64-rhel70-4.4.5'
rm -rf /usr/local/src/mongodb/${VERSION_NUMBER} /usr/local/mongodb
#wget https://fastdl.mongodb.org/linux/${VERSION_NUMBER}.tgz
tar xvf ${VERSION_NUMBER}.tgz -C /usr/local/src && cp -r /usr/local/src/${VERSION_NUMBER} /usr/local/mongodb
mkdir -p /usr/local/mongodb/data/{db,log}
chmod -R 777 /usr/local/mongodb/data
ln -s /usr/local/mongodb/bin/* /usr/local/bin

echo "#設置數據文件存放目錄
dbpath = /usr/local/mongodb/data/db
#設置日誌文件存放目錄及日誌文件名稱
logpath = /usr/local/mongodb/data/log/mongodb.log
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
#nohttpinterface = true" > /usr/local/mongodb/mongodb.conf

echo "[Unit]
Description=mongodb
After=network.target remote-fs.target nss-lookup.target
[Service]
Type=forking
RuntimeDirectory=mongodb
PIDFile=/usr/local/mongodb/data/db/mongod.lock
ExecStart=/usr/local/mongodb/bin/mongod --config=/usr/local/mongodb/mongodb.conf
ExecStop=/usr/local/mongodb/bin/mongod --shutdown --dbpath /usr/local/mongodb/db/
ExecReload=/usr/local/mongodb/bin/mongod reload
PrivateTmp=true
[Install]  
WantedBy=multi-user.target" > /lib/systemd/system/mongodb.service

systemctl daemon-reload
systemctl enable mongodb.service
systemctl restart mongodb.service
systemctl status mongodb.service