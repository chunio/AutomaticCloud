#!/bin/bash

:<<MARK
1，不支持root運行
MARK

SCRIPT_PATH=$(pwd)
VERSION='7.6.1'
echo $SCRIPT_PATH

#準備環境
function CommonInit {
	yum -y remove java &> /dev/null
	tar -xvf jdk-13.0.2_linux-x64_bin.tar.gz -C /usr/local/src
	echo '
#set oracle jdk environment
export JAVA_HOME=/usr/local/src/jdk-13.0.2
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH' >> /etc/bashrc
	source /etc/bashrc
	echo "--------------------------------------------------"
	java -version
	echo "--------------------------------------------------"
}

function BaseInstall() {
	# 官網>>https://www.elastic.co/cn/
	# https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.1-linux-x86_64.tar.gz
	cd $SCRIPT_PATH
	tar -xvf elasticsearch-7.6.1-linux-x86_64.tar.gz -C /usr/local/src
}

function Configuration() {
	SERVICE_PATH='/usr/local/src/elasticsearch-7.6.1'
	PROCESS_USER='elasticsearch'
	cd $SERVICE_PATH
	echo '
cluster.name: clusterName #集群名稱
node.name: nodeName #節點名稱
path.data: /usr/local/src/elasticsearch-'${VERSION}'/data #數據存放路徑
path.logs: /usr/local/src/elasticsearch-'${VERSION}'/log #日誌存放路徑
network.host: 127.0.0.1 #綁定的服務器地址
http.port: 9200 #目標端口' > config/elasticsearch.yml
	id $PROCESS_USER 2> /dev/null
	if [ $? ];then
		# useradd -s /bin/false -M $PROCESS_USER
		useradd $PROCESS_USER
	fi
	chown -R $PROCESS_USER:$PROCESS_USER $SERVICE_PATH
	# su $PROCESS_USER
	# ./bin/elasticsearch -d 
# 	expect << EOF
# spawn su $PROCESS_USER
# expect $PROCESS_USER { send "./bin/elasticsearch -d\r" }
# expect eof
# EOF
	# whileNum=0
	# checkStatus=true
	# while $checkStatus && [ $whileNum -le 5 ]
	# do
	#     curl http://127.0.0.1:9200
	#     if [ $? ];then
	#         checkStatus=false
	#     else
	#     	let whileNum++
	#     	echo 'connecting('$whileNum's)'
	#     	sleep 1
	#     fi
	# done
	echo '[Unit]
Description=elasticsearch
After=network.target 
[Service]
User=elasticsearch
LimitNOFILE=100000
LimitNPROC=100000
ExecStart=/usr/local/src/elasticsearch-7.6.1/bin/elasticsearch
[Install]
WantedBy=multi-user.target' > /lib/systemd/system/elasticsearch.service
    chmod 754 /usr/lib/systemd/system/elasticsearch.service
    systemctl daemon-reload
    systemctl enable elasticsearch.service
    systemctl restart elasticsearch.service
}

#CommonInit8
BaseInstall 
Configuration

echo "--------------------------------------------------"
echo "$0 finished"
echo 'check : curl http://127.0.0.1:9200'
echo "--------------------------------------------------"
cd $SCRIPT_PATH