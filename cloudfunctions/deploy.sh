#!/bin/sh

echo "Be patient, it will take a while"

# Loop over the regions
for region in $(gcloud functions regions list --format="value(locationId)")
do
  echo "start deploying region ${region}"

  gcloud functions deploy --region=${region} --memory=2048MB --runtime=go113 --allow-unauthenticated --entry-point=Fibonacci --trigger-http test-perf-fibo > /dev/null 2>&1 &

done

echo "Wait 3 minutes the end of async deployement"
sleep 180
echo "Done"