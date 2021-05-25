#!/bin/bash

:<<MARK
MARK

SCRIPT_PATH=$(pwd)

#準備環境
#詳情：https://docs.docker.com/engine/install/centos/
function CommonInit {
	# 卸載舊版，start -----
	yum -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
	# 卸載新版，start -----
	yum -y remove docker-ce docker-ce-cli containerd.io
	rm -rf /var/lib/docker /var/lib/containerd
	# end-----
	yum -y install yum-utils device-mapper-persistent-data lvm2
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	echo "--------------------------------------------------"
	yum list docker-ce --showduplicates | sort -r
	echo "--------------------------------------------------"
}

function BaseInstall {
	# yum -y install docker-ce-17.12.1.ce
	yum -y install docker-ce
}

function RegisterService {
	# 配置文件（支持其他選項）：/etc/docker/daemon.json
echo '{
  "registry-mirrors" : [ "https://registry.docker-cn.com" ]
}' > /etc/docker/daemon.json
	systemctl enable docker.service
	systemctl restart docker.service
	# docker run hello-world
	docker version
	docker info
}

CommonInit
BaseInstall
RegisterService

echo "--------------------------------------------------"
echo "$0 success"
echo "--------------------------------------------------"
cd $SCRIPT_PATH