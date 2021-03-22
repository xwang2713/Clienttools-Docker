################################################################################
#    HPCC SYSTEMS software Copyright (C) 2019 HPCC Systems®.
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
################################################################################
ARG DOCKER_REPO
ARG BASE_NAME
ARG BASE_TAG
ARG PACKAGE_NAME
ARG URL_BASE
FROM ${DOCKER_REPO}/${BASE_NAME}:${BASE_TAG}


RUN set -ex; \
   apt-get update; \
   apt-get install -y  \
   wget  "${URL_BASE}/${PACKAGE_NAME}"; \
   #echo "$CLIENTTOOLS_DOWNLOAD_MD5 ${CLIENTTOOLS_PACKAGE}" | md5sum -c -; \
   dpkg -i "${PACKAGE_NAME}" ;\
   apt-get install -f ; \
   rm -rf "${PACKAGE_NAME}"

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["sleep.sh"]
