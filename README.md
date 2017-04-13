# ElucidatorRestart
Elucidator Restart Service

## Installation
Assumes apache is already setup and running on CentOS.

### Install Shiboleth
Create /etc/yum.repos.d/duke-el-shib2.repo with the following content:
```
[duke-el-shib2]
name=Shibboleth2
baseurl=http://download.opensuse.org/repositories/security://shibboleth/CentOS_CentOS-6/
enabled=1
gpgcheck=0
priority=1
```
Change the baseurl for the particular version we will use.

Install package:
```
yum install shibboleth.x86_64
```

### Setup Shiboleth
TODO

### Setup Apache
TODO

### Restart Services
```
service httpd restart && service shibd restart
```
