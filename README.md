# UmbrellaLogstashPipeline

This code is an **example** of a Logstash pipeline to import Cisco Umbrella logs from S3, filter and do some enrichment, then export them to Elastisearch. There is one pipeline for each type of log (dnslogs, proxylogs, and iplogs) and they export to the same Elastisearch hosts in different indexes.

## Variables:

These are the variables that I use, getting from Secrets or system environment (not recommended)
- **AWS_ACCESS_KEY_ID**: The AWS access key to access the S3 bucket where the logs are.
- **AWS_SECRET_ACCESS_KEY**: The AWS secret key to access the S3 bucket where the logs are.
- **AWS_S3_BUCKET**: The AWS S3 bucket.
- **AWS_S3_REGION**: The AWS S3 region.
- **AWS_S3_PREFIX**: An AWS S3 "folder" prefix, like the one that Cisco-managed buckets have.
- **AWS_S3_SUFIX**: An sufix to filter logs by date, if you want to collect a specific year, month, day...
- **CUSTOMER_NAME**: Just to mark the events, in case you collect more than one customer.
- **UMBRELLA_ACCOUNT_NUMBER**: Just to mark the events, in case you collect more than one customer.
- **LOGSTASH_PATH**: The dir where you saved the scripts dir, MaxMind GeoIP2 db and ua-parser files.
- **ELASTICSEARCH_TEMPLATES_PATH**: The dir where you save the templates dir for Elasticsearch.
- **ELASTICSEARCH_HOSTS**: The Elasticsearch host or hosts to export DNS logs, comma-separated hosts. Please, use HTTPS for security!
- **ELASTICSEARCH_USER**: The username to authenticate to a secure Elasticsearch.
- **ELASTICSEARCH_PASSWORD**: The password to authenticate to a secure Elasticsearch.

## Some settings

The timezone used in custom_timestamp.rb is setted for America/Sao_Paulo. Use your timezone to create correct time-related attributes.