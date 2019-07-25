#!/bin/sh

mkdir ./flutter/.pub-cache/
echo $GOOGLE_CREDS > ./flutter/.pub-cache/credentials.json 
./flutter/bin/flutter pub pub publish -f -v