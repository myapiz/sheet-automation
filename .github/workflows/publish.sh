#!/bin/bash

for file in *.xlsx; do
  echo "Uploading $file"
  echo '"'$(base64 -i $file)'"' | curl -v --data-binary @- -H "x-myapiz-key: $SHEET_API_KEY" "https://api.myapiz.com/sheet/$file"
done
