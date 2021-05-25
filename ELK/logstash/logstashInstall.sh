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
	tar -xvf logstash-7.6.1.tar.gz -C /usr/local/src
}

function Configuration() {
	SERVICE_PATH='/usr/local/src/logstash-7.6.1'
	cd $SERVICE_PATH
# 	echo '
# input {										#此模塊負責收集日誌
# 	file {
#         type => "typeName1"					#代表类型，可以自定义
#         path => "/var/log"					#讀取文件路徑
#         codec => multiline {					#報錯提示信息
#                 pattern => "^\["
#                 negate => true
#                 what => "previous"
#         }
#         start_position => "beginning"			#表示文件從頭部開始讀取
# 	}
# 	file {
#         type => "typeName2"
#         path => "/var/log/logstash"
#         codec => multiline {
#                 pattern => "^\["
#                 negate => true
#                 what => "previous"
#         }   
#         start_position => "beginning"
# 	}
# }
# filter {										#此模塊負責過濾收集到的日誌
#     grok {									#過濾規則（正則），如第一條不符合則執行第二條
#         match => { "message" => "\[%{TIMESTAMP_ISO8601}\s*%{USER}\] \[%{USERNAME}\] \[%{USERNAME}\] - %{NOTSPACE}, IP: %{IP:ip}"}		
#     }
#     grok {
#         match => { "message" => "\[%{TIMESTAMP_ISO8601:datel}\s*%{USER:leve}\] \[%{USERNAME}\] \[%{USERNAME}\] - %{NOTSPACE:request}"}
#     }
# }	
# output {										#此模塊負責將過濾後的日誌輸出至file/redis/elasticsearch等
#     elasticsearch {
#         hosts => ["127.0.0.1:9200"]
#         action => "index"
#         codec => rubydebug
#         index => "%{type}-%{+YYYY.MM.dd}"
#         template_name => "%{type}"
#     }
# }' > config/logstash.conf
	echo '
input {
	file {
        type => "typeName"
        path => "/windows/"
        codec => multiline {
                pattern => "^\["
                negate => true
                what => "previous"
        }
        start_position => "beginning"
	}
}
filter {
    grok {
        match => { "message" => "\[%{TIMESTAMP_ISO8601}\s*%{USER}\] \[%{USERNAME}\] \[%{USERNAME}\] - %{NOTSPACE}, IP: %{IP:ip}"}		
    }
    grok {
        match => { "message" => "\[%{TIMESTAMP_ISO8601:datel}\s*%{USER:leve}\] \[%{USERNAME}\] \[%{USERNAME}\] - %{NOTSPACE:request}"}
    }
}	
output {
    elasticsearch {
        hosts => ["127.0.0.1:9200"]
        action => "index"
        codec => rubydebug
        index => "logstash-%{+YYYY.MM.dd}"
        template_name => "%{type}"
    }
}' > config/logstash.conf
	# ./bin/logstash -f ./config/logstash.conf &
    echo '[Unit]
Description=logstash
[Service]
Type=simple
User=root
Group=root
# Load env vars from /etc/default/ and /etc/sysconfig/ if they exist.
# Prefixing the path with '-' makes it try to load, but if the file does not
# exist, it continues onward.
EnvironmentFile=-/etc/default/logstash
EnvironmentFile=-/etc/sysconfig/logstash
ExecStart=/usr/local/src/logstash-7.6.1/bin/logstash -f /usr/local/src/logstash-7.6.1/config/logstash.conf
Restart=always
WorkingDirectory=/
Nice=19
LimitNOFILE=16384
[Install]
WantedBy=multi-user.target' > /lib/systemd/system/logstash.service
    chmod 754 /usr/lib/systemd/system/logstash.service
    systemctl daemon-reload
    systemctl enable logstash.service
    systemctl restart logstash.service
}

# CommonInit
BaseInstall 
Configuration

echo "--------------------------------------------------"
echo "$0 finished"
echo "--------------------------------------------------"
cd $SCRIPT_PATH