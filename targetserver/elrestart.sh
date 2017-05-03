#!/usr/bin/env bash

RESTARTFILE=/opt/elrestart/restart_elucidator.txt
RESTARTLOG=/opt/elrestart/restart.log

CMD_ARRAY=($SSH_ORIGINAL_COMMAND)
BASE_CMD=${CMD_ARRAY[0]}
USER_NAME=${CMD_ARRAY[1]}
case "$BASE_CMD" in
        "viewlog")
                cat $RESTARTLOG
                ;;
        "restart")
                if [ -e $RESTARTFILE ]
                then
                     echo "Restart already scheduled."
                else
                     if [[ "$USER_NAME" =~ ^[0-9a-zA-Z@\.]+$ ]]
                     then
                         touch $RESTARTFILE
                         echo "Requested restart. "
                         echo "Restart requested by $USER_NAME at `date`" >> $RESTARTLOG
                     else
                         echo "Invalid user name"
                     fi
                fi
                ;;
        *)
                echo "Only these commands are available to you:"
                echo "viewlog, restart"
                exit 1
                ;;
esac
