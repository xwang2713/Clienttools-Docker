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
FROM ${DOCKER_REPO}/${BASE_NAME}:${BASE_TAG}

ARG PACKAGE_NAME
ARG URL_BASE

RUN yum update -y
#RUN yum update -y &&  yum install -y \
#     R-core-devel

RUN set -ex; \
#    wget http://mysql.mirrors.hoobly.com/Downloads/MySQL-5.6/MySQL-devel-5.6.45-1.el7.x86_64.rpm; \
#    rpm -i MySQL-devel-5.6.45-1.el7.x86_64.rpm; \
#    rm -rf MySQL-devel-5.6.45-1.el7.x86_64.rpm; \
#    \
#    wget https://cran.r-project.org/src/contrib/Archive/Rcpp/Rcpp_1.0.2.tar.gz; \
#    R CMD INSTALL Rcpp_1.0.2.tar.gz; \
#    rm -rf Rcpp_1.0.2.tar.gz; \
#    \
#    wget https://cran.r-project.org/src/contrib/Archive/RInside/RInside_0.2.14.tar.gz; \
#    R CMD INSTALL RInside_0.2.14.tar.gz; \
#    rm -rf RInside_0.2.14.tar.gz; \
#    \
#    chmod u+s $(which ping); \
#    #groupadd hpcc && useradd -s /bin/bash -r -m -d /home/hpcc -g hpcc -c "hpcc Runtime User" hpcc; \
#    \
    wget  "${URL_BASE}/${PACKAGE_NAME}"; \
    #echo "$PLATFORM_DOWNLOAD_MD5 ${PACKAGE_NAME}" | md5sum -c -; \
    yum install --nogpgcheck -y "${PACKAGE_NAME}"; \
    rm -rf  "${PACKAGE_NAME}"

#RUN package-cleanup --leaves --all

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd",  "-D"]
