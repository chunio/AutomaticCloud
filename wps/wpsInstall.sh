#!/bin/bash
yum -y localinstall wps-office-10.1.0.5672-1.a21.x86_64.rpm
#安裝微軟字體
yum -y install fontconfig
tar xpPf msfonts.tar.gz
fc-cache