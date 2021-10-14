# Overview

Perform Cloud Functions compute performance test in all available regions.

* The Fibonacci code (in the `main.go` file) is deployed in all the available regions
* Cloud Functions are queried (`curl`) with fibonacci(47)
* Result are summarized at the end of the process

More detail on the analysis in [this article](https://medium.com/google-cloud/cloud-run-and-cloud-functions-does-the-region-change-the-performances-b967e5cee0cc)

# Prerequisite

The performance test required the following tools:

* [Gcloud SDK](https://cloud.google.com/sdk/docs/install), authenticated and with a default project selected. *This 
  default project will be used to deploy the Cloud Functions and to request them. Be sure to be `Cloud Functions admin` on this project*
* Linux compliant runtime environment.


# Deploy the test environment

Run the `deploy.sh` file located in the `cloudfunctions` folder. It will:
* Deploy the code in the `main.go` file in all the available regions in parallel
  * The Cloud Functions are deployed with 2Gb of memory  
* Wait 3 minutes at the end that all the function finish deploying in background

# Run the performance test

Run the `test-fibo.sh` file located in the `cloudfunctions` folder. It will:
* curl each Cloud Functions in the available regions. 
  * The parameter 47 is provided to allow the Cloud Functions to compute this value
* Get the curl duration as output. 
  * The computation time is long enough to hide/minimize the request latency and the cold start.
  
At the end, a summary of the request duration in each region is displayed. 


# Clean the test environment

Run the `destroy.sh` file located in the `cloudfunctions` folder. It will:
* Delete the Cloud Functions deployed in all the available regions


