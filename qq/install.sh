yum -y install p7zip.x86_64 glibc.i686
rpm -ivh udis86-1.7.2-6.56ff6c8.fc24.i686.rpm
cp -rf etc/* /etc/.
cp -rf opt/* /opt/.
cp -rf usr/* /usr/.
bash run.sh