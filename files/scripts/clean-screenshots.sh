#!/bin/bash

# Delete everything older then a week
find /assets/screenshots -mtime +7 -exec rm -fr {} \;

# Delete all files that are not thumbs and are older then 2 days
find /assets/screenshots -maxdepth 1 ! -name "*thumb.png" -mtime +2 -exec rm -fr {} \;

# Move files in folders
for filename in /assets/screenshots/*.png ; do

  # Characters 21 to 31 from the filename
  # E.g. /assets/screenshots/2016-03-17 04:18:20-04:00.png  -->  2016-03-17
  foldername=$(echo "$filename" | awk '{print (substr($0, 21, 10));}');

  # Only if not from today
  if [ "$foldername" !=  $(date +'%Y-%m-%d') ] ; then
      # Create the directory
      mkdir -p /assets/screenshots/"$foldername" # -p so that we dont get "folder exists" $
      # Move the file
      mv "$filename" /assets/screenshots/"$foldername"
  fi

done
