#!/usr/bin/python
import sys
import urllib2
import urlparse

# Remote control for Metz TV
# Send mecacontrol command to Metz TV
#
# Parameter: [URL] [KeyCode] [Device]

ctrl_url = sys.argv[1]

key = '1'
if len(sys.argv) > 2:
    key = sys.argv[2]
url = urlparse.urlparse(ctrl_url)
base_url = '%s://%s' % (url.scheme, url.netloc)
dest_device = '0'
if len(sys.argv) > 3:
    dest_device = sys.argv[3]

soap_body = \
    '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">\r\n' \
    '<s:Body><u:SendKeyCode xmlns:u="urn:metz.de:service:RCRService:1">\r\n' \
    '<KeyCode>%s</KeyCode>\r\n' \
    '<DestinationDevice>%s</DestinationDevice>\r\n' \
    '<ButtonHold>0</ButtonHold>\r\n' \
    '</u:SendKeyCode>\r\n' \
    '</s:Body>\r\n' \
    '</s:Envelope>\r\n\r\n' % (key, dest_device)

soap_action = "urn:metz.de:service:RCRService:1#SendKeyCode"
headers = {
    'HOST': u'%s' % url.netloc,
    'CONTENT-LENGTH': len(soap_body),
    'CONTENT-TYPE': 'text/xml; charset="utf-8"',
    'SOAPACTION': u'"%s"' % (soap_action),
}

#print headers
#print soap_body

request = urllib2.Request(ctrl_url, soap_body, headers)
response = urllib2.urlopen(request)

print response.read()

