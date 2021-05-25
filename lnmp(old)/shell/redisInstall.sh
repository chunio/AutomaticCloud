#!/bin/bash

RESOURCE_PATH=$(cd resource && pwd)

function BaseInstall() {
    RESOURCE_PATH=$1
    # ls /data/download/redis-5.0.5.tar.gz &> /dev/null
    # if [ $? -ne 0 ];then
    #   wget http://download.redis.io/releases/redis-5.0.5.tar.gz -O /data/download/redis-5.0.5.tar.gz
    # fi
    cd $RESOURCE_PATH && tar -xvf redis-5.0.5.tar.gz -C /usr/local/src && cd /usr/local/src/redis-5.0.5
    make -j8
    mkdir -p /usr/local/redis
    cp /usr/local/src/redis-5.0.5/src/redis-server /usr/local/redis/
    cp /usr/local/src/redis-5.0.5/src/redis-cli /usr/local/redis/
}

function Configuration {
echo '#保護模式
protected-mode no
port 6379
tcp-backlog 511
timeout 0
tcp-keepalive 300
#是否守護進程
daemonize yes
supervised no
pidfile /var/run/redis_6379.pid
loglevel notice
logfile ""
databases 16
always-show-logo yes
save 900 1
save 300 10
save 60 10000
#設置no值，可臨時解決強制關閉redis快照導致的持久化失敗
stop-writes-on-bgsave-error yes
rdbcompression yes
rdbchecksum yes
dbfilename dump.rdb
dir ./
slave-serve-stale-data yes
slave-read-only yes
repl-diskless-sync no
repl-diskless-sync-delay 5
repl-disable-tcp-nodelay no
slave-priority 100
#設置密碼
requirepass 0000
lazyfree-lazy-eviction no
lazyfree-lazy-expire no
lazyfree-lazy-server-del no
slave-lazy-flush no
appendonly no
appendfilename "appendonly.aof"
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
aof-load-truncated yes
aof-use-rdb-preamble no
lua-time-limit 5000
slowlog-log-slower-than 10000
slowlog-max-len 128
latency-monitor-threshold 0
notify-keyspace-events ""
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-size -2
list-compress-depth 0
set-max-intset-entries 512
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
hll-sparse-max-bytes 3000
activerehashing yes
client-output-buffer-limit normal 0 0 0
client-output-buffer-limit slave 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
hz 10
aof-rewrite-incremental-fsync yes' > /usr/local/redis/redis.conf
}

function RegisterService {
#     echo '#!/bin/bash
# REDISPORT=6379
# EXEC=/usr/local/redis/redis-server     
# REDIS_CLI=/usr/local/redis/redis-cli     
# PIDFILE=/var/run/redis_6379.pid
# CONF="/usr/local/redis/redis.conf"     
# AUTH="0000"
# case "$1" in
#     start)
#         if [ -f $PIDFILE ]
#         then
#                 echo "redisServer is already active/running or crashed（$PIDFILE exists）"
#         else
#                 echo "waiting for redisServer to start ..."
#                 $EXEC $CONF
#         fi
#         if [ "$?"="0" ] 
#         then 
#                   echo "redisServer is active/running"
#         fi 
#         ;;
#     stop)
#         if [ ! -f $PIDFILE ]
#         then
#                 echo "redisServer is not active/running（$PIDFILE does not exist）"
#         else
#                 PID=$(cat $PIDFILE)
#                 echo "stopping ..."
#                 $REDIS_CLI -p $REDISPORT -a $AUTH SHUTDOWN
#                 while [ -x ${PIDFILE} ]
#                 do
#                     echo "waiting for redisServer to stop ..."
#                     sleep 1
#                 done
#                 echo "redisServer is inactive/dead"
#         fi
#         ;;
#     restart|force-reload)
#         ${0} stop
#         ${0} start
#         ;;
#       *)
#       echo "usage : redis {start|stop|restart|force-reload}" >&2
#         exit 1
# esac' > /etc/init.d/redis
#     chmod 755 /etc/init.d/redis
#     ln -s /etc/init.d/redis /usr/local/bin
    ln -s /usr/local/redis/redis-cli /usr/local/bin
echo '[Unit]
Description=redis
After=syslog.target network.target remote-fs.target nss-lookup.target
[Service]
Type=forking
PIDFile=/var/run/redis_6379.pid
ExecStart=/usr/local/redis/redis-server /usr/local/redis/redis.conf
ExecReload=/bin/kill -s HUP $MAINPID 
ExecStop=/bin/kill -s QUIT $MAINPID 
PrivateTmp=true
[Install]
WantedBy=multi-user.target' > /lib/systemd/system/redis.service
    systemctl enable redis.service
    systemctl restart redis.service
}

BaseInstall $RESOURCE_PATH
Configuration
RegisterService

echo "--------------------------------------------------"
echo "initialize password : 0000"
echo "$0 , success"
echo "--------------------------------------------------"