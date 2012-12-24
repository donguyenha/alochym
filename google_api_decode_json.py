import json
import urllib
"""
publisher
Wrox
description
Update to the bestseller now features the latest release of the Android platform Android is a powerful, flexible, open source platform for mobile devices and its popularity is growing at an unprecedented pace. This update to the bestselling first edition dives in to cover the exciting new features of the latest release of the Android mobile platform. Providing in-depth coverage of how to build mobile applications using the next major release of the Android SDK, this invaluable resource takes a hands-on approach to discussing Android with a series of projects, each of which introduces a new feature and highlights techniques and best practices to get the most out of Android. The Android SDK is a powerful, flexible, open source platform for mobile devices Shares helpful techniques and best practices to maximize the capabilities of Android Explains the possibilities of Android through the use of a series of detailed projects Demonstrates how to create real-world mobile applications for Android phones Includes coverage of the latest version of Android Providing concise and compelling examples, Professional Android Application Development is an updated guide aimed at helping you create mobile applications for mobile devices running the latest version of Android. Note: CD-ROM/DVD and other supplementary materials are not included as part of eBook file.
language
en
publishedDate
2010-03-01
imageLinks
{u'smallThumbnail': u'http://bks4.books.google.com/books?id=xMr2dwatvzUC&printsec=frontcover&img=1&zoom=5&source=gbs_api', u'thumbnail': u'http://bks4.books.google.com/books?id=xMr2dwatvzUC&printsec=frontcover&img=1&zoom=1&source=gbs_api'}
previewLink
http://books.google.com/books?id=xMr2dwatvzUC&dq=isbn+0470565527&hl=&cd=1&source=gbs_api
title
Professional Android 2 Application Development
printType
BOOK
pageCount
576
canonicalVolumeLink
http://books.google.com/books/about/Professional_Android_2_Application_Devel.html?hl=&id=xMr2dwatvzUC
contentVersion
preview-1.0.0
industryIdentifiers
[{u'identifier': u'0470565527', u'type': u'ISBN_10'}, {u'identifier': u'9780470565520', u'type': u'ISBN_13'}]
authors
[u'Reto Meier']
ratingsCount
11
infoLink
http://books.google.com/books?id=xMr2dwatvzUC&dq=isbn+0470565527&hl=&source=gbs_api
averageRating
3.0

"""

text = urllib.urlopen("https://www.googleapis.com/books/v1/volumes?q=isbn+0470565527&key=AIzaSyBLTw6HD8uf_EYFLfEhcSL9idaJnL4QRNI").read()

#load text Object into json Object
json_Oj = json.loads(text)

print "publisher  "
print json_Oj["items"][0]["volumeInfo"]["publisher"]
print "description  "
print json_Oj["items"][0]["volumeInfo"]["description"]
print "language  "
print json_Oj["items"][0]["volumeInfo"]["language"]
print "publishedDate  "
print json_Oj["items"][0]["volumeInfo"]["publishedDate"]
print "imageLinks  "
print json_Oj["items"][0]["volumeInfo"]["imageLinks"]
print "previewLink  "
print json_Oj["items"][0]["volumeInfo"]["previewLink"]
print "title  "
print json_Oj["items"][0]["volumeInfo"]["title"]
print "printType  "
print json_Oj["items"][0]["volumeInfo"]["printType"]
print "pageCount  "
print json_Oj["items"][0]["volumeInfo"]["pageCount"]
print "canonicalVolumeLink  "
print json_Oj["items"][0]["volumeInfo"]["canonicalVolumeLink"]
print "contentVersion  "
print json_Oj["items"][0]["volumeInfo"]["contentVersion"]
print "industryIdentifiers  "
print json_Oj["items"][0]["volumeInfo"]["industryIdentifiers"]
print "authors  "
print json_Oj["items"][0]["volumeInfo"]["authors"]
print "ratingsCount  "
print json_Oj["items"][0]["volumeInfo"]["ratingsCount"]
print "infoLink  "
print json_Oj["items"][0]["volumeInfo"]["infoLink"]
print "averageRating  "
print json_Oj["items"][0]["volumeInfo"]["averageRating"]



