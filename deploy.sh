#!/bin/sh

echo $GOOGLE_CREDS > $HOME/.pub-cache/credentials.json
./flutter/bin/flutter pub pub publish -f