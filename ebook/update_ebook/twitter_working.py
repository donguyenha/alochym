import twitter

from apiclient.discovery import build

from lxml.etree import XML, fromstring, tostring
from lxml import etree

import urllib
import json

from pysqlite2 import dbapi2 as sqlite3

f = open('a-bug-hunters-diary.xml', 'r')
data = f.read()
f.close()

data = fromstring(data)
title = data.xpath('//title')
isbn10 = data.xpath('//item[@type="ISBN-10"]')
isbn13 = data.xpath('//item[@type="ISBN-13"]')

for val in isbn10:
    print val.attrib['value']


url = 'http://wowebookpro.com/checkbook?key=' + isbn10[0].attrib['value'] + '&authKey=fapsoiu23409vxdrwl9ds0f'

data = json.loads(urllib.urlopen(url).read())
for key in data.keys():
    print key, data[key]

#api_key from google shorten URL
api_key = 'AIzaSyBLTw6HD8uf_EYFLfEhcSL9idaJnL4QRNI'

service = build('urlshortener', 'v1', developerKey=api_key)
body = {'longUrl': data['url']}
url = service.url()
resp = url.insert(body=body).execute()
short_url = resp['id']


api = twitter.Api(consumer_key='7g35iNHnbyMO0LDXjEcZxQ', consumer_secret='LXnTtcmGsM12tKcdAhzqVlT4cU1WJF2i0apGvw7Cka8', access_token_key='1038804552-a2vw2I10Bc1bakRjbbdglnNAmcZmWAzbpcvuP3V', access_token_secret='awvNeULbkCvwus218fW9FUUQcXUqxBvSW7Q88bEFeX4')
message = title[0].text + ' ebook ' + 'ISBN-10 ' + isbn10[0].attrib['value'] + ' ISBN-13 ' + isbn13[0].attrib['value'] + ' ' + short_url
alochym = api.PostUpdate(message)
print alochym.text, alochym.id

conn = sqlite3.connect('/home/ha/googleAPI/sqlite.db')
cursor = conn.cursor()
twitter_url = 'https://twitter.com/wowebook/status/' + str(alochym.id)
isbn = str(isbn10[0].attrib['value'])
print isbn
sql_command = 'insert into ISBN values(' + isbn + ',' + '"' + twitter_url + '"' + ', 1, 0, 0)'
print sql_command
cursor.execute(sql_command)
conn.commit()
