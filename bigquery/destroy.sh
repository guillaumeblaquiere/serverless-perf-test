#!/bin/sh

# Loop over the regions
for region in $(cat region-list.txt)
do
  echo "start deleting region ${region}"

  dataset=$(echo ${region} | sed "s/-/_/g")

  # Create the dataset4
  bq rm -f -r ${dataset}

  echo "end of deletion region ${region}"
done