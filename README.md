# ElucidatorRestart
Elucidator Restart Service

![alt text](https://github.com/Duke-GCB/ElucidatorRestart/raw/master/docs/FirstScreen.png "First Screen")
![alt text](https://github.com/Duke-GCB/ElucidatorRestart/raw/master/docs/SecomdScreen.png "Second Screen")


## Installation
Assumes apache is already setup and running on CentOS and will be secured by Duke Shiboleth/Group Manager.
Apache should have https setup. 

### Install Shiboleth
Create /etc/yum.repos.d/duke-el-shib2.repo with the following content:
```
[duke-el-shib2]
name=Shibboleth2
baseurl=http://download.opensuse.org/repositories/security://shibboleth/CentOS_5/
enabled=1
gpgcheck=0
priority=1
```
For CentOS 6 use this URL:
```
baseurl=http://download.opensuse.org/repositories/security://shibboleth/CentOS_CentOS-6/
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
cp <this repo directory>/etc/shibboleth/shibboleth2.xml /etc/shibboleth/shibboleth2.xml
```

Generate certs.
```
cd /etc/shiboleth
keygen.sh
```
Update SP with value from sp-cert.pem


### Setup Apache
Turn on UseCanonicalName in /etc/httpd/conf/httpd.conf
```
UseCanonicalName On
```

Copy elrestart.conf into apache conf.d directory.
```
cd <this repo directory>
cp etc/httpd/conf.d/elrestart.conf /etc/httpd/conf.d/elrestart.conf
```

### Restart Services
```
service httpd restart && service shibd restart
```

### Setup cron job
As root (since that user has permissions to restart the service) add a cron job.
```
crontab -e
```
Example that runs every 5 minutes:
```
*/5 * * * * <this repo directory>/check_restart.sh
```

