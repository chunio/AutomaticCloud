#!/bin/bash
#chromeInstall,start-----
#資源地址:https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
ls /etc/yum.repos.d/google-chrome.repo &> /dev/null
if [ $? -ne 0 ];then
echo '[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub' > /etc/yum.repos.d/google-chrome.repo
fi
installStatus=true
whileNum=1
while $installStatus
do
    yum -y --nogpgcheck install google-chrome-stable 
    if [ $? -eq 0 ];then
        installStatus=false
    else
    	echo "網絡出錯 , 進行記憶安裝($whileNum)"
    	let whileNum++
    fi
done

#ln -s `which google-chrome-stable` /usr/local/bin/chrome

echo '#!/bin/bash
google-chrome-stable --no-sandbox' > ~/desktop/chrome
chmod 755 ~/desktop/chrome

# mv /usr/share/applications/google-chrome.desktop /usr/share/applications/google-chrome.desktop.backup
# echo '[Desktop Entry]
# Version=1.0
# Name=Google Chrome
# Exec=/usr/bin/google-chrome-stable %U --no-sandbox
# Terminal=false
# Icon=google-chrome
# Type=Application
# Categories=Network;WebBrowser;
# MimeType=text/html;text/xml;application/xhtml_xml;image/webp;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;
# Actions=new-window;new-private-window;

# [Desktop Action new-window]
# Name=New Window
# Exec=/usr/bin/google-chrome-stable --no-sandbox

# [Desktop Action new-private-window]
# Name=New Incognito Window
# Exec=/usr/bin/google-chrome-stable --incognito --no-sandbox' > /usr/share/applications/google-chrome.desktop

echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"
exit 0
#chromeInstall,end-----