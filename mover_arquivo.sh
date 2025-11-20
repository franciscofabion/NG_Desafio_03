#!/bin/bash

ORIGEM="/caminho/origem"
DESTINO="/caminho/destino"

inotifywait -m -e create "$ORIGEM" |
while read caminho evento arquivo
do
    mv "$ORIGEM/$arquivo" "$DESTINO/"
done

