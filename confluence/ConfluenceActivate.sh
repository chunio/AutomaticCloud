#!/bin/bash
service confluence stop
cd /usr/local/atlassian/backup
mv -f atlassian-extras-2.4.jar /usr/local/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.3.0.jar
mv -f mysql-connector-java-5.1.47-bin.jar /usr/local/atlassian/confluence/confluence/WEB-INF/lib/
service confluence  start

expect << EOF
spawn mysql -uroot -p0000
expect "*MariaDB*" { send "CREATE DATABASE confluence CHARACTER SET utf8 COLLATE utf8_bin;\r" }
expect "*mysql*" { send "EXIT;\r" }
expect eof
EOF