# ElucidatorRestart
Elucidator Restart Service

## Installation
Assumes apache is already setup and running on CentOS and will be secured by Duke Shiboleth/Group Manager.

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
Download duke shiboleth config files.
```
cd /etc/shiboleth
wget https://shib.oit.duke.edu/duke-metadata-2-signed.xml
wget https://shib.oit.duke.edu/idp_signing.crt
```

TODO /etc/shibboleth/shibboleth.xml


### Setup Apache
Copy elrestart.conf into apache conf.d directory.
```
cd <this repo directory>
cp etc/httpd/conf.d/elrestart.conf /etc/httpd/conf.d/elrestart.conf
```

### Restart Services
```
service httpd restart && service shibd restart
```
