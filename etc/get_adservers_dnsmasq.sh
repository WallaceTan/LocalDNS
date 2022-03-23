#!/bin/sh
conffile="/etc/dnsmasq.d/adservers.conf"
listurl="https://pgl.yoyo.org/adservers/serverlist.php?hostformat=dnsmasq;showintro=0"
fetchcmd="/usr/bin/wget -q -O $conffile $listurl"

$fetchcmd
exit
