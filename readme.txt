# Author: stuartaroth@gmail.com

Nagud uses perl to listen to UDP on a specific port.
UDP messages to this port are parsed and used to update passive Nagios checks.

A system can send a UDP message however it wants, but the nagud_update.pl script can be used.

Instructions:

The "nagud" file should be placed in the /usr/sbin/ directory.
An init file should be placed in the correct place.
Included are working and tested init files for RHEL and Ubuntu.

Nagios services can then be updated by sending a UDP packet with the contents:

Host Name;Service Name;Alarm Severity;Alarm Message

This can be done from the command line by using the following command:
  echo "host name;service name;alarm severity;alarm message" > /dev/udp/nagios server/nagud listening port

The scripts nagud_update.sh and nagud_update.pl can both send these packets.
