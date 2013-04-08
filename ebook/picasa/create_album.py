import gdata
import gdata.photos.service

def login(email, password):
	gd_client = gdata.photos.service.PhotosService()
	gd_client.email = 'donguyenha@gmail.com'
	gd_client.password = 'P@$$vv0rd:'
	gd_client.ProgrammaticLogin()
	return gd_client

def createAlbum(gd_client, title):
	print "Creating album " + title
	# public, private, protected. private == "anyone with link"
	album = gd_client.InsertAlbum(title=title, summary='', access='private')
	return album

def main():
	email = 'alochym01@gmail.com'
	password = 'P@&&VV)RD'
	gd_client = login(email, password)
	webAlbums = getWebAlbums(gd_client)

main()
