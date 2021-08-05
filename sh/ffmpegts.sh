#!/bin/bash

for file in *.ts
do
  ffmpeg -i "$file" -c copy "${file%.ts}.mp4"
  trash-put "$file"
done

