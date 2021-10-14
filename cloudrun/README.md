# Overview

Perform Cloud Run compute performance test in all available regions.

* The Fibonacci code (in the `main.go` file) wrapped in a webserver is deployed in all the available regions
* Cloud Run are queried (`curl`) with fibonacci(47)
* Result are summarized at the end of the process

More detail on the analysis in [this article](https://medium.com/google-cloud/cloud-run-and-cloud-run-does-the-region-change-the-performances-b967e5cee0cc)

# Prerequisite

The performance test required the following tools:

* [Gcloud SDK](https://cloud.google.com/sdk/docs/install), authenticated and with a default project selected. *This 
  default project will be used to deploy the Cloud Run and to request them. Be sure to be `Cloud Run admin` on this project*
* Linux compliant runtime environment.


# Deploy the test environment

Run the `deploy.sh` file located in the `cloudrun` folder. It will:
* Build the container with Cloud Build with Buildpack (in alpha version, be sure to have the latest gcloud SDK version)
* Deploy the container in all the available regions in parallel
  * The Cloud Run are deployed with 2Gb of memory and 1 CPU  
* Wait 1 minutes at the end that all the function finish deploying in background

# Run the performance test

Run the `test-fibo.sh` file located in the `cloudrun` folder. It will:
* curl each Cloud Run in the available regions. 
  * The parameter 47 is provided to allow the Cloud Run to compute this value
* Get the curl duration as output. 
  * The computation time is long enough to hide/minimize the request latency and the cold start.
  
At the end, a summary of the request duration in each region is displayed. 


# Clean the test environment

Run the `destroy.sh` file located in the `cloudrun` folder. It will:
* Delete the Cloud Run deployed in all the available regions


