#!/usr/bin/env bash
#Adapted from http://der-zyklop.de/blog/the-reconnection-of-vpn-profile-onsynology-nas-has-failed

echo `ifconfig ppp200` | grep -q "Link encap:Point-to-Point Protocol"
vpn=$(echo $?)
ping -c 3 google.com
pingresult=$(echo $?)
if [ "$vpn" -eq 0 -a "$pingresult" -eq 0 ]
then
    echo "VPN is running"
else
    echo conf_id=p1409382054 > /usr/syno/etc/synovpnclient/vpnc_connecting
    echo conf_name=seaa01 >> /usr/syno/etc/synovpnclient/vpnc_connecting
    echo proto=pptp >> /usr/syno/etc/synovpnclient/vpnc_connecting
    echo "VPN not running, reconnecting to seaa01"
    synovpnc reconnect --protocol=pptp --name=seaa01 --retry=3 --interval=5
fi
exit 0
