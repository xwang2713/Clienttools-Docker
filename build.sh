#!/bin/bash

##############################################################################
#
#    HPCC SYSTEMS software Copyright (C) 2020 HPCC Systems®.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
##############################################################################

# Build script to create and publish Docker containers corresponding to a GitHub tag
# This script is normally invoked via GitHub actions, whenever a new tag is pushed 

DOCKER_REPO=hpccsystemslegacy
LINUX_DISTRO=ubuntu     # ubuntu or centos
BASE_NAME=client-base
BASE_TAG=8-focal              # either 8-focal or 8-el7 for hpccystemslegacy/hpcc-basey.
HPCC_VER=             # such as 8.0.0-rc1
PACKAGE_NAME=
URL_BASE=
PACKAGE_TYPE=ce        # ce or ee "ee" includes EE plugins for LN

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $DIR 2>&1 > /dev/null

# These values are set in a GitHub workflow build

[[ -n ${INPUT_LINUX_DISTRO} ]] && LINUX_DISTRO=${INPUT_LINUX_DISTRO}
[[ -n ${INPUT_DOCKER_REPO} ]] && DOCKER_REPO=${INPUT_DOCKER_REPO}
[[ -n ${INPUT_HPCC_VER} ]] && HPCC_VER=${INPUT_HPCC_VER}
[[ -n ${INPUT_BASE_NAME} ]] && BASE_NAME=${INPUT_BASE_NAME}
[[ -n ${INPUT_BASE_TAG} ]] && BASE_TAG=${INPUT_BASE_TAG}
[[ -n ${INPUT_PACKAGE_TYPE} ]] && PACKAGE_TYPE=${INPUT_PACKAGE_TYPE}


#HPCC_SHORT_TAG=$(echo $BUILD_TAG | cut -d'_' -f 2)

if [[ "$INPUT_LATEST" = "1" ]] ; then
  LATEST=1
fi

export VERSION_MMP=${HPCC_VER%-*}
if [ "${PACKAGE_TYPE}" = "ce" ]
then
  PACKAGE_NAME="hpccsystems-clienttools-community_${HPCC_VER}focal_amd64.deb"
  URL_BASE="http://d2wulyp08c6njk.cloudfront.net/releases/CE-Candidate-${VERSION_MMP}/bin/clienttools"
else   # ee
  PACKAGE_NAME="hpccsystems-clienttools-internal_${HPCC_VER}.el7.x86_64.rpm" 
  URL_BASE="http://10.240.32.242/builds/LN-Candidate-${VERSION_MMP}/bin/clienttools"
fi

[[ -n ${INPUT_PACKAGE_NAME} ]] && PACKAGE_NAME=${INPUT_PACKAGE_NAME}
[[ -n ${INPUT_URL_BASE} ]] && URL_BASE=${INPUT_URL_BASE}


build_image() {
  local name=$1
  local label=$2
  [[ -z ${label} ]] && label=$BUILD_LABEL

  if ! docker pull hpccsystems/${name}:${label} ; then
    docker image build -t hpccsystems/${name}:${label} \
       --build-arg BASE_VER=${BASE_VER} \
       --build-arg DOCKER_REPO=hpccsystems \
       --build-arg BUILD_TAG=${BUILD_TAG} \
       ${name}/ 
  fi
  push_image $name $label
}

push_image() {
  local name=$1
  local label=$2
  if [ "$LATEST" = "1" ] ; then
    docker tag hpccsystems/${name}:${label} hpccsystems/${name}:latest
    if [ "$PUSH" = "1" ] ; then
      docker push hpccsystems/${name}:${label}
      docker push hpccsystems/${name}:latest
    fi
  else
    if [ "$PUSH" = "1" ] ; then
      docker push hpccsystems/${name}:${label}
    fi
  fi
}

build_image clienttools
build_image clienttools-ee

if [[ -n ${INPUT_PASSWORD} ]] ; then
  echo "::set-output name=${BUILD_LABEL}"
  docker logout
fi
