#!/bin/bash
#server side script
#called as /newdns.sh location ip zonefile

cd /etc/bind/zone/master
name=$1
ip=$2

if [ "$ip" = "" ]
then
 exit
fi

oldip=`grep $name zone.linuxbe.com | awk '{ print $5 }'`
sed -i s/$oldip/$ip/ $3

serial=$(grep serial $3 | awk '{ print $1 }')
newserial=$(($serial+1))
sed -i s/$serial/$newserial/  $3

/etc/init.d/bind9 reload
