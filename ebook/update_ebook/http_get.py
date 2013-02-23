import requests
url = 'http://wowebookpro.com/checkbook?key=143024416X&authKey=fapsoiu23409vxdrwl9ds0f'

r = requests.get(url)
'''
print r.status_code
print r.headers['content-type']
print r.encoding
print type(r.text)
'''
for key in r.json():
#    print key
    print key, r.json()[key]
