from lxml import etree
import datetime

page = etree.Element('html')
doc = etree.ElementTree(page)

amlich = etree.SubElement(page, 'amlich')
ngay1 = etree.SubElement(amlich, 'ngay')
truc = etree.SubElement(amlich, 'truc')
napam = etree.SubElement(amlich, 'nap_am')
thuyhanh = etree.SubElement(amlich, 'thuy_hanh')
mua = etree.SubElement(amlich, 'mua')
nhithap = etree.SubElement(amlich, 'nhi_thap_bat_tu')
sao = etree.SubElement(amlich, 'sao')
thuoc = etree.SubElement(amlich, 'thuoc')
convat = etree.SubElement(amlich, 'con_vat')

ngay = etree.SubElement(page, 'ngay')
thang = etree.SubElement(page, 'thang')
nam = etree.SubElement(page, 'nam')

bangtotxau = etree.SubElement(page, 'bang_tot_xau')
tot = etree.SubElement(bangtotxau, 'tot')
hoitot = etree.SubElement(bangtotxau, 'hoi_tot')
hanche = etree.SubElement(bangtotxau, 'han_che')
khongnen = etree.SubElement(bangtotxau, 'khong_nen')


bangtinhchat = etree.SubElement(page, 'bangtinhchat')
huong = etree.SubElement(bangtinhchat, 'huong')
gio = etree.SubElement(bangtinhchat, 'gio')
tuoi = etree.SubElement(bangtinhchat, 'tuoi')
khac_ngay = etree.SubElement(tuoi, 'khac_ngay')
khac_thang = etree.SubElement(tuoi, 'khac_thang')

bangsao = etree.SubElement(page, 'bangsao')
saotot = etree.SubElement(bangsao, 'saotot')
saoxau = etree.SubElement(bangsao, 'saoxau')


#file = open("xemngay.xml", 'w')
#doc.write(file)
#file.close()
