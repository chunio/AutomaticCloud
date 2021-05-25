#!/bin/bash

:<<MARK
MARK

SCRIPT_PATH=$(pwd)
VERSION='7.6.1'

function BaseInstall() {
	# 官網>>https://www.elastic.co/cn/
	cd $SCRIPT_PATH
	tar -xvf filebeat-7.6.1-linux-x86_64.tar.gz -C /usr/local/src
}

function Configuration() {
	SERVICE_PATH='/usr/local/src/filebeat-7.6.1-linux-x86_64'
	cd $SERVICE_PATH
	echo '
filebeat.inputs:
- type: log
  enabled: true
  paths:
   - /windows/*.log
filebeat.config.modules:
  path: ${path.config}/modules.d/*.yml
  reload.enabled: false
setup.template.settings:
  index.number_of_shards: 1
setup.kibana:
# output.elasticsearch:
#   hosts: ["localhost:9200"]
#輸出至文件
output.file:
  path: "/windows"
  filename: "filebeat.txt"
filebeat.processors:
  # - add_host_metadata: ~
  # - add_cloud_metadata: ~
  # - add_docker_metadata: ~
  # - add_kubernetes_metadata: ~
- input_type: log
  paths:
  - /usr/local/nginx1170/log
  - /windows/*.log
  #排除以DBG開頭和空行
  exclude_lines: ['^DBG',"^$"]     
  document_type: apache
' > filebeat.yml
	# nohup ./filebeat -e -c filebeat.yml > filebeat.log &
	echo '[Unit]
Description=filebeat
After=network.target
[Service]
User=root
Group=root
ExecStart=/usr/local/src/filebeat-7.6.1-linux-x86_64/filebeat -e -c /usr/local/src/filebeat-7.6.1-linux-x86_64/filebeat.yml
[Install]
WantedBy=multi-user.target' > /lib/systemd/system/filebeat.service
    chmod 754 /usr/lib/systemd/system/filebeat.service
    systemctl daemon-reload
    systemctl enable filebeat.service
    systemctl restart filebeat.service
}

BaseInstall 
Configuration

echo "--------------------------------------------------"
echo "$0 success"
echo "--------------------------------------------------"
cd $SCRIPT_PATH