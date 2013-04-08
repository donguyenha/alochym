import os
import shutil
from ftplib import FTP
from lxml.etree import XML, fromstring, tostring
from lxml import etree

import urllib
import json

from pysqlite2 import dbapi2 as sqlite3
conn = sqlite3.connect(r'd:\python27\hadn\alochym.db')
cursor = conn.cursor()

os.getcwd()
os.chdir(r'd:\python27\hadn')

#place all xml files into a list
result = []
for val in os.listdir('.'):
    if val.endswith('.xml'):
        result.append(val)
try:
    for val in result:
        f = open(val, 'rb')
        data = f.read()
        data = fromstring(data)		
        #print etree.tostring(data, pretty_print=True)
        isbn10 = data.xpath('//isbn/isbn-10')
		img = data.xpath('//images/item')
		print isbn10, img
except:
	pass
