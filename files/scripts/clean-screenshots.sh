#!/bin/bash

# Delete everything older then a week
find /assets/screenshots -mindepth 1 -mtime +7 -exec rm -fr {} \;

# Delete all files that are not thumbs and are older then 2 days
find /assets/screenshots -mindepth 1 -maxdepth 2 ! -name "*thumb.jpg" -mtime +2 -exec rm -fr {} \;

# if the screenshots folder is not empty
if [ "$(ls -A /assets/screenshots)" ]; then

  # Move files in folders
  for filename in /assets/screenshots/*.jpg ; do

    # Characters 21 to 31 from the filename
    # E.g. /assets/screenshots/2016-03-17 04:18:20-04:00.jpg  -->  2016-03-17
    foldername=$(echo "$filename" | awk '{print (substr($0, 21, 10));}');

    # Only if not from today
    if [ "$foldername" !=  $(date +'%Y-%m-%d') ] ; then
        # Create the directory
        mkdir -p /assets/screenshots/"$foldername" # -p so that we dont get "folder exists" $
        # Move the file
        mv "$filename" /assets/screenshots/"$foldername"
    fi

  done

fi

exit 0
