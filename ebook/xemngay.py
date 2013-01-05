from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
from scrapy.http import Request

import re
from calendar import monthrange
import xemngay_structure as xml

class xemngay(BaseSpider):
    name = "xemngay"
    allowed_domains = ["xemngay.com"]

    def parse(self, response):
        hxs = HtmlXPathSelector(response)
        #html ==> amlich ==> truc
        xml.truc.text = hxs.select('//td[@align="left"]/a[@id="_ctl0_hypTruc"]/text()').extract()[0]

        #html ==> amlich ==> thuoc
        xml.thuoc.text = hxs.select('//td[@align="left"]/span[@id="_ctl0_lHanh"]/text()').extract()[0]

        #html ==> amlich ==> convat
        xml.convat.text = hxs.select('//td[@align="left"]/span[@id="_ctl0_lVat"]/text()').extract()[0]

        #html ==> amlich ==> sao
        xml.sao.text = hxs.select('//td[@align="left"]/a[@id="_ctl0_lSao"]/text()').extract()[0]

        xml.amlich.set('value', hxs.select('//td[@align="left"]/span[@id="_ctl0_lNhamNgay"]/b').extract()[0].split('<br>')[1].split('-')[0])

        #html ==> amlich ==> ngay
        xml.ngay1.set('value', hxs.select('//td[@align="left"]/span[@id="_ctl0_lblHD"]/b/text()').extract()[0])

        #html ==> amlich ==> Thuy Hanh
        xml.thuyhanh.set('value', hxs.select('//td[@align="left"]/span[@id="_ctl0_lblHanh"]/text()').extract()[0])

        #html ==> Ngay
        xml.ngay.text = hxs.select('//span[@id="_ctl0_lNhamNgay"]/b/text()').extract()[2]

        #html ==> Thang
        xml.thang.text = hxs.select('//span[@id="_ctl0_lNhamNgay"]/b/text()').extract()[3]

        #html ==> Nam
        xml.nam.text = hxs.select('//span[@id="_ctl0_lNhamNgay"]/b/text()').extract()[4]

        saotot = ""
        saoxau = ""
        for val in hxs.select('//a[@onmouseout="hideTip()"]').extract():
            if val.find('_hypG') != -1:
                if val.find('<b>') == -1:
                    saotot = saotot + re.sub(r'<a .*?>|</a>|<b>',"",val) + ","
                else:
                    saotot = saotot + re.sub(r'<a .*?>|</b></a>|<b>',"",val) + ","

            if val.find('_hypB') != -1:
                if val.find('<b>') == -1:
                    saoxau = saoxau + re.sub(r'<a .*?>|</a>|<b>',"",val) + ","
                else:
                    saoxau = saoxau +  re.sub(r'<a .*?>|</b></a>|<b>',"",val) + ","

            if val == hxs.select('//a[@onmouseout="hideTip()"]').extract()[-1]:
                xml.saotot.text = saotot
                xml.saoxau.text = saoxau

        #html ==> amlich ==> Mua
        if hxs.select('//td[@align="left"]/span[@id="_ctl0_lblMua"]/text()').extract() != []:
            xml.mua.set('value', hxs.select('//td[@align="left"]/span[@id="_ctl0_lblMua"]/text()').extract()[0])

        #html ==> amlich ==> NapAm
        for val in hxs.select('//td[@align="left"]/span').extract():
            if val.find('_ctl0_lblNam') != -1:
                xml.napam.set('value', val.split('">')[-1].split('<')[0])

        #html ==> bang_tot_xau ==> Tot
        text1 = ""
        for val in hxs.select('//span[@id="_ctl0_lTot"]/text()').extract():
            text1 = text1 + val
        xml.tot.text = text1

        #html ==> bang_tot_xau ==> CoThe
        text1 = ""
        for val in hxs.select('//span[@id="_ctl0_lCothe"]/text()').extract():
            text1 = text1 + val
        xml.hoitot.text = text1

        #html ==> bang_tot_xau ==> HanChe
        text1 = ""
        for val in hxs.select('//span[@id="_ctl0_lHanche"]/text()').extract():
            text1 = text1 + val
        xml.hanche.text = text1

        #html ==> bang_tot_xau ==> KhongNen
        text1 = ""
        for val in hxs.select('//span[@id="_ctl0_lKhongnen"]/text()').extract():
            text1 = text1 + val
        xml.khongnen.text = text1

        xml.khac_ngay.clear()
        for val in hxs.select('//span[@id="_ctl0_lblXKN"]/text()').extract():
            tag = xml.etree.Element('value')
            tag.text = val
            xml.khac_ngay.append(tag)

        xml.khac_thang.clear()
        for val in hxs.select('//span[@id="_ctl0_lblXKT"]/text()').extract():
            tag = xml.etree.Element('value')
            tag.text = val
            xml.khac_thang.append(tag)

        #html ==> bangtinhchat ==> Gio
        xml.gio.clear()
        for val in hxs.select('//span[@id="_ctl0_lHoangDao"]/text()').extract():
            tag = xml.etree.Element('value')
            tag.text = val
            xml.gio.append(tag)

        #html ==> bangtinhchat ==> Huong
        xml.huong.clear()
        if hxs.select('//span[@id="_ctl0_lTai"]/text()').extract() != []:
            tag = xml.etree.Element('Tai')
            tag.text = hxs.select('//span[@id="_ctl0_lTai"]/text()').extract()[0]
            xml.huong.append(tag)

        if hxs.select('//span[@id="_ctl0_lHy"]/text()').extract() != []:
            tag = xml.etree.Element('Hy')
            tag.text = hxs.select('//span[@id="_ctl0_lHy"]/text()').extract()[0]
            xml.huong.append(tag)

        if hxs.select('//span[@id="_ctl0_lAc"]/text()').extract() != []:
            tag = xml.etree.Element('Hac')
            tag.text = hxs.select('//span[@id="_ctl0_lAc"]/text()').extract()[0]
            xml.huong.append(tag)

        alochym = re.sub(r'.*d=|&key.*$',"",response.url) + ".xml"
        file = open(alochym, 'w')
        xml.doc.write(file)
        file.close()

    def start_requests(self):
        for month in range(1,13):
            if month < 10:
                month_text = "0" + str(month)
            else:
                month_text = str(month)
            for url in range(1,monthrange(2012,month)[-1]+1):
                if url < 10:
                    file_name = "0" + str(url) + month_text + "2012"
                    text = "http://www.xemngay.com/Default.aspx?blog=xngay&d=" + file_name + "&key=lich+van+nien"
                else:
                    file_name = str(url) + month_text + "2012"
                    text = "http://www.xemngay.com/Default.aspx?blog=xngay&d=" + file_name + "&key=lich+van+nien"
                yield Request(text.strip(), self.parse)
