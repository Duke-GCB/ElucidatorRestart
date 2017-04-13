#!/usr/bin/env bash
# If $RESTARTFILE exists restart elucidator service and log to $RESTARTLOG

RESTARTFILE=/tmp/restart_elucidator.txt
RESTARTLOG=/restart_service/restart.log

SERVICENAME=httpd

if [ -e $RESTARTFILE ]
then
    echo "Restarting"
    rm -f $RESTARTFILE
    #TODO ACTUALLY RESTART SOMETHING
    echo "Restarted service $SERVICENAME at `date`" >> $RESTARTLOG
fi
