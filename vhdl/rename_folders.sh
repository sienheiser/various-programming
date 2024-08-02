#!/bin/bash

cd "$(pwd)" || exit

for folder in */; do
  # Check if the folder name starts with a two-digit number followed by a period
  if [[ $folder =~ ^[0-9]{2}\..* ]]; then
    # Extract the number and the rest of the folder name
    num=${folder:0:2}
    rest=${folder:2}

    # Construct the new folder name
    new_name="0${num}${rest}"

    # Rename the folder
    git mv "$folder" "$new_name"
    echo "Renamed $folder to $new_name"
  fi
done
