import re
import gdata
import gdata.photos.service
from lxml import etree

def login(email, password):
    gd_client = gdata.photos.service.PhotosService()
    gd_client.email = 'alochym01@gmail.com'
    gd_client.password = 'P@&&VV)RD'
    gd_client.ProgrammaticLogin()
    return gd_client

def getWebAlbums(gd_client):
    albums = gd_client.GetUserFeed()
    d = {}
    for album in albums.entry:
        title = album.title.text
        if title in d:
            print "Duplicate web album:" + title
        else:
            d[title] = album
        print 'title: %s, number of photos: %s, id: %s' % (album.title.text,album.numphotos.text, album.gphoto_id.text)
    return d

def getWebPhotosForAlbum(gd_client, album):
    photos = gd_client.GetFeed('/data/feed/api/user/%s/albumid/%s?kind=photo' % (gd_client.email, album.gphoto_id.text))
    return photos.entry

def getNumPhoto(gd_client, album):
    for key in album.keys():
        #print key, type(Albums[key])
        photos = getWebPhotosForAlbum(gd_client, album[key])
        for photo in photos:
            alochym = etree.fromstring(str(photo.media))
            for val in alochym:
                if val.tag.find('content') != -1:
                    j_val = str(val.attrib).split(',')[0]
                    print re.sub("{'url': ",'',j_val)

def main():
    email = 'alochym01@gmail.com'
    password = 'P@&&VV)RD'
    gd_client = login(email, password)
    webAlbums = getWebAlbums(gd_client)
    getNumPhoto(gd_client, webAlbums)

main()
