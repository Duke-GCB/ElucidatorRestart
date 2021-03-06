#!/usr/bin/env bash
# If $RESTARTFILE exists restart elucidator service and log to $RESTARTLOG

RESTARTFILE=/elrestart/watched/restart_elucidator.txt
RESTARTLOG=/elrestart/restart.log

if [ -e $RESTARTFILE ]
then
    echo "Restarting"
    rm -f $RESTARTFILE

    # Stop and start elucidator
    service rii stop
    service rii start

    echo "Restarted service elucidator at `date`" >> $RESTARTLOG
fi
