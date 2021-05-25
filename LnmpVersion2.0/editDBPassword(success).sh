#!/bin/bash

oldPassword='root@appinside'
newPassword='0000'

# sed -i 's/# validate_password=off/validate_password=off/g' /usr/local/mysql5725/mysql.conf
# systemctl restart mysqld.service

expect << EOF
spawn mysqladmin -u root -p password $newPassword
expect "Enter password*" { send "${oldPassword}\r" }
# expect "*mysql*" { send "ALTER user 'root'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';\r" }
# expect "*mysql*" { send "USE mysql;\r" }
# expect "*mysql*" { send "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_PASSWORD}';\r" }
# expect "*mysql*" { send "FLUSH PRIVILEGES;\r" }
# expect "*@*" { send "EXIT;\r" }
expect eof
EOF

expect << EOF
spawn mysql -uroot -p
expect "Enter password*" { send "${newPassword}\r" }
expect "mysql*" { send "SHOW DATABASES;\r" }
expect "mysql*" { send "EXIT;\r" }
expect eof
EOF