from lxml import etree
import datetime

page = etree.Element('html')
doc = etree.ElementTree(page)
metaE = etree.SubElement(page, 'meta')
resourceE = etree.SubElement(metaE, 'resource')
typeE = etree.SubElement(resourceE, 'type')
typeE.text = 'ebook'
post_dateE = etree.SubElement(resourceE, 'post-date')
idE = etree.SubElement(resourceE, 'id')
idE.set('type', 'isbn-10')
resource_urlE = etree.SubElement(resourceE, 'url')
resource_urlE.set('site', 'www.wowebook.be' )
source_urlE = etree.SubElement(metaE, 'source-url')
source_urlE.set('site', 'www.wowebook.be')
dl_dateE = etree.SubElement(metaE, 'download-date')
dl_dateE.text = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
bookE = etree.SubElement(page, 'book')
bookE.set('structure_version', '1')
titleE = etree.SubElement(bookE, 'title')
titleE.text = "www.wowebookpro.com"
contentE = etree.SubElement(bookE, 'content')
imagesE = etree.SubElement(bookE, 'images')
images_itemE = etree.SubElement(imagesE, 'item')
images_itemE.text = "www.wowebookpro.com"
detailsE = etree.SubElement(bookE, 'details')
releaseE = etree.SubElement(detailsE, 'release')
releaseE.text = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
formatE = etree.SubElement(detailsE, 'format')
pagesE = etree.SubElement(formatE, 'pages')
pagesE.text = "0"
sizeE = etree.SubElement(formatE, 'size')
sizeE.text = "0"
authorE = etree.SubElement(detailsE, 'author')
languageE = etree.SubElement(detailsE, 'language')
languageE.text = "English"
isbnE = etree.SubElement(detailsE, 'isbn')
isbn10E = etree.SubElement(isbnE, 'isbn-10')
isbn13E = etree.SubElement(isbnE, 'isbn-13')
categoriesE = etree.SubElement(bookE, 'categories')
downloadE = etree.SubElement(bookE, 'download')
linkE = etree.SubElement(downloadE, 'link')
textE = etree.SubElement(linkE, 'text')
textE.text = "www.wowebookpro.com"
dl_urlE = etree.SubElement(linkE, 'url')
dl_urlE.text = "www.wowebookpro.com"
text2E = etree.SubElement(linkE, 'text2')
text2E.text = "www.wowebookpro.com"