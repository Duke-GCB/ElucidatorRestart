#!/usr/bin/env bash
# CGI script to view restart log and request a restart
# Assumes ELUCIDATOR_HOST has been set to the server we should ssh into

PUB_KEY_PATH=/etc/external/ssh/id_rsa
KNOWN_HOSTS_PATH=/etc/external/ssh/known_hosts
CONNECT_TIMEOUT_SEC=3

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
ssh -o ConnectTimeout=$CONNECT_TIMEOUT_SEC -o UserKnownHostsFile=$KNOWN_HOSTS_PATH -i $PUB_KEY_PATH $ELUCIDATOR_HOST viewlog
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
    MSG=$(ssh -o UserKnownHostsFile=$KNOWN_HOSTS_PATH -o ConnectTimeout=$CONNECT_TIMEOUT_SEC -i $PUB_KEY_PATH $ELUCIDATOR_HOST restart $REMOTE_USER)
    PostResponse
else
    GetResponse
fi
