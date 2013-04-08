import gdata
import gdata.photos.service


def login(email, password):
	gd_client = gdata.photos.service.PhotosService()
	gd_client.email = 'alochym01@gmail.com'
	gd_client.password = 'P@&&VV)RD'
	gd_client.ProgrammaticLogin()
	return gd_client

def findAlbum(gd_client, title):
	albums = gd_client.GetUserFeed()
	for album in albums.entry:
		if album.title.text == title:
			return album
	return None

def main():
	email = 'alochym01@gmail.com'
	password = 'P@&&VV)RD'
	gd_client = login(email, password)
	print findAlbum(gd_client, 'wowebookpro_01')

main()