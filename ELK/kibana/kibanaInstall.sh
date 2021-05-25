#!/bin/bash

:<<MARK
MARK

SCRIPT_PATH=$(pwd)
VERSION='7.6.1'

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
	cd $SCRIPT_PATH
	tar -xvf kibana-7.6.1-linux-x86_64.tar.gz -C /usr/local/src
}

function Configuration() {
	SERVICE_PATH='/usr/local/src/kibana-7.6.1-linux-x86_64'
	cd $SERVICE_PATH
	echo '
server.port: 5601									#服務端口
server.host: "0.0.0.0"								#服務IP(監聽？)
elasticsearch.hosts: ["http://localhost:9200"]		#elasticsearchServiceAddress
kibana.index: ".kibana"  							#默認 
xpack.security.enabled: false						#安全設置
' > config/kibana.yml
	# -----
	# ./bin/kibana --allow-root &
	echo '[Unit]
Description=kibana
After=network.target 
[Service]
User=root
ExecStart=/usr/local/src/kibana-7.6.1-linux-x86_64/bin/kibana --allow-root
[Install]
WantedBy=multi-user.target' > /lib/systemd/system/kibana.service
    chmod 754 /usr/lib/systemd/system/kibana.service
    systemctl daemon-reload
    systemctl enable kibana.service
    systemctl restart kibana.service
	# -----
	echo 'server {
		listen       80;
		server_name  localhost.kibana.com;
		location /{
		        access_log off;
		        proxy_pass http://localhost:5601;
		        client_max_body_size 30m;
		        proxy_set_header Host $host;
		        proxy_set_header X-Real-IP $remote_addr;
		        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		}
	}' > /usr/local/nginx1170/conf/virtualhost/kibana.conf
	systemctl restart nginx1170
}

# CommonInit
BaseInstall 
Configuration

echo "--------------------------------------------------"
echo "$0 finished"
echo "--------------------------------------------------"
cd $SCRIPT_PATH