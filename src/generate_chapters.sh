#!/bin/sh
# Generates chapters.txt for ffmpeg based on mp3 files in input/
set -e
cd /input

# List mp3 files in order and handle spaces
start=0
> /tmp/chapters.txt
find . -maxdepth 1 -type f -name "*.mp3" | sort | while IFS= read -r f; do
  fname=$(basename "$f" .mp3)
  dur=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$f")
  dur_int=$(printf "%d" "${dur%.*}")
  end=$((start + dur_int))
  echo "[CHAPTER]" >> /tmp/chapters.txt
  echo "TIMEBASE=1/1" >> /tmp/chapters.txt
  echo "START=$start" >> /tmp/chapters.txt
  echo "END=$end" >> /tmp/chapters.txt
  echo "title=$fname" >> /tmp/chapters.txt
  start=$end
done
