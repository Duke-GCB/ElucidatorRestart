#!/usr/bin/env bash

# Apache gets grumpy about PID files pre-existing
if [ -e /var/run/httpd/httpd.pid ]; then
  echo "Removing stale httpd.pid"
  rm -f /var/run/httpd/httpd.pid
fi

# Remove shared memory files that prevent apache from starting
rm -f /var/run/httpd/authdigest_shm.*

# Run apache in foreground
echo "Starting httpd"
/usr/sbin/apachectl -DFOREGROUND
