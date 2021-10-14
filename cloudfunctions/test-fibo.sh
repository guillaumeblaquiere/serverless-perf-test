#!/bin/sh

echo "Be patient, it will take a while"

project=$(gcloud config get-value project)

sum="\n\nPerformance summary\n"
# Loop over the regions
for region in $(gcloud functions regions list --format="value(locationId)")
do
  echo "start querying region ${region}"

  url="https://${region}-${project}.cloudfunctions.net/test-perf-fibo"

  duration=$(curl -w "%{time_total}s" -o /dev/null -s ${url}?n=47)

  sum="${sum}\n${region}\t\t${duration}"

  echo "End of query in region ${region}. It took ${duration}"
done

echo ${sum}


