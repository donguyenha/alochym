import os
import json
import re
import atom
import gdata.photos.service
import requests
import urllib

def getImage(imgName):
    img = urllib.URLopener()
    url = 'http://www.wowebookpro.com/media/books/' + imgName
    path2save = '/home/ha/picasa/' + imgName
    img.retrieve(url, path2save)

def getEbookInfo(isbn):
    url = 'http://wowebookpro.com/checkbook?key=' + isbn + '&authKey=fapsoiu23409vxdrwl9ds0f'
    r = requests.get(url)
    return r.json()

def updateEbookImage(isbn,imglink):
    url = 'http://wowebookpro.com/updatebook'
    auth_Key = '"authKey" : "fapsoiu23409vxdrwl9ds0f"'
    isbn_Key = '"key" : "143024416X"'
    image_Key = '"externalImageUrl" : "' + imglink + '"'
    payload = '{' + auth_Key + ',' + isbn_Key + ',' + image_Key + '}'
    print payload
    r = requests.post(url, data=json.loads(payload))
    print r.status_code
    print r.headers['content-type']
    print r.encoding
    print r.text

def updateEbookAuthor(isbn,author):
    url = 'http://wowebookpro.com/updatebook'
    auth_Key = '"authKey" : "fapsoiu23409vxdrwl9ds0f"'
    isbn_Key = '"Key" : "143024416X"'
    author_Key = '"author" : "' + author + '"'
    payload = '{' + auth_Key + ',' + isbn_Key + ',' + author_Key + '}'
    r = requests.post(url, data=json.loads(payload))
    print r.status_code
    print r.headers['content-type']
    print r.encoding
    print r.text

def isbnlist():
    isbn = []
    f = open('/home/ha/picasa/isbn.txt')
    for line in f.readlines():
        isbn.append(re.sub('\n', '', line))
    f.close()
    return isbn

def login(email, password):
    gd_client = gdata.photos.service.PhotosService()
    gd_client.email = 'woebook.pro@gmail.com'
    gd_client.password = 'P@&&VV)RD'
    gd_client.ProgrammaticLogin()
    return gd_client

def findAlbum(gd_client, title):
    albums = gd_client.GetUserFeed()
    for album in albums.entry:
        if album.title.text == title:
            return album
    return None

def uploadPhoto(gd_client, AlbumName, path2img, imgName):
    photo = gdata.photos.PhotoEntry()
    photo.title = atom.Title(text=imgName)
    photo.summary = atom.Summary(text='', summary_type='text')
    contentType = 'image/jpg'
    gd_client.InsertPhoto(findAlbum(gd_client, AlbumName), photo, path2img, content_type=contentType)
    deleteimage(path2img)

def deleteimage(path2image):
    if os.path.isfile(path2image):
        os.remove(path2image)

def getWebAlbums(gd_client):
    albums = gd_client.GetUserFeed()
    d = {}
    for album in albums.entry:
        title = album.title.text
        if title in d:
            print "Duplicate web album:" + title
        else:
            d[title] = album
    return d

def getPhotoIdv2(gd_client, Albums, AlbumName, ImageName):
    link = ''
    photos = getWebPhotosForAlbum(gd_client, Albums[AlbumName])
    for photo in photos:
        if photo.content.src.find(ImageName) != -1:
            link = photo.content.src
            return link
    return link

def getWebPhotosForAlbum(gd_client, album):
    photos = gd_client.GetFeed('/data/feed/api/user/%s/albumid/%s?kind=photo' % (gd_client.email, album.gphoto_id.text))
    return photos.entry

def main():
    email = 'woebook.pro@gmail.com'
    password = 'P@&&VV)RD'
    gd_client = login(email, password)
    for isbn in isbnlist():
        try:
            json_val = getEbookInfo(isbn)
            img = json_val['image_url'].split('/')[-1]
            path2save = '/home/ha/picasa/' + img
            getImage(img)
            gd_client = login(email, password)
            uploadPhoto(gd_client, 'wowebookpro_01', path2save, img)
            webAlbums = getWebAlbums(gd_client)
            img_link = getPhotoIdv2(gd_client, webAlbums, 'wowebookpro_01', img)
            if img_link != '':
                updateEbookImage('143024416X',img_link.encode('utf-8'))
            print path2save
        except:
            file = open('isbn.txt', 'a')
            file.write(isbn)
            file.close
main()
