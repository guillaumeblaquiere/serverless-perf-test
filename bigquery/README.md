# Overview

Perform BigQuery compute performance test in a list fo region.

* A `data.csv` file is generated with a Golang binary. 
* The data are loaded into BigQuery in each region mentioned in the `region-list.txt`
* The data are queried with a compute intensive (mathematical functions) query
* Result are summarized at the end of the process

# Prerequisite

The performance test required the following tools:

* [Golang](https://golang.org/doc/install) 
* [Gcloud SDK](https://cloud.google.com/sdk/docs/install), authenticated and with a default project selected. *This default project will be used to create the 
  BigQuery resources and to query the data. Be sure to be `BigQuery admin` on this project*
* [jq](https://stedolan.github.io/jq/download/) to parse the JSON of GCLOUD sdk 
* Linux compliant runtime environment.


# Deploy the test environment

Run the `deploy.sh` file located in the bigquery folder. It will:
* Create a `data.csv` file. Only a big number per line, 1 million of line. Go is used for this generation
* Create a dataset for each region mentioned in the `region-list.txt` file. By convention, the dataset name is the region name
* Load the `data.csv` file in each created dataset, in a table named `perf_test`

# Run the performance test

Run the `test-query.sh` file located in the bigquery folder. It will:
* Create a query for each region mentioned in the `region-list.txt` file
* Run the query in the region
* Wait the end, and get the job statistic
  
At the end, a summary of the query duration in each region is displayed. 


# Clean the test environment

Run the `destroy.sh` file located in the bigquery folder. It will:
* Delete the datasets (and the contained table) for each region mentioned in the `region-list.txt` file according to
  the naming convention (the region name)


