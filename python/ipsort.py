#!/usr/bin/python
# ideas from: https://stackoverflow.com/questions/6545023/how-to-sort-ip-addresses-stored-in-dictionary-in-python

import socket
import argparse

if __name__ == '__main__':
    parser = argparse.ArgumentParser(prog='ipsort.py', description='Sort some IPs!')
    parser.add_argument("-i", help="The list of IP addresses to sort (new line delimited)")
    args = parser.parse_args()

    if (not args.i):
        print("Missing parameters!")
        parser.print_help()
        exit(-1)

    ips = []
    iplist = args.i

    try:
        with open(iplist, 'r') as lines:
            ips = [line.strip() for line in lines]
    except Exception as e:
        print("Can't read the file!")
        exit(-1)

    ips.sort(key=lambda ip: map(int, ip.split('.')))
    print('\n'.join(ips))

