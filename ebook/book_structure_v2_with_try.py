from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
from scrapy.http import Request

import datetime
import re
import book_structure as book

class WowEbook(BaseSpider):
    name = "wow"
    allowed_domains = ["wowebook.be"]
#    start_urls = ["http://www.wowebook.be/book/zk-developers-guide/"]
    def parse(self, response):
        file_name = response.url.split('/')[-2] + ".xml"
        hxs = HtmlXPathSelector(response)
        try:
            lst = hxs.select('//em/a/text()').extract()
            book.categoriesE.clear()
            for val in lst:
                tag = book.etree.Element('tag')
                tag.set('site', self.allowed_domains[0])
                tag.text = val
                book.categoriesE.append(tag)
            for val in hxs.select('//img[@class="alignleft"]').extract()[0].split('"'):
                if val.find("http") != -1:
                    book.images_itemE.text = val
            book.titleE.text = hxs.select('//title/text()').extract()[0].split('|')[0]
            book.sizeE.text = hxs.select('//pre/strong/text()').extract()[0]
            book.dl_dateE.text = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            book.post_dateE.text = hxs.select('//span[@class="date"]/text()').extract()[0]
            book.resource_urlE.text = response.url
            book.source_urlE.text = response.url
            book.resource_urlE.set("site", "www.wowebook.be")
            content = hxs.select('//div[@class="entry clearfix"]').extract()[0]
            index = content.find("Book Details")
            real_content = content[:index-4]
            book.contentE.text = re.sub(r'\n|\t','',re.sub(r'\t|\n|<a .*?>|</a>|<div .*?>|<img .*?>',"",real_content))
            isbn_count = 0
            isbn10 = 0
            isbn13 = 0
            language = 0
            release_date = 0
            page = 0
            isbn_list = hxs.select('//div[@class="entry clearfix"]/div/ul/li').extract()
            #isbn_list = hxs.select('//div[@class="entry clearfix"]/ul/li').extract()
            for val in isbn_list:
                if val.find("ISBN-10") != -1:
                    isbn10 = isbn_count
                if val.find("ISBN-13") != -1:
                    isbn13 = isbn_count
                if val.find("Language") != -1:
                    language = isbn_count
                if val.find("Publisher") != -1:
                    release_date = isbn_count
                if val.find("Paperback") != -1 or val.find("Hardcover") != -1:
                    if val.find("Paperback"):
                        book.formatE.set('type', 'Paperback')
                    else:
                        book.formatE.set('type', 'Hardcover')
                    page = isbn_count
                isbn_count = isbn_count + 1
            if release_date != 0:
                book.releaseE.text = isbn_list[release_date].split('(')[1].split(')')[0]
            if language != 0:
                book.languageE.text = isbn_list[language].split()[-1].split('<')[0]
            if page != 0:
                book.pagesE.text = isbn_list[page].split()[1]
            if isbn10 != 0:
                book.idE.text = isbn_list[isbn10].split()[-1].split('<')[0]
                book.isbn10E.text = isbn_list[isbn10].split()[-1].split('<')[0]
            if isbn13 != 0:
                book.isbn13E.text = isbn_list[isbn13].split()[-1].split('<')[0]

            book.dl_urlE.text = "http://" + hxs.select('//div[@class="entry clearfix"]/div/pre/strong/a/@href').extract()[0].split('http://')[-1] + ".html"
            book.text2E.text = hxs.select('//div[@class="entry clearfix"]/div/pre/strong/a/@title').extract()[0]
            book.textE.text = hxs.select('//div[@class="entry clearfix"]/div/pre/strong/text()').extract()[1]
            file = open(file_name, 'w')
            book.doc.write(file)
            file.close()
        except IndexError:
            book.text2E.text = hxs.select('//div[@class="entry clearfix"]/div/pre/strong/a/@title').extract()[0]
            book.dl_urlE.text = "http://" + hxs.select('//div[@class="entry clearfix"]/div/pre/strong/a/@href').extract()[0].split('http://')[-1] + ".html"
            book.textE.text = hxs.select('//div[@class="entry clearfix"]/div/pre/strong/text()').extract()[1]
            file = open(file_name, 'w')
            book.doc.write(file)
            file.close()
            file_error = open("error1.log", 'a')
            msg = response.url + ' IndexError' + '\n'
            file_error.write(msg)
            file_error.close()
        except UnboundLocalError:
            msg = response.url + ' UnboundLocalError' + '\n'
            file = open(file_name, 'w')
            book.doc.write(file)
            file.close()
            file_error = open("error1.log", 'a')
            file_error.write(msg)
            file_error.close()

    def start_requests(self):
        with open("error.log", 'rb') as urls:
            for url in urls:
                yield Request(url.split()[0], self.parse)
