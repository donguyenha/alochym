from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
from scrapy.http import Request

import datetime
import re

from lxml import etree

page = etree.Element('html')
doc = etree.ElementTree(page)

metaE = etree.SubElement(page, 'meta')
resourceE = etree.SubElement(metaE, 'resource')
typeE = etree.SubElement(resourceE, 'type')
idE = etree.SubElement(resourceE, 'id')
idE.set('type', 'isbn-10')
idE.set('value', '123456789')

resource_urlE = etree.SubElement(resourceE, 'url')
resource_urlE.set('site', 'amazon.com' )
siteE = etree.SubElement(metaE, 'site')
siteE.text = 'www.wowebook.be'
sourceE = etree.SubElement(metaE, 'source')
dl_dateE = etree.SubElement(metaE, 'download-date')


bookE = etree.SubElement(page, 'book')
bookE.set('structure_version', '1')
titleE = etree.SubElement(bookE, 'title')
contentE = etree.SubElement(bookE, 'content')
imagesE = etree.SubElement(bookE, 'images')
images_itemE = etree.SubElement(imagesE, 'item')
detailsE = etree.SubElement(bookE, 'details')
releaseE = etree.SubElement(detailsE, 'release')
formatE = etree.SubElement(detailsE, 'format')
formatE.set('type', 'paperback/ebook')
pagesE = etree.SubElement(formatE, 'pages')
sizeE = etree.SubElement(formatE, 'size')
authorE = etree.SubElement(detailsE, 'author')
languageE = etree.SubElement(detailsE, 'language')
isbnE = etree.SubElement(detailsE, 'isbn')
isbn_itemE = etree.SubElement(isbnE, 'item')
isbn_item1E = etree.SubElement(isbnE, 'item')
isbn_itemE.set('type', 'ISBN-10')
isbn_itemE.set('value', '123456789')
isbn_item1E.set('type', 'ISBN-13')
isbn_item1E.set('value', 'ISBN-13-123456789')

categoriesE = etree.SubElement(bookE, 'categories')
#tagE = etree.SubElement(categoriesE, 'tag')
downloadE = etree.SubElement(bookE, 'download')
linkE = etree.SubElement(downloadE, 'link')
textE = etree.SubElement(linkE, 'text')
dl_urlE = etree.SubElement(linkE, 'url')
text2E = etree.SubElement(linkE, 'text2')

file = open('ebook.xml', 'w')
doc.write(file)
file.close()


class WowEbook(BaseSpider):
    name = "amazon"
    allowed_domains = ["wowebook.be","amazon.com"]

    def parse_amazon(self, response):
        content_data = []
        string = ""
        hxs = HtmlXPathSelector(response)
        releaseE.text = hxs.select('//div[@class="buying"]/span[@style]/text()').extract()[0]
        content_data.append(hxs.select('//div[@id="ps-content"]/h2').extract()[0])
        for val in (hxs.select('//div[@id="postBodyPS"]/div').extract()):
            content_data.append(val)
        for val in content_data:
            string = string + str(val)
        contentE.text = string
        lst = hxs.select('//div[@class="content"]/ul/li/a/text()').extract()
        for val in lst[3:]:
            tag = etree.Element('tag')
            tag.set('site', self.allowed_domains[1])
            tag.attrib['value'] = val
            categoriesE.append(tag)
        pagesE.text = hxs.select('//div[@class="content"]/ul/li/text()').extract()[0]
        languageE.text = hxs.select('//div[@class="content"]/ul/li/text()').extract()[2].strip()
        idE.attrib['value'] = hxs.select('//div[@class="content"]/ul/li/text()').extract()[3].strip()
        isbn_itemE.attrib['value']= hxs.select('//div[@class="content"]/ul/li/text()').extract()[3].strip()
        isbn_item1E.attrib['value']= hxs.select('//div[@class="content"]/ul/li/text()').extract()[4].strip()
        authorE.text = hxs.select('//div[@class="buying"]/span/a/text()').extract()[0]

        file = open('ebook.xml', 'w')
        doc.write(file)
        file.close()


    def parse(self, response):
        hxs = HtmlXPathSelector(response)
        next_url = "http://www.amazon.com/dp/" + hxs.select('//div[@class="entry clearfix"]/ul/li/text()').extract()[-2].strip()

        textE.text = hxs.select('//div[@class="entry clearfix"]/pre/strong/text()').extract()[1]
        dl_urlE.text = hxs.select('//div[@class="entry clearfix"]/pre/strong/a/@href').extract()[0] + ".html"
        text2E.text = hxs.select('//div[@class="entry clearfix"]/pre/strong/a/@title').extract()[0]
        lst = hxs.select('//em/a/text()').extract()
        for val in lst:
            tag = etree.Element('tag')
            tag.set('site', self.allowed_domains[0])
            tag.attrib['value'] = val
            categoriesE.append(tag)
        images_itemE.text = hxs.select('//img[@src]').extract()[0].split('"')[5]
        titleE.text = hxs.select('//title/text()').extract()[0].split('|')[0]
        sizeE.text = hxs.select('//pre/strong/text()').extract()[0]
        sourceE.text = response.url
        dl_dateE.text = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        resource_urlE.text = next_url
        yield Request(next_url, self.parse_amazon)

    def start_requests(self):
        with open("book_test.txt", 'rb') as urls:
            for url in urls:
                yield Request(url.strip(), self.parse)
