import requests
url = 'http://wowebookpro.com/updatebook'

payload = {'authKey' : 'fapsoiu23409vxdrwl9ds0f', 'Key' : '143024416X', 'author' : 'Steffen Itterheim, Andreas Low','publisher' : 'Apress','twitterLink' : 'http://alochym.com', 'facebookLink' : 'http://alochym.com', 'googlePlusLink' : 'http://alochym.com'}

r = requests.post(url, data=payload)
print r.status_code
print r.headers['content-type']
print r.encoding
print r.text