# Clienttools-Docker

## Base Docker Images
Currently support ubuntu (ubuntu 20.04) and centos (CentOS 7) <br/>
There is base Dockerfile on each ubuntu and centor directory. Ususally you don't need update it.  These are built and pushed to hpccsystemslegacy/client-base:[tag] on Docker Hub. The [tag] is 8-focal for Ubuntu 20.04 and 8-el7 for CentOS 7.

## Clienttools Docker Images
There are four types of Docker images you can build:
- Community Edition (CE) with Ubunntu 20.04: 
- Community Edition (CE) with CentOS 7: 
- Enterprise Edition (EE) with Ubuntu 20.04
- Enterprise Edition (EE) with CentOS 7

## Build Docker Images

### Dockerfile
There are two type of Dockerfiles:
- ubuntu/Dockerfile
- centos/Dockerfile

Both files needed input parameters to set settings. A script build.sh is provided to execute Docker build

### HPCC Systems Clienttools Linux Packages
Current builds rely on Clienttools packages. Clienttools CE builds are available both on HPCC portal and internal staging server. The EE builds are only available on internal staging server
- CE: 
  - http://d2wulyp08c6njk.cloudfront.net/releases/CE-Candidate-${VERSION_SHORT}/bin/clienttools
  - http://10.240.32.242/builds/CE-Candidate-${VERSION_SHORT}/bin/clienttools
- EE:
  - http://10.240.32.242/builds/LN-Candidate-${VERSION_SHORT}/bin/clienttools
Package name:
- Ubuntu: hpccsystems-clienttools-community_${VERION}focal_amd64.deb
- CentOS: PACKAGE_NAME="hpccsystems-clienttools-community_${VERSION}.el7.x86_64.rpm

### Build from command-line
Need necessary input parameters in buildall.sh and run 
```sh
./buildall.sh
```

### Build from github action
This should be only for Clienttools CE. Not sure Clienttools EE can be published to public site.
```sh
git clone https://github.com/<github user>/Clienttools-Docker
git tag -a community_7.12.34-1 -m "7.12.34-1"
git push origin community_7.12.34-1
```
You can chanage "community_7.12.34-1" to the other HPCC tag released <br>
By default github action will push Docker image to Docker Hub hpccsystemslegacy/clienttools<br/>
Make sure setup github projecrt secrete for Docker Hub username and password as name set in .github/workflow/build-ant-publish.yml. Current variable name:
```code
DH_USERNAME
DH_PASSWORD
```
For Clienttools EE you may publish to internal gitlab URL
such as "gitlab.ins.risk.regn.net:4567/docker-images/hpccsystems". I don't have permission and get "denied" when try to push.
