#!/bin/bash
currentDiretory=$(pwd)
tar -xvf frp_0.25.3_linux_amd64.tar.gz -C /usr/local/src/
cd /usr/local/src/frp_0.25.3_linux_amd64
rm -rf frpc frpc.ini