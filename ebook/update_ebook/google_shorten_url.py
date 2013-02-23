'''
reference link : https://developers.google.com/url-shortener/v1/


creating a shorten url for posting message to twitter

the result when working properly:

{u'id': u'http://goo.gl/BwA5N',
 u'kind': u'urlshortener#url',
 u'longUrl': u'http://code.google.com/apis/urlshortener/'}

'''

from apiclient.discovery import build
api_key = 'AIzaSyBLTw6HD8uf_EYFLfEhcSL9idaJnL4QRNI'
service = build('urlshortener', 'v1', developerKey=api_key)
body = {'longUrl': 'http://code.google.com/apis/urlshortener/'}
url = service.url()
resp = url.insert(body=body).execute()
print resp['id']
