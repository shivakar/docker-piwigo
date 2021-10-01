#!/bin/bash

# Sync piwigo install files
cp -an /tmp/piwigo/* /var/www/html/

# Start supervisor
exec /usr/bin/supervisord
