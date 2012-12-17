from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
from scrapy.http import Request

class DmozSpider(BaseSpider):
    name = "wowebook_all_book"
    allowed_domains = ["wowebook.be"]
    #can use www.wowebook.be/sitemap.xml
    start_urls = [
        "http://www.wowebook.be/page/1/"
    ]

    def print_value(self,list):
        myfile = open("wowebook_all_book.txt", 'a')
        for val in list:
            if val.find('#more') != -1:
                myfile.write(val + "\n")
        myfile.close()

    def parse(self, response):
        hxs = HtmlXPathSelector(response)
        #print all the book in 1 page to a file
        self.print_value(hxs.select('//a/@href').extract())
        try:
            while True:
                #get the next page to crawl
                next_url = hxs.select('//link[@rel="next"]').extract()[0].split('"')[-2]
                if not hxs.select('//link[@rel="next"]').extract():
                    yield Request(next_url, callback=self.parse)
                else:
                    break
            #crawl the last page with no next link
            yield Request(next_url, callback=self.parse)
        except IndexError:
            pass