#!/bin/bash

mkdir python_build
cd python_build

wget https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz
tar -xf Python-3.9.7.tgz
(cd Python-3.9.7 && ./configure --prefix=$HOME && make -j install)

cd ..
rm -rf python_build
