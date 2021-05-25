#!/bin/bash
#sublimetextInstall,start-----
# ls /data/download/sublime_text_3_build_3176_x64.tar.bz2 &> /dev/null
# if [ $? -ne 0 ];then
# 	wget https://download.sublimetext.com/sublime_text_3_build_3176_x64.tar.bz2 -O /data/download/sublime_text_3_build_3176_x64.tar.bz2
# fi
mkdir -p /usr/local/sublimetext && tar -xvf sublime_text_3_build_3176_x64.tar.bz2  -C /usr/local/sublimetext
mv /usr/local/sublimetext/sublime_text_3/*  /usr/local/sublimetext && rm -rf /usr/local/sublimetext/sublime_text_3
ln -sf /usr/local/sublimetext/sublime_text ~/home/sublimetext
echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"
exit 0
#sublimetextInstall,end-----
