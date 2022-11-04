#!/bin/bash

download_file() {
    local TMPFILE=/tmp/$(uuidgen)
    curl $1 > $TMPFILE
    MP3URL=$(cat $TMPFILE | grep mp3 | cut -d"'" -f2)
    MP3FILENAME=$(cat $TMPFILE | grep player-name | grep class | cut -d'>' -f2 | cut -d'<' -f1 | sed 's/LA VENGANZA SERA TERRIBLE ►/La Venganza sera Terrible -/g')".mp3"
    wget -nc $MP3URL -O "$MP3FILENAME"
}
export -f download_file

RSSFEED=/tmp/$(uuidgen)
wget -nc https://comunidadvengadora.com/rss/ -O $RSSFEED
cat $RSSFEED | grep cloud | cut -d'"' -f4 | xargs -n 1 -P 3 -I {} bash -c 'download_file "$@"' _ {}
