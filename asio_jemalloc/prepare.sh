#!/bin/bash
set -e

# install wget
apt update
apt install -y wget

# install miniforge
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh -q -O miniforge.sh
chmod u+x miniforge.sh
./miniforge.sh -b -p $HOME/miniforge3
rm -fr miniforge.sh

miniforge3/bin/conda init

# env setup
miniforge3/bin/mamba create -y --name testenv python=3.12
source /root/miniforge3/bin/activate
conda activate testenv

#install libs and tools
conda install -y libboost=1.87.0 libboost-devel libboost-headers gxx=14.2.0 jemalloc

conda list | grep boost
conda list | grep gxx

echo build without jemalloc
g++ -std=c++23 -lpthread -lboost_context -isystem /root/miniforge3/envs/testenv/include test.cpp -o test
./test

echo build with jemalloc
g++ -std=c++23 -lpthread -lboost_context -ljemalloc -isystem /root/miniforge3/envs/testenv/include test.cpp -o testj
./testj
