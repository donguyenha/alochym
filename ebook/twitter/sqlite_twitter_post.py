import twitter
from apiclient.discovery import build
import urllib
import json
from pysqlite2 import dbapi2 as sqlite3
import requests

conn = sqlite3.connect('/home/ha/googleAPI/sqlite.db')
cursor = conn.cursor()
sql_command = 'select * from ISBN where twitter_flag = 0'
select = cursor.execute(sql_command)
lst = []
for isbn in select:
    lst.append(isbn)

for isbn in lst:
    url = 'http://wowebookpro.com/checkbook?key=' + isbn[0] + '&authKey=fapsoiu23409vxdrwl9ds0f'
    result = json.loads(urllib.urlopen(url).read())
    if result['exists']:
        api_key = 'AIzaSyBLTw6HD8uf_EYFLfEhcSL9idaJnL4QRNI'
        service = build('urlshortener', 'v1', developerKey=api_key)
        body = {'longUrl': result['url']}
        url = service.url()
        resp = url.insert(body=body).execute()
        short_url = resp['id']
        api = twitter.Api(consumer_key='7g35iNHnbyMO0LDXjEcZxQ', consumer_secret='LXnTtcmGsM12tKcdAhzqVlT4cU1WJF2i0apGvw7Cka8', access_token_key='1038804552-a2vw2I10Bc1bakRjbbdglnNAmcZmWAzbpcvuP3V', access_token_secret='awvNeULbkCvwus218fW9FUUQcXUqxBvSW7Q88bEFeX4')
        message = result['title'] + ' ebook ' + 'ISBN-10 ' + result['isbn10'] + ' ISBN-13 ' + result['isbn13'] + ' ' + short_url
        alochym = api.PostUpdate(message)
        twitter_url = 'https://twitter.com/wowebookpro/status/' + str(alochym.id)
        sql_command = 'insert into ISBN values(' + result['isbn10'] + ',' + '"' + twitter_url + '"' + ', 1, 0, 0)'
        cursor.execute(sql_command)
        conn.commit()
        url = 'http://wowebookpro.com/updatebook'
        payload = {'authKey' : 'fapsoiu23409vxdrwl9ds0f', 'Key' : result['isbn10'], 'twitterLink' : twitter_url}
        r = requests.post(url, data=payload)