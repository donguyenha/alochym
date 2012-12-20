from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
from scrapy.http import Request

import datetime
import re
import book_structure as book

class WowEbook(BaseSpider):
    name = "wow"
    allowed_domains = ["wowebook.be"]

    def parse(self, response):
        file_name = response.url.split('/')[-2] + ".xml"
        hxs = HtmlXPathSelector(response)
        book.textE.text = hxs.select('//div[@class="entry clearfix"]/pre/strong/text()').extract()[1]
        book.dl_urlE.text = hxs.select('//div[@class="entry clearfix"]/pre/strong/a/@href').extract()[0] + ".html"
        book.text2E.text = hxs.select('//div[@class="entry clearfix"]/pre/strong/a/@title').extract()[0]
        lst = hxs.select('//em/a/text()').extract()
        book.categoriesE.clear()
        for val in lst:
            tag = book.etree.Element('tag')
            tag.set('site', self.allowed_domains[0])
            tag.attrib['value'] = val
            book.categoriesE.append(tag)
        for val in hxs.select('//img[@src]').extract()[0].split('"'):
            if val.find("http") != -1:
                book.images_itemE.text = val
        book.titleE.text = hxs.select('//title/text()').extract()[0].split('|')[0]
        for val in hxs.select('//div[@class="entry clearfix"]/ul/li/text()').extract():
            if val.find("page") != -1:
                book.pagesE.text = val
        isbn_count = 0
        isbn_list = hxs.select('//div[@class="entry clearfix"]/ul/li').extract()
        for val in isbn_list:
            if val.find("ISBN-10") != -1:
                isbn10 = isbn_count
            if val.find("ISBN-13") != -1:
                isbn13 = isbn_count
            if val.find("Language") != -1:
                language = isbn_count
            if val.find("Publisher") != -1:
                release_date = isbn_count
            isbn_count = isbn_count + 1
        book.isbn_itemE.set('value', isbn_list[isbn10].split()[-1].split('<')[0])
        book.idE.set('value', isbn_list[isbn10].split()[-1].split('<')[0])
        book.isbn_item1E.set('value',  isbn_list[isbn13].split()[-1].split('<')[0])
        book.languageE.text = isbn_list[language].split()[-1].split('<')[0]
        book.releaseE.text = isbn_list[release_date].split('(')[1].split(')')[0]
        book.sizeE.text = hxs.select('//pre/strong/text()').extract()[0]
        book.sourceE.text = response.url
        book.dl_dateE.text = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        next_url = "http://www.amazon.com/dp/" + isbn_list[isbn10].split()[-1].split('<')[0]
        book.resource_urlE.text = response.url
        book.resource_urlE.set("site", "www.wowebook.be")
        content = hxs.select('//div[@class="entry clearfix"]').extract()[0]
        index = content.find("Book Details")
        real_content = content[:index-4]
        book.contentE.text = re.sub(r'\n|\t','',re.sub(r'\t|\n|<a .*?>|</a>|<div .*?>|<img .*?>',"",real_content))
        file = open(file_name, 'w')
        book.doc.write(file)
        print ("write to a file")
        file.close()

    def start_requests(self):
        with open("all_book.txt", 'rb') as urls:
            for url in urls:
                yield Request(url.strip(), self.parse)
