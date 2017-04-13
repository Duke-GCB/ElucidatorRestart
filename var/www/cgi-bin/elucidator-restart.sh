#!/usr/bin/env bash
# CGI script to create $RESTARTFILE when user POSTS
# Cron job will find $RESTARTFILE file then restart the service/update $RESTARTLOG

RESTARTFILE=/tmp/restart_elucidator.txt
RESTARTLOG=/restart_service/restart.log

function ContentType {
    echo "Content-type: text/html


"
}

function PostResponse {
    ContentType
    echo "
<html>
  <head><title>Restart Request</title></head>
  <body>
    <h1>$MSG</h1>
    <form method="get">
       <button type="submit">Back</button>
    </form>
  </body>
</html>"
}

function GetResponse {
    ContentType
    echo "
<html>
  <head><title>Restart Status</title></head>
  <body>

    <section>
       <h1>Elucidator Restart Log</h1>
       <pre>"
cat $RESTARTLOG
echo "
       </pre>
    </section>

    <section>
       <h1>Actions</h1>
       <form method="post">
          <button type="submit">Submit Restart Request</button>
       </form>
    </section>
  <body>
</html>"
}

if [ "$REQUEST_METHOD" == "POST" ]
then
    MSG=""
    if [ -e "$RESTARTFILE" ]
    then
        MSG="Restart already scheduled."
    else
        touch /tmp/restart_elucidator.txt
        MSG="Requested restart."
        echo "Restart requested by $REMOTE_USER at `date`" >> $RESTARTLOG
    fi
    PostResponse
else
    GetResponse
fi
