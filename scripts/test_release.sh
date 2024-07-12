#!/bin/bash

repo=$HOME/workspace/libfabric
test_version="1.21.1rc1"
last_version="1.21.0"
tmp_dir=$PWD/release_tmp_dir
prebuilt_libfabric=$HOME/install
prov=tcp

cd $repo
make -j distcheck
cd fabtests
DISTCHECK_CONFIGURE_FLAGS="--with-libfabric=${prebuilt_libfabric}" make -j distcheck

mkdir -p $tmp_dir
cd $tmp_dir

wget https://github.com/ofiwg/libfabric/releases/download/v${last_version}/libfabric-${last_version}.tar.bz2
wget https://github.com/ofiwg/libfabric/releases/download/v${last_version}/fabtests-${last_version}.tar.bz2
cp ${repo}/libfabric-${test_version}.tar.bz2 .
cp ${repo}/fabtests/fabtests-${test_version}.tar.bz2 .

tar -xf libfabric-${last_version}.tar.bz2
tar -xf fabtests-${last_version}.tar.bz2
tar -xf libfabric-${test_version}.tar.bz2
tar -xf fabtests-${test_version}.tar.bz2

cd libfabric-${test_version}
./autogen.sh
./configure --prefix=$tmp_dir/${test_version}_libfabric_install
make -j install
cd ../fabtests-${test_version}
./autogen.sh
./configure --prefix=$tmp_dir/${test_version}_fabtests_install --with-libfabric=$tmp_dir/${test_version}_libfabric_install
make -j install

cd $tmp_dir

cd libfabric-${last_version}
./autogen.sh
./configure --prefix=$tmp_dir/${last_version}_libfabric_install
make -j install
cd ../fabtests-${last_version}
./autogen.sh
./configure --prefix=$tmp_dir/${last_version}_fabtests_install --with-libfabric=$tmp_dir/${last_version}_libfabric_install
make -j install

cd $tmp_dir

(
        export LD_LIBRARY_PATH=$tmp_dir/${test_version}_libfabric_install/lib
        export PATH=$tmp_dir/${test_version}_libfabric_install/bin:$tmp_dir/${test_version}_fabtests_install/bin:$PATH

        cd $tmp_dir/${test_version}_fabtests_install/share/fabtests
        runfabtests.sh $prov localhost localhost
)

rm -rf $tmp_dir/${last_version}_libfabric_install

(
        export LD_LIBRARY_PATH=$tmp_dir/${test_version}_libfabric_install/lib
        export PATH=$tmp_dir/${test_version}_libfabric_install/bin:$tmp_dir/${last_version}_fabtests_install/bin:$PATH

        cd $tmp_dir/${last_version}_fabtests_install/share/fabtests
        runfabtests.sh $prov localhost localhost
)
cd $tmp_dir/..
rm -rf $tmp_dir