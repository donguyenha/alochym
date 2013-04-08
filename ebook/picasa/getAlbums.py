import gdata
import gdata.photos.service

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
		print 'title: %s, number of photos: %s, id: %s' % (album.title.text,
			album.numphotos.text, album.gphoto_id.text)
		#print vars(album)
	return d

def main():
	email = 'alochym01@gmail.com'
	password = 'P@&&VV)RD'
	gd_client = login(email, password)
	getWebAlbums(gd_client)	

main()