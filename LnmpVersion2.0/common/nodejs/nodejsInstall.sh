#!/bin/bash

echo "--------------------------------------------------"
echo "installation info:"
echo "1.nodejs(8.11.4)"
echo "2.vue"
echo "3.apidoc"
echo "enter { y/n } to continue"
read reply leftover
case $reply in
    y* | Y*)
    	;;
    *)
	    exit 1
	    ;;
esac
tar -xvf node-v8.11.4-linux-x64.tar.xz -C /usr/local/
mv /usr/local/node-v8.11.4-linux-x64 /usr/local/nodejs
ln -sf /usr/local/nodejs/bin/* /usr/local/bin
#cnpm(淘寶源)-----
. privoxy stop &> /dev/null
npm install -g cnpm --registry=https://registry.npm.taobao.org
ln -sf /usr/local/nodejs/bin/cnpm /usr/local/bin
. privoxy start &> /dev/null
#vue(腳手架/構建工具)-----
cnpm install -g vue-cli
#apidoc-----
cnpm install -g apidoc 
ln -sf /usr/local/nodejs/bin/apidoc /usr/local/bin

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"