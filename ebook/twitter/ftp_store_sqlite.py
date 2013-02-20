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
	ftp = FTP('112.213.89.17')
	ftp.login('wowebookpro', '8b21fa41b135')

	ftp.cwd(r'httpdocs\import\book\source\normal')

    for val in result:
        f = open(val, 'rb')
        data = f.read()
        data = fromstring(data)		
        #print etree.tostring(data, pretty_print=True)
        isbn10 = data.xpath('//isbn/isbn-10')
        if len(isbn10[0].text) < 6:
            isbn10 = data.xpath('//isbn/isbn-13')
        if len(isbn10[0].text) > 9:
            sql = 'insert into ISBN values(' + str(isbn10[0].text) + ',"", 0, 0, 0)'
            cursor.execute(sql)
            conn.commit()
        ftp.storbinary('STOR ' + val, f)
        f.close()
        flog = open('d:\\python27\\hadn\\ftp_log.txt', 'a')
        flog.write(val + '\n')
        flog.close()
        #move uploaded files to ebook folder
        test_val = 'd:\\python27\\hadn\\' + val
        if os.path.isfile(test_val):
            shutil.move(val, 'd:\\python27\\hadn\\ebook_exist')
        else:
            shutil.move(val, 'd:\\python27\\hadn\\ebook')
    print 'ok'
    ftp.quit()
except:
    ftp.quit()
