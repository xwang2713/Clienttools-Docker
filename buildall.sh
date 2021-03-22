#!/bin/bash

# For CentOS Clienttools EE
####################################
export INPUT_HPCC_VER=7.12.34-1
export INPUT_PACKAGE_TYPE=ee
export INPUT_LINUX_DISTRO=centos
export INPUT_BASE_TAG=8-el7
# login with my account denied
#export INPUT_PUSH_REPO=gitlab.ins.risk.regn.net:4567/docker-images/hpccsystems
#export INPUT_PUSH=1


# For Ubuntu Clienttools CE
####################################
#export INPUT_HPCC_VER=7.12.34-1

./build.sh
