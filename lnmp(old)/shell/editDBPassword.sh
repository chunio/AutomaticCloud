#!/usr/bin/expect

	# systemctl restart mysqld.service
	# systemctl status mysqld.service
	# DB_PASSWORD='0000'
	# randomPassword=$(expr substr `cat /usr/local/mysql8015/log/error.log | grep 'A temporary password is generated for root@localhost' | tail -1 |cut -d ":" -f 4` 1 12)
	# echo "--------------------------------------------------"
	# echo "initialize random password : "$randomPassword
	# echo "--------------------------------------------------"

# expect << EOF
# spawn mysql -uroot -p
# expect "Enter password" { send "${randomPassword}\r" }
# expect "*mysql*" { send "ALTER user 'root'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';\r" }
# expect "*mysql*" { send "USE mysql;\r" }
# expect "*mysql*" { send "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_PASSWORD}';\r" }
# expect "*mysql*" { send "FLUSH PRIVILEGES;\r" }
# expect "*mysql*" { send "EXIT;\r" }
# EOF
#expect eof

	#cat resource/editDBPassword.sql |  
	#mysql -uroot -p'${randomPassword}'  -e 'show databases;'
	#
	#
	#
	

# expect << EOF
spawn cd / && ls
expect "bin" { send "echo haha" }
# expect eof
# EOF