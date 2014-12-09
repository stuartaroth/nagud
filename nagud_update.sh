#!/bin/bash
# echo "host name;service name;alarm severity;alarm message" > /dev/udp/nagios server/nagud listening port
echo "$1;$2;$3;$4" > /dev/udp/$5/$6
