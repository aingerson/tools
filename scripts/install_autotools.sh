#!/bin/bash

mkdir autotools_build
cd autotools_build

mkdir autoconf
mkdir automake
mkdir libtool

wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz -O autoconf.tar.gz
wget http://ftp.gnu.org/gnu/automake/automake-1.16.tar.gz -O automake.tar.gz
wget http://ftp.gnu.org/gnu/libtool/libtool-2.4.tar.gz -O libtool.tar.gz

tar -xvf autoconf.tar.gz -C autoconf --strip-components=1
tar -xvf automake.tar.gz -C automake --strip-components=1
tar -xvf libtool.tar.gz -C libtool --strip-components=1

(cd autoconf && ./configure --prefix=$HOME && make -j install)
(cd automake && ./configure --prefix=$HOME && make -j install)
(cd libtool && ./configure --prefix=$HOME && make -j install)

cd ..
rm -rf autotools_build
