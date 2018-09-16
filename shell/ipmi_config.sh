#!/bin/bash
# ipmi IP access control config test
# test script to modify supermicro IPMI ACL via curl

IPMI_SID=/tmp/ipmisid

# login and get SID cookie
sudo curl -k --data "name=ADMIN&pwd=ADMIN" https://10.61.4.3/cgi/login.cgi -c ${IPMI_SID}

SID_COOKIE=`cat ${IPMI_SID} | grep -oE "[a-z]{16}"`

# add a new rule

# PARAMETER DETAILS
# mode: add or delete
# ipinfo: ip address + CIDR
# policy: ACCEPT ?
# time_stamp: can be set to whatever apparently

sudo curl -k --cookie "SID=${SID_COOKIE}" --data \
"op=ip_ctrl&mode=add&ruleno=2&ipinfo=10.61.4.0%2F22&policy=ACCEPT&time_stamp=Thu%20Nov%2030%202017%2016%3A18%3A15%20GMT-0500%20(EST)" https://10.61.4.3/cgi/op.cgi

# delete temp cookie file when done
sudo rm ${IPMI_SID}
