#!/bin/sh
# Extracts cover image from the first mp3 file in input/
set -e
cd /input
first_mp3=$(ls -1 *.mp3 | sort | head -n 1)
echo "Extracting cover from: $first_mp3"
ffmpeg -y -i "$first_mp3" -an -vcodec mjpeg -update 1 -frames:v 1 /tmp/cover.jpg || echo "No cover found"
