# Elucidator Restart Webserver
Serves website that allows authorized users to restart a service on a target machine.
Authentication is handled using Duke shibboleth and groupmanager.

![alt text](https://github.com/Duke-GCB/ElucidatorRestart/raw/master/docs/FirstScreen.png "First Screen")
__User Clicks "Submit Restart Request"__
![alt text](https://github.com/Duke-GCB/ElucidatorRestart/raw/master/docs/SecondScreen.png "Second Screen")

This screen will display __Restart already scheduled.__ if a user has already requested a restart that hasn't completed yet.

## Installation

### Setup for website
Install docker

Create a directory named __external__ with the following structure:
```
external/
  shibboleth/
     sp-cert.pem               # generated by /etc/shibboleth/keygen.sh
     sp-key.pem                # generated by /etc/shibboleth/keygen.sh
  ssh/
     id_rsa                    # ssh setup used to connect to machine that will restart service
     id_rsa.pub
     known_hosts
  ssl/
     restart_server.cer        # certs used by apache for https
     restart_server.key
     restart_server_interm.cer
```

Run this command to start the server:
```
docker run -p 443:443 -p 80:80 -e ELUCIDATOR_HOST=<user@targethost> -v $PWD/external:/etc/external -v $PWD/external/ssh:/usr/share/httpd/.ssh quay.io/dukegcb/elucidator-restart
```

### Setup for target machine
- Setup a user to be used when connecting.
- Add targetserver/authorized_keys to this users's .ssh directory.
- Create /opt/elrestart/ directory with appropriate permissions.
- Put targetserver/elrestart.sh in /opt/elrestart/ this is the ssh forced command that is run by the docker webserver.
- As root (since that user has permissions to restart the service) add a cron job.
Copy targetserver/check_restart into some location.
```
crontab -e
```
Example that runs every 5 minutes:
```
*/5 * * * * <somelocation>/check_restart.sh
```
