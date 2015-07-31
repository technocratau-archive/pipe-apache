#!/bin/bash
set -xe

if [ -n "`getent hosts | grep ' syslog '`" ];
then
  LOGGER_CMD="/usr/bin/logger -u /dev/null -n syslog -P 514 -p local7.info -t apache2"
  echo "CustomLog \"| $LOGGER_CMD\" combined" > /etc/apache2/conf-enabled/logging.conf
  echo "ErrorLog \"| $LOGGER_CMD\"" >> /etc/apache2/conf-enabled/logging.conf
else
  echo "CustomLog \"| /usr/bin/tee -a /var/log/apache2/custom.log\" combined" > /etc/apache2/conf-enabled/logging.conf
  echo "ErrorLog \"| /usr/bin/tee -a /var/log/apache2/error.log\"" >> /etc/apache2/conf-enabled/logging.conf
fi

apachectl -e info -DFOREGROUND
