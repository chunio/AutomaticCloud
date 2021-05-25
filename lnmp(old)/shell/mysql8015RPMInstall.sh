#!/bin/bash

resourceDirectory=$(cd resource && pwd)

function mysqlCompile() {
	mkdir /usr/local/mysql8015
	cd $1 && tar -xvf mysql-8.0.15-1.el7.x86_64.rpm-bundle.tar -C /usr/local/mysql8015	

	rpm -ivh mysql-community-common-8.0.15-1.el7.x86_64.rpm --nodeps --force
	rpm -ivh mysql-community-libs-8.0.15-1.el7.x86_64.rpm --nodeps --force
	rpm -ivh mysql-community-client-8.0.15-1.el7.x86_64.rpm --nodeps --force
	rpm -ivh mysql-community-server-8.0.15-1.el7.x86_64.rpm --nodeps --force
}

mysqlCompile $resourceDirectory

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"
exit 0