#!/bin/bash

# move unorganized files in folders
for filename in /assets/screenshots/*.png; do

  # The foldername is characters 21 to 31 from the filename (if they exist)
  # /assets/screenshots/2016-03-17 04:18:20-04:00.png  -->  2016-03-17
  foldername=$(echo "$filename" | awk '{print (substr($0, 21, 10));}');

  # if the file is not from today
  if [ "$foldername" !=  $(date +'%Y-%m-%d') ]
    then
      # create the directory
      mkdir -p /assets/screenshots/"$foldername" # -p so that we dont get "folder exists" warning
      # move the file
      mv "$filename" /assets/screenshots/"$foldername"
  fi

done

# delete everything older then a week

# reduce amount screenshots older then a day to 1 per hour
