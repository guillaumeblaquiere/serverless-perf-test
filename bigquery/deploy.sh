#!/bin/sh

echo "Be patient, it will take a while"

# Generate file
go run main.go

echo "data.csv file created"

# Loop over the regions
for region in $(cat region-list.txt)
do
  echo "start creating region ${region}"

  dataset=$(echo ${region} | sed "s/-/_/g")

  # Create the dataset
  bq mk --location ${region} ${dataset}

  # Load the data from the bucket to Big
  bq load --skip_leading_rows=1 --autodetect --source_format=CSV ${dataset}.perf_test ./data.csv

  echo "End of creation region ${region}"
done
