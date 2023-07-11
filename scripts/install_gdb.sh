#!/bin/bash

mkdir gdb_build
cd gdb_build

mkdir gdb
mkdir texinfo

wget https://ftp.gnu.org/gnu/texinfo/texinfo-7.0.tar.gz -O texinfo.tar.gz
wget https://ftp.gnu.org/gnu/gdb/gdb-10.1.tar.gz -O gdb.tar.gz

tar -xvf gdb.tar.gz -C gdb --strip-components=1
tar -xvf texinfo .tar.gz -C texinfo --strip-components=1

(cd texinfo $$ configure --prefix=$HOME && make -j && make install)
(cd gdb && ./configure --prefix=$HOME && make -j && make install)

cd ..
rm -rf gdb_build
