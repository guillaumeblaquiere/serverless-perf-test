#!/bin/sh

echo "Be patient, it will take a while"

BASE_QUERY="""
SELECT cos(random_number),sin(random_number), tan(random_number),
 acos(mod(random_number,2)),asin(mod(random_number,2)), atan(mod(random_number,3) - 1.5),
 cosh(mod(random_number,100)),sinh(mod(random_number,99)), tanh(mod(random_number,98)),
 acosh(mod(random_number,10)+1),asinh(mod(random_number,11)), atanh((mod(random_number,11)-0.1)/random_number),
 pow(random_number,rand()), sqrt(random_number), exp(mod(random_number,97)), ln(random_number) FROM
"""

sum="\n\nPerformance summary\n"
# Loop over the regions
for region in $(cat region-list.txt)
do
  echo "start querying region ${region}"

  dataset=$(echo ${region} | sed "s/-/_/g")
  # Run the query
  query="${BASE_QUERY} ${dataset}.perf_test"
  job_id=$(date '+%s')
  bq --job_id=${job_id} query -n 0 --nouse_cache --nouse_legacy_sql "${query}"

  # Get job start and end time and print the result
  end=$(bq --location ${region} --format=json show --job=true ${job_id} | jq .statistics.endTime | sed "s/\"//g")
  start=$(bq --location ${region} --format=json show --job=true ${job_id} | jq .statistics.startTime | sed "s/\"//g")
  diff=$(echo $(( ${end} - ${start} )))
  diffInS=$(echo $(( ${diff} / 1000 )))

  sum="${sum}\n${region}\t\t${diff}ms\t(${diffInS}s)"

  echo "End of query in region ${region}. It took ${diff}ms (${diffInS}s)"
done

echo ${sum}
