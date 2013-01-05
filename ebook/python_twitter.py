#http://inventwithpython.com/blog/2012/03/25/how-to-code-a-twitter-bot-in-python-on-dreamhost/
#api doc: http://inventwithpython.com/twitter.html
from scrapy import twitter
import datetime
import re
import xemngay_structure as xml

class BookApi(BaseSpider):
    name = "twitter"
    allowed_domains = ["wowebook.be","wowebook.com","t.co","googleapis.com"]
    #start_urls = ["http://feeds.feedburner.com/XemNgayTotXau-LichVanNien?format=xml"]
    api = twitter.Api(consumer_key='F2uh9YiIvTLJRFf26uBo2g', consumer_secret='50CfOgxJiS86mgPyzhU4QeZp9jTAa9nnHy9xb2TGA', access_token_key='1024006717-sexVEPqiVQ0R4TI7sR6Db5YgjvZBEZsAL9LqHYW', access_token_secret='kfFh5b3HKOIzUvo1oFfhbRHSrIjB6iWijFTqkSZrY')
    result = api.GetSearch("wowebook", since_id=281828812327628801)
    for val in result:
        print val.text
    list = result[0].text.split('Blog: ')[-1]
