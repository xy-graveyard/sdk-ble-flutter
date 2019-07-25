#!/bin/sh

echo $GOOGLE_CREDS > $HOME/.pub-cache/credentials.json
$HOME/flutter/bin/flutter pub pub publish -f