#!bin/bash
tar -xvf gcc-5.3.0.tar.gz -C /usr/local/src/ && cd /usr/local/src/gcc-5.3.0
./contrib/download_prerequisites

#安裝依賴庫，start-----
mkdir /usr/local/src/gcc-5.3.0-dependent && mv ./*.tar.* /usr/local/src/gcc-5.3.0-dependent && cd /usr/local/src/gcc-5.3.0-dependent
for fileName in $(ls *.tar.*);do tar -xvf $fileName;done

cd gmp-4.3.2
./configure
make -j8 && make install

cd ../mpfr-2.4.2
./configure
make -j8 && make install

cd ../mpc-0.8.1
./configure
make -j8 && make install
#安裝依賴庫，end-----

cd /usr/local/src/gcc-5.3.0
./configure \
--prefix=/usr/local/gcc \
--enable-bootstrap  \
--enable-languages=c,c++ \
--enable-checking=release \
--disable-multilib
make -j8 && make install

ln -sf /usr/local/gcc/bin/gcc /usr/bin/

# for folder in $(ls | grep -v ".*tar.*");
# do
# 	cd /usr/local/src/gcc-5.3.0-dependent
# 	cd $folder
# 	./configure
# 	make && make install
# done
# cd /usr/local/src/gcc-5.3.0