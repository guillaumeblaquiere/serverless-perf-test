#!/bin/sh

# Loop over the regions
for region in $(gcloud functions regions list --format="value(locationId)")
do
  echo "start deleting region ${region}"

  gcloud functions delete --quiet test-perf-fibo --region=${region}

  echo "end of deletion region ${region}"
done