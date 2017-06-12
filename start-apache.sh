#!/usr/bin/env bash

# Apache gets grumpy about PID files pre-existing
if [ -e /var/run/apache2/apache2.pid ]; then
  echo "Removing stale apache2.pid"
  rm -f /var/run/apache2/apache2.pid
fi

# Run apache in foreground
echo "Starting httpd"
/usr/sbin/apachectl -DFOREGROUND
