#!/bin/sh

# Loop over the regions
for region in $(gcloud run regions list | tail -n +2)
do
  echo "start deleting region ${region}"

  gcloud run services delete --quiet test-perf-fibo --region=${region} --platform=managed

  echo "end of deletion region ${region}"
done