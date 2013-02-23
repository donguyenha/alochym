import twitter
from apiclient.discovery import build
import urllib
import json
from pysqlite2 import dbapi2 as sqlite3

conn = sqlite3.connect('/home/ha/googleAPI/sqlite.db')
cursor = conn.cursor()
result = cursor.execute('select * from ISBN where twitter_flag=0')
try:
    lst = []
    for val in result:
        print val[0]
        lst.append(val[0])
        print type(val), val[0]
    for val in lst:
        url = 'http://wowebookpro.com/checkbook?key=' + val + '&authKey=fapsoiu23409vxdrwl9ds0f'
        data = json.loads(urllib.urlopen(url).read())
        if data['exists']:
            print data['url']
            api_key = 'AIzaSyBLTw6HD8uf_EYFLfEhcSL9idaJnL4QRNI'
            service = build('urlshortener', 'v1', developerKey=api_key)
            body = {'longUrl': data['url']}
            url = service.url()
            resp = url.insert(body=body).execute()
            short_url = resp['id']
            try:
                api = twitter.Api(consumer_key='7g35iNHnbyMO0LDXjEcZxQ', consumer_secret='LXnTtcmGsM12tKcdAhzqVlT4cU1WJF2i0apGvw7Cka8', access_token_key='1038804552-a2vw2I10Bc1bakRjbbdglnNAmcZmWAzbpcvuP3V', access_token_secret='awvNeULbkCvwus218fW9FUUQcXUqxBvSW7Q88bEFeX4')
                message = data['title'] + ' ebook ' + 'ISBN-10 ' + data['isbn10'] + ' ISBN-13 ' + data['isbn13'] + ' ' + short_url
                if len(message) > 126:
                    message = data['title'] + ' ebook ' + 'ISBN-10 ' + data['isbn10'] + ' ' + short_url
                    alochym = api.PostUpdate(message)
                else:
                    alochym = api.PostUpdate(message)
            except Exception,e:
                print str(e)
                pass
            sql_command = 'update ISBN set twitter=' + '"' + 'https://twitter.com/wowebook/status/' + str(alochym.id) + '"' + ', twitter_flag=1' + ' where isbn_10=' + '"' + val + '"'
            print sql_command
            cursor.execute(sql_command)
            conn.commit()
        else:
            print 'doesnt exists'
    cursor.close()
except Exception,e:
    cursor.close()
    print str(e)