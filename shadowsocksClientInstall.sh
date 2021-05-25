#!/bin/bash
#shadowsocksClientInstall,start-----
#參考:https://www.abcdocker.com/abcdocker/3151
rm -f /var/run/yum.pid
yum -y install python-pip
pip install --upgrade pip
pip install shadowsocks
mkdir /etc/shadowsocks && echo '{
    "server":"74.82.204.144",
    "server_port":10703,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"Bx2107187233",
    "timeout":10,
    "method":"aes-256-cfb",
    "fast_open": false,
    "workers": 1
}' > /etc/shadowsocks/shadowsocks.json
#fastOpen:true//要求内核3.7+
#開啟:echo 3 > /proc/sys/net/ipv4/tcp_fastopen
#關閉:echo 0 > /proc/sys/net/ipv4/tcp_fastopen
echo '[Unit]
Description=shadowsocks
[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/sslocal -c /etc/shadowsocks/shadowsocks.json
[Install]
WantedBy=multi-user.target' > /usr/lib/systemd/system/shadowsocks.service
systemctl enable shadowsocks.service
systemctl start shadowsocks.service

#安裝privoxy,start-----
yum -y install privoxy
cp /etc/privoxy/config /etc/privoxy/config.backup
echo 'forward-socks5t / 127.0.0.1:1080 .' >> /etc/privoxy/config
echo 'PROXY_DOMAIN=127.0.0.1
#export all_proxy=http://$PROXY_DOMAIN:8118
#export ftp_proxy=ftp://$PROXY_DOMAIN:8118
export http_proxy=http://$PROXY_DOMAIN:8118
export https_proxy=https://$PROXY_DOMAIN:8118
export no_proxy=localhost/*,127.0.0.1,10.10.0.0/16,172.16.0.0/16,192.168.0.0/16' >> /etc/profile
source /etc/profile
systemctl enable privoxy.service
systemctl start privoxy.service

echo '#!/bin/bash
echo "--------------------------------------------------"
stop(){
    systemctl stop privoxy.service &> /dev/null
    systemctl stop shadowsocks.service &> /dev/null
    unset http_proxy
    unset https_proxy
    unset no_proxy
	echo "privoxy is inactive/dead , getting current IP info ..."
}
start(){
    source /etc/profile
    systemctl start shadowsocks.service &> /dev/null
    systemctl start privoxy.service &> /dev/null
    echo "privoxy is active/running , getting current IP info ..."
}
case "$1" in
start)
    start
;;
stop)
    stop
;;
restart)
    stop
    start
;;
*)
    echo "usage : privoxy { start | stop | restart }"
    exit 1
;;
esac
curl ip.gs
echo "--------------------------------------------------"' > /usr/local/bin/privoxy
chmod 755 /usr/local/bin/privoxy

# #默認關閉（區別於:systemctl enable privoxy.service）
# echo 'privoxy stop' >> /etc/profile

echo "--------------------------------------------------"
echo "TODO : reboot"
echo "$0 , success"
echo "--------------------------------------------------"
exit 0
#shadowsocketClientInstall,end-----