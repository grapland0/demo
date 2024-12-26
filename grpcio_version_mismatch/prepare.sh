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


#install grpcio-tools and test version
conda install -y grpcio-tools

conda list

conda info

PROTOC_VER_IN_LIBPROTOBUF=$(protoc --version)
PROTOC_VER_IN_GRPCIO=$(python -m grpc_tools.protoc --version)
if [ "$PROTOC_VER_IN_LIBPROTOBUF" != "$PROTOC_VER_IN_GRPCIO" ]; then
  echo "$PROTOC_VER_IN_LIBPROTOBUF (from libprotobuf) != $PROTOC_VER_IN_GRPCIO (from grpcio-tools)"
  exit 1
fi
