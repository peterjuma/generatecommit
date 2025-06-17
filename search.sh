#!/bin/bash

URL="https://github.com/search?q=user%3Apeterjuma+repo%3Apeterjuma%2Fdemo&type=code"

for ((i=0; i<61; i++)); do
    curl -s -o search.out "$URL"
    sleep 1
done