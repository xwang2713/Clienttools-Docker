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
IMAGE_NAME=client       # client or cleint-ee or customized
LINUX_DISTRO=ubuntu     # ubuntu or centos
BASE_NAME=client-base
BASE_TAG=8-focal              # either 8-focal or 8-el7 for hpccystemslegacy/hpcc-basey.
HPCC_VER=             # such as 8.0.0-rc1
PACKAGE_NAME=
URL_BASE=
PACKAGE_TYPE=ce        # ce or ee "ee" includes EE plugins for LN
PUSH_REPO=hpccsystemslegacy #gitlab.ins.risk.regn.net:4567/docker-images/hpccsystems

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
[[ -n ${INPUT_IMAGE_NAME} ]] && IMAGE_NAME=${INPUT_IMAGE_NAME}
[[ -n ${INPUT_PUSH_REPO} ]] && PUSH_REPO=${INPUT_PUSH_REPO}


if [[ -n ${INPUT_USERNAME} ]] ; then
  echo ${INPUT_PASSWORD} | docker login -u ${INPUT_USERNAME} --password-stdin ${INPUT_REGISTRY}
  PUSH=1
fi

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

  if ! docker pull ${DOCKER_REPO}/${IMAGE_NAME}:${HPCC_VER} ; then
    docker image build -t ${DOCKER_REPO}/${IMAGE_NAME}:${HPCC_VER} \
       --build-arg DOCKER_REPO=${DOCKER_REPO} \
       --build-arg BASE_BASE=${BASE_BASE} \
       --build-arg BASE_TAG=${BASE_TAG} \
       --build-arg PACKAGE_NAME=${PACKAGE_NAME} \
       --build-arg URL_BASE=${URL_BASE} \
       ${LINUX_DISTRO}/ 
  fi
  push_image 
}

push_image() {
  if [ "$LATEST" = "1" ] ; then
    docker tag ${PUSH_REPO}/${IMAGE_NAME}:${HPCC_VER} ${PUSH_REPO}/${IMAGE_NAME}:latest
    if [ "$PUSH" = "1" ] ; then
      docker push ${PUSH_REPO}/${IMAGE_NAME}:${HPCC_VER}
      docker push ${PUSH_REPO}/${IMAGE_NAME}:latest
    fi
  else
    if [ "$PUSH" = "1" ] ; then
      docker push ${PUSH_REPO}/${IMAGE_NAME}:${HPCC_VER}
    fi
  fi
}

build_image

if [[ -n ${INPUT_PASSWORD} ]] ; then
  echo "::set-output name=${HPCC_VER}"
  docker logout
fi
