#!/bin/bash
#共享嚮導,start-----
echo "mount windows folder ?（y/n）"
read mountWindowsFolder leftover
if [ $mountWindowsFolder == "y" ];then
	echo "windows IP/folder ( example : 127.0.0.1/folder ) :"
	read windowsIPFolder leftover	
	echo "windows username :"
	read windowsUsername leftover	
	stty -echo
	echo "windows password :"
	read windowsPassword leftover	
	stty echo
fi
echo "share linux folder ( install samba ) ?（y/n）"
read shareLinuxFolder leftover
#共享嚮導,end-----

# windows共享至linux,start-----
if [ $mountWindowsFolder == "y" ];then
mkdir -p /windows
echo "//$windowsIPFolder /windows cifs dir_mode=0777,file_mode=0777,username=$windowsUsername,password=$windowsPassword,vers=3.0 0 0" >> /etc/fstab
mount -a
fi
# windows共享至linux,end-----

# linux共享至windows,start-----
if [ $shareLinuxFolder == "y" ];then
yum -y install samba
echo "
[data]
        path = /data
        public = yes
        writable = yes
        read only = no
        browseable = yes
        workgroup = WORKGROUP" >> /etc/samba/smb.conf
useradd samba
expect << EOF
spawn smbpasswd -a samba
expect "*password*" { send "0000\r" }
expect "*password*" { send "0000\r" }
expect eof
EOF
systemctl enable smb
systemctl restart smb
chown -R samba:samba /data
fi
# linux共享至windows,end-----




# temp mount
# mount -t cifs -o username=zengweitao,password=20190517,rw,file_mode=0777,dir_mode=0777,uid=1001,gid=1001 //192.168.228.1/CodeRepository /windows