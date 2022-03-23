#!/bin/sh

### short script that downloads a list of ad servers for use with
### dnsmasq to block ads.
###

# the ipaddress where we want to send the requests to, instead of the
# bannerservers

addcatcherip='127.0.0.4'
#configfile=/etc/dnsmasq.conf

# the args to add to the request to the yoyo server, to tell it that we want
# a hosts file and that we want to redirect to the addcatcher
listurlargs="hostformat=nohtml&showintro=0&mimetype=plaintext"

# URL of the ad server list to download
listurl="https://pgl.yoyo.org/adservers/serverlist.php?${listurlargs}"

# location of a file where hostnames not listed can be added
extrasfile='/etc/dnsmasq.d/adservers_extras_hosts.txt'
adservers_add='/etc/dnsmasq.d/adservers_add.txt'
adservers_remove='/etc/dnsmasq.d/adservers_remove.txt'

## command to reload dnsmasq - change according to your system
## not sure if we need this for dnsmasq
reloadcmd='/usr/sbin/dnsmasq --no-daemon restart'

# temp files to use
tmpfile="/etc/dnsmasq.d/adservers.tmp"
newconffile="/etc/dnsmasq.d/adservers.conf.new"
conffile="/etc/dnsmasq.d/adservers.conf"

# delete $tmpfile
echo "********************************************************************************"
echo ">>> Delete $tmpfile"
rm $tmpfile
# command to fetch the list (alternatives commented out)
fetchcmd="/usr/bin/wget -q -O $tmpfile $listurl"
echo "********************************************************************************"
echo ">>> $fetchcmd"
$fetchcmd

# add $adservers_add to $tmpfile
echo "********************************************************************************"
echo ">>> Add $adservers_add to $tmpfile"
[ -f "$adservers_add" ]  && cat $adservers_add >> $tmpfile

# check the temp file exists OK before overwriting the existing list
if  [ ! -s $tmpfile ]
then
echo "********************************************************************************"
echo ">>> temp file '$tmpfile' either doesn't exist or is empty; quitting"
exit
fi

# get a fresh list of ad server addresses for dnsmasq to refuse
#cat $configfile | grep -v "address=" > $newconffile

echo "********************************************************************************"
while read line; do
    ADDRESS="/${line}/${addcatcherip}"
    #echo "address=\"${ADDRESS}\"" >> $newconffile
    echo "address=\"${ADDRESS}\"" | tee -a $newconffile
done < <(sort $tmpfile | uniq -u)

# check the adservers_remove file exists OK before overwriting the existing list
echo "********************************************************************************"
if  [ -s $adservers_remove ]
echo ">>> Remove $adservers_add to $newconffile"
then
    while read line; do
        echo "sed -e '/${line}/ s/^#*/# /' -i $newconffile"
        sed -e "/${line}/ s/^#*\s*/# /" -i $newconffile
        # sed -e "/googletagmanager.com/ s/^#*\s*/# /" -i $newconffile && grep "googletagmanager.com" $newconffile
    done < $adservers_remove
fi

# $reloadcmd
echo "********************************************************************************"
echo ">>> Delete $tmpfile"
rm $tmpfile
echo "********************************************************************************"
echo ">>> Copy $newconffile to $conffile"
cp $newconffile $conffile
echo "********************************************************************************"
echo ">>> Delete $newconffile"
rm $newconffile
exit 0
