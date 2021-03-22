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
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get install -y -f && \
    apt-get autoremove -y && \
    apt-get update -y


RUN apt-get install -y --no-install-recommends \
		ca-certificates       \
		wget                  \
		git                   \
                libaprutil1           \
                libboost-regex1.71.0  \
                libicu66              \
                libldap-2.4-2         \
                libtbb2               \
                libnuma1              \
                libxml2               \
                libxslt1.1            \
                g++                   \
                openssh-client        \
                openssh-server        \
                expect                \
                rsync                 \
                python                \
                sudo                  \
                libblas3              \
                libatlas3-base        \
                psmisc                \
                libmemcached11        \
                libmemcachedutil2     \
                libpython3.8          \
                python3               \
                vim                   \
                dnsutils              \
                curl                  \
                libarchive13          \
                libcurl3-gnutls       \
                zip                   \
                net-tools             \
                r-base-core \
                default-jdk \
                --fix-missing         \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/dbus && mkdir -p /var/run/sshd

COPY docker-entrypoint.sh /
COPY sleep.sh /

CMD ["/sleep.sh"]
