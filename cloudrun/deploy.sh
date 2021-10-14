#!/bin/sh

echo "Be patient, it will take a while"

containerName="gcr.io/$(gcloud config get-value project)/test-perf-fibo"
# Generate file
gcloud alpha builds submit --pack image=${containerName}

echo "container image created"

# Loop over the regions
for region in $(gcloud run regions list | tail -n +2)
do
  echo "start deploying region ${region}"

  gcloud run deploy --async --memory=2048MiB --region=${region} --allow-unauthenticated --image=${containerName} --platform=managed test-perf-fibo >/dev/null 2>&1 &

done

echo "Wait 1 minutes the end of async deployement"
sleep 60
echo "Done"