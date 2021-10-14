#!/bin/sh

echo "Be patient, it will take a while"

sum="\n\nPerformance summary\n"

# Loop over the regions
OFS=${IFS}
IFS="$(printf '\nx')" && IFS="${IFS%x}"
for input in $(gcloud run services list --filter=metadata.name=test-perf-fibo --format="value(labels,status.address.url)")
do
  separator=$(echo "\t")
  location=$(echo ${input} | cut -d ${separator} -f 1)
  region=$(echo ${location} | sed -e 's/cloud.googleapis.com\/location=//g')
  url=$(echo ${input} | cut -d ${separator} -f 2)

  echo "start querying url ${url} in region ${region}"

  duration=$(curl -w "%{time_total}s" -o /dev/null -s ${url}?n=47)

  sum="${sum}\n${region}\t\t${duration}"

  echo "End of query in region ${region}. It took ${duration}"
done
IFS=${OFS}
echo ${sum}


