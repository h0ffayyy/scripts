#!/bin/bash
# simple script pings a list of hosts contained in a file and returns the results as passed or failed.

IPLIST=ips.txt

for ip in $(cat ${IPLIST})
do
	ping ${ip} -c 3 -W5 1> /dev/null

	if [ $? -ne 0 ]; then
		echo ${ip} ping failed;
	else
        	echo ${ip} ping passed;
	fi

done


