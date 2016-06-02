#Adapted from http://der-zyklop.de/blog/the-reconnection-of-vpn-profile-onsynology-nas-has-failed

if echo `ifconfig ppp200` | grep -q "Link encap:Point-to-Point Protocol"
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
