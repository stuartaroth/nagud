# Author: stuartaroth@gmail.com

Nagud uses perl to listen to UDP on a specific port.
UDP messages to this port are parsed and used to update passive Nagios checks.

A system can send a UDP message however it wants, but the nagud_update.pl script can be used.