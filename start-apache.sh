#!/usr/bin/env bash

# Apache gets grumpy about PID files pre-existing
if [ -e /var/run/httpd/httpd.pid ]; then
  echo "Removing stale httpd.pid"
  rm -f /var/run/httpd/httpd.pid
fi

# Run apache in foreground
echo "Starting httpd"
/usr/sbin/apachectl -DFOREGROUND
