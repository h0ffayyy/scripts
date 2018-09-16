#!/bin/bash
# CC Capture using ngrep + regex
# Listens on the specified network interface for credit card numbers,
# and logs the packets to a pcap file
#
# =========================================================================

DATE=`date +"%m%d%Y"`

startme() {
	sudo ngrep -t -W single -d eth0 "4[0-9]{12}(?:[0-9]{3})?|^5[1-5][0-9]{14}$|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|6(?:011|5[0-9]{2})[0-9]{12}|(?:2131|1800|35\d{3})\d{11}" -O /tmp/cc_cap_$DATE.pcap &>/dev/null & echo $! >> /tmp/app.pid
}

PID=`cat /tmp/app.pid`

stopme() {
	# send SIGINT to the PID of ngrep
	sudo kill -s INT $PID
	sleep 1
	sudo rm /tmp/app.pid
}

case "$1" in
	start) startme ;;
	stop) stopme ;;
	restart) stopme ; startme ;;
	*) echo "usage: $0 start|stop|restart" >&2
		exit 1
		;;
esac
