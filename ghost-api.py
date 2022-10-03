#This files is a sample configuration provided by GHOST CMS developers with basic modifications made by me.

import requests # pip install requests
import jwt	# pip install pyjwt
import json
from datetime import datetime as date

#page url - Ghost CMS
ghost_url = 'https://YOUR-PAGE-NAME.COM/ghost/api/admin/posts/?source=html'

# Admin API key goes here
key = 'YOUR-API-KEY'

# Split the key into ID and SECRET
id, secret = key.split(':')

# Prepare header and payload
iat = int(date.now().timestamp())
lines = open('/your/working/directory/json.json') # <------------define json.json directory (file created with main.R script)
data = json.load(lines)


header = {'alg': 'HS256', 'typ': 'JWT', 'kid': id}
payload = {
    'iat': iat,
    'exp': iat + 5 * 60,
    'aud': '/admin/'
}

# Create the token (including decoding secret)
token = jwt.encode(payload, bytes.fromhex(secret), algorithm='HS256', headers=header)

# Make an authenticated request to create a post
url = ghost_url
headers = {'Authorization': 'Ghost {}'.format(token)}
body = data
r = requests.post(url, json=body, headers=headers)

print(r)
