#!/bin/sh

echo $GOOGLE_CREDS > ./flutter/.pub-cache/credentials.json
./flutter/bin/flutter pub pub publish -f