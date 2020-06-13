#!/usr/bin/python
import sys
import urllib2
import urlparse
from xml.dom import minidom

def XMLGetNodeText(node):
    """
    Return text contents of an XML node.
    """
    text = []
    for childNode in node.childNodes:
        if childNode.nodeType == node.TEXT_NODE:
            text.append(childNode.data)
    return(''.join(text))

location = sys.argv[1]
expected_name = sys.argv[2]

# Fetch SCPD
response = urllib2.urlopen(location)
root_xml = minidom.parseString(response.read())
response.close()

# Construct BaseURL
base_url_elem = root_xml.getElementsByTagName('URLBase')
if base_url_elem:
    base_url = XMLGetNodeText(base_url_elem[0]).rstrip('/')
else:
    url = urlparse.urlparse(location)
    base_url = '%s://%s' % (url.scheme, url.netloc)

# Output Service info
for node in root_xml.getElementsByTagName('device'):
    device_type = XMLGetNodeText(node.getElementsByTagName('deviceType')[0])
    if device_type != "urn:metz.de:device:RemoteControlReceiver:1":
        sys.exit(1)
    friendly_name = XMLGetNodeText(node.getElementsByTagName('friendlyName')[0])
    if not friendly_name.startswith(expected_name):
        sys.exit(1)
    #print '%s %s\n' % (device_type, friendly_name)

# Output Service info
for node in root_xml.getElementsByTagName('service'):
    service_type = XMLGetNodeText(node.getElementsByTagName('serviceType')[0])
    control_url = '%s%s' % (
        base_url,
        XMLGetNodeText(node.getElementsByTagName('controlURL')[0])
    )
    scpd_url = '%s%s' % (
        base_url,
        XMLGetNodeText(node.getElementsByTagName('SCPDURL')[0])
    )
    #print '%s:\n  SCPD_URL: %s\n  CTRL_URL: %s\n' % (service_type, scpd_url, control_url)
    print '%s' % control_url
