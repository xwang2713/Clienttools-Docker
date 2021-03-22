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
FROM centos:7

RUN set -ex; \
    yum update -y && yum install -y \
                epel-release          \
                wget                  \
                gcc-c++               \
                boost-regex           \
                openldap              \
                libicu                \
                m4                    \
                libtool               \
                libxslt               \
                libxml2               \
                openssh-server        \
                openssh-clients       \
                expect                \
                libarchive            \
                rsync                 \
                apr                   \
                apr-util              \
                zip                   \
                tbb                   \
                net-tools             \
                sudo                  \
                psmisc                \
                blas                  \
                atlas                 \
                which                 \
                numactl-libs          \
                numactl-devel         \
                libmemcached          \
                vim-minimal           \
                R-core                \
                java-latest-openjdk   \
                python36      \
                shiboken-python-libs  \
                centos-release-scl    \
                devtoolset-7

#RUN package-cleanup --leaves --all
#RUN mkdir -p /var/run/dbus

RUN /usr/bin/ssh-keygen -A &&  mkdir -p /var/run/sshd
COPY docker-entrypoint.sh /
COPY sleep.sh /

CMD ["/sleep.sh"]
