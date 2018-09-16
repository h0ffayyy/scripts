#!/bin/bash
# grabs filter and nat table rules and formats into csv

awkcmd='
/^Chain/ {
  {printf "#############################################\n"}
  {printf "\"Chain\",\"Default Policy\"\n\"%s\",\"%s\"\n", $2, $4}
  {print "\"Number\",\"Packets\",\"Bytes\",\"Target\",\"Protocol\",\"Opt\",\"In\",\"Out\",\"Source\",\"Destination\",\"Service\""}
}
!/^Chain|pkts|^$/ {
  {printf  "\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11}
  for(i=11;i<=NF;i++) {
    printf "%s ", $i
  }
  print "\""
}
'

sudo iptables -nvL --line-numbers\
  | awk "$awkcmd" \
  > "$(hostname).iptables.csv"

sudo iptables -nvL --line-numbers -t nat\
  | awk "$awkcmd" \
  >> "$(hostname).iptables.csv"
