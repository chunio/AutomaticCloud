#!/bin/bash
#wineInstall,start-----
rm -f /var/run/yum.pid
ls /data/download/wine-3.0.2.tar.xz &> /dev/null
if [ $? -ne 0 ];then
	wget https://dl.winehq.org/wine/source/3.0/wine-3.0.2.tar.xz -O /data/download/wine-3.0.2.tar.xz
fi
 
# cd /etc/yum.repos.d && wget http://public-yum.oracle.com/public-yum-el5.repo
# cd /etc/pki/rpm-gpg && wget https://public-yum.oracle.com/RPM-GPG-KEY-oracle-el5
# yum -y groups install 'Development Tools'

installStatus=true
whileNum=1
while $installStatus
do
    yum -y install libX11-devel freetype-devel zlib-devel libxcb-devel libxslt-devel libgcrypt-devel libxml2-devel gnutls-devel libpng-devel libjpeg-turbo-devel libtiff-devel gstreamer-devel dbus-devel fontconfig-devel libXxf86vm libGLU libOSMesa curses libv4l libgphoto2 gstreamer libtiff libmpg123 openal-soft OpenGL libxslt
    if [ $? -eq 0 ];then
        installStatus=false
    else
    	echo "##################################################"
    	echo "網絡出錯 , 進行記憶安裝($whileNum)"
    	let whileNum++
    fi
done
cd /data/download && tar -xvf wine-3.0.2.tar.xz -C /usr/local/src && cd /usr/local/src/wine-3.0.2
./configure --enable-win64 && make && make install
#-----
yum -y install cabextract
cp -rf /data/download/winetricks-zh-master /usr/local/
chmod -R a+x /usr/local/winetricks-zh-master
ln -s /usr/local/winetricks-zh-master/winetricks-zh /usr/local/bin
# mkdir -p ~/.cache/winetricks/win2ksp4/ && cp /data/download/W2KSP4_EN.EXE ~/.cache/winetricks/win2ksp4/
# mkdir -p ~/.cache/winetricks/msls31/ && cp /data/download/instmsiw.exe ~/.cache/winetricks/msls31/
mkdir -p /home/zengweitao/.cache/winetricks/win2ksp4 && cp /data/download/W2KSP4_EN.EXE /home/zengweitao/.cache/winetricks/win2ksp4
mkdir -p /home/zengweitao/.cache/winetricks/msls31/ && cp /data/download/instmsiw.exe /home/zengweitao/.cache/winetricks/msls31/
su - zengweitao
export WINE=/usr/local/src/wine-3.0.2/wine
winetricks-zh qq

#-----
cp /home/zengweitao/.wine/dosdevices/c:/windows/regedit.exe /home/zengweitao/.wine/dosdevices/c:/windows/system32

echo "##################################################"
echo "$0 , end-----"
exit 0
#wineInstall,end-----
:<<MARK
configure: libxcursor 64-bit development files not found, the Xcursor extension won't be supported.
configure: libxi 64-bit development files not found, the Xinput extension won't be supported.
configure: XShm 64-bit development files not found, X Shared Memory won't be supported.
configure: XShape 64-bit development files not found, XShape won't be supported.
-> 	configure: libXxf86vm 64-bit development files not found, XFree86 Vidmode won't be supported.
configure: libxrandr 64-bit development files not found, XRandr won't be supported.
configure: libxfixes 64-bit development files not found, Xfixes won't be supported.
configure: libxinerama 64-bit development files not found, multi-monitor setups won't be supported.
configure: libxcomposite 64-bit development files not found, Xcomposite won't be supported.
-> 	configure: libGLU 64-bit development files not found, GLU won't be supported.
-> 	configure: libOSMesa 64-bit development files not found (or too old), OpenGL rendering in bitmaps won't be supported.
configure: OpenCL 64-bit development files not found, OpenCL won't be supported.
configure: pcap 64-bit development files not found, wpcap won't be supported.
configure: libdbus 64-bit development files not found, no dynamic device support.
-> 	configure: lib(n)curses 64-bit development files not found, curses won't be supported.
	//curses
configure: libsane 64-bit development files not found, scanners won't be supported.
-> 	configure: libv4l 64-bit development files not found.
-> 	configure: libgphoto2 64-bit development files not found, digital cameras won't be supported.
configure: libgphoto2_port 64-bit development files not found, digital cameras won't be auto-detected.
configure: liblcms2 64-bit development files not found, Color Management won't be supported.
configure: libpulse 64-bit development files not found or too old, Pulse won't be supported.
-> 	configure: gstreamer-1.0 base plugins 64-bit development files not found, GStreamer won't be supported.
configure: OSS sound system found but too old (OSSv4 needed), OSS won't be supported.
configure: libudev 64-bit development files not found, plug and play won't be supported.
configure: libcapi20 64-bit development files not found, ISDN won't be supported.
configure: libcups 64-bit development files not found, CUPS won't be supported.
-> 	configure: fontconfig 64-bit development files not found, fontconfig won't be supported.
configure: libgsm 64-bit development files not found, gsm 06.10 codec won't be supported.
-> 	configure: libtiff 64-bit development files not found, TIFF won't be supported.
-> 	configure: libmpg123 64-bit development files not found (or too old), mp3 codec won't be supported.
configure: libopenal 64-bit development files not found (or too old), OpenAL won't be supported.
-> 	configure: openal-soft 64-bit development files not found (or too old), XAudio2 won't be supported.
configure: libldap (OpenLDAP) 64-bit development files not found, LDAP won't be supported.

configure: WARNING: libxrender 64-bit development files not found, XRender won't be supported.
-> 	configure: WARNING: No OpenGL library found on this system.
OpenGL and Direct3D won't be supported.
-> 	configure: WARNING: libxslt 64-bit development files not found, xslt won't be supported.
configure: WARNING: libgnutls 64-bit development files not found, no schannel support.
configure: WARNING: No sound system was found. Windows applications will be silent.

cp /usr/lib64/wine/fakedlls/mountmgr.sys ~/.wine/drive_c/windows/system32/drivers/
cp /usr/lib64/wine/fakedlls/winebus.sys ~/.wine/drive_c/windows/system32/drivers/
MARK