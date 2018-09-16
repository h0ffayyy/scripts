import json
import urllib
import sys
import time

# runs against virustotal api and gets all recent hostnames
url = 'https://www.virustotal.com/vtapi/v2/ip-address/report'

# take in file with list of ips
ipList = sys.argv[1]

file = open(ipList,'r')
ipFile = file.readlines()

for line in ipFile:
     # remove newlines
     line = line.strip('\n')

     # set your api key here
     parameters = {}
     parameters['ip'] = line
     parameters['apikey'] = '<API KEY HERE>'

     print parameters['ip']

     response = urllib.urlopen('%s?%s' % (url, urllib.urlencode(parameters))).read()
     response_dict = json.loads(response)

     for each in response_dict["resolutions"]:
       print each['hostname']

     time.sleep(20)
