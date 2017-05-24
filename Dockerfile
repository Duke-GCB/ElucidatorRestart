# Runs apache and shibboleth.
# Requires a directory named 'external' to containing shibboleth data, and certs

FROM centos:7

EXPOSE 80
EXPOSE 443

# Setup so yum can install shibboleth
ADD ./duke-el-shib2.repo /etc/yum.repos.d/duke-el-shib2.repo

RUN yum -y update
RUN yum -y install epel-release wget httpd shibboleth mod_ssl openssl openssh-clients
RUN yum -y install python-pip

# Supervisor will start/monitor the apache and shibboleth processes
RUN pip install supervisor

ADD supervisord.conf /etc/supervisord.conf

# Setup apache config for restart endpoint
ADD ./etc/httpd/conf.d/elrestart.conf /etc/httpd/conf.d/elrestart.conf
ADD ./etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf

# Setup restart script to be run by apache
ADD ./var/www/cgi-bin/elucidator-restart.sh /var/www/cgi-bin/elucidator-restart.sh
RUN chown apache:apache /var/www/cgi-bin/elucidator-restart.sh
RUN chmod 500 /var/www/cgi-bin/elucidator-restart.sh

# Setup shibboleth config
ADD ./etc/shibboleth/shibboleth2.xml /etc/shibboleth/shibboleth2.xml
ADD ./etc/shibboleth/attribute-map.xml /etc/shibboleth/attribute-map.xml
RUN cd /etc/shibboleth/ && wget https://shib.oit.duke.edu/duke-metadata-2-signed.xml
RUN cd /etc/shibboleth/ && wget https://shib.oit.duke.edu/idp_signing.crt

CMD supervisord -c /etc/supervisord.conf -n
