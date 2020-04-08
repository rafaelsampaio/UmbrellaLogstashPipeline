# UmbrellaLogstashPipeline

This project is an **example** of a [Logstash](https://www.elastic.co/logstash) pipeline to import [Cisco Umbrella logs](https://docs.umbrella.com/deployment-umbrella/docs/log-formats-and-versioning) from S3, filter and do some enrichment, then export them to Elastisearch. There is one pipeline for each type of log (dnslogs, proxylogs, and iplogs) and they export to the same Elastisearch cluster into different indexes.

I tried the best to use the [Elastic Common Schema](https://www.elastic.co/guide/en/ecs/current/ecs-reference.html).

## Umbrella setup

First of all, you need to enable Umbrella logs in your policies. Please, check the docs in Cisco Umbrella User Guide:
- [Enable Logging to Your Own S3 Bucket](https://docs.umbrella.com/deployment-umbrella/docs/setting-up-an-amazon-s3-bucket) 
- [Enable Logging to a Cisco-managed S3 Bucket](https://docs.umbrella.com/deployment-umbrella/docs/cisco-managed-s3-bucket)

You're going to need AWS S3 credentials to access your S3 bucket or the credentials provided by Cisco if it is a Cisco-managed bucket.

## Logstash setup

Copy the content of this project to your Logstash dir and configure the `pipelines.yml` (usually located in `config` dir) with the pipelines. Set a variable `LOGSTASH_PATH` to point to your Logstash dir. Configure workers (`pipeline.workers`) as necessary.

```
    - pipeline.id: dnslogs
      path.config: "${LOGSTASH_PATH}/pipeline/dnslogs-pipeline.conf"
    - pipeline.id: proxylogs
      path.config: "${LOGSTASH_PATH}/pipeline/proxylogs-pipeline.conf"
    - pipeline.id: iplogs
      path.config: "${LOGSTASH_PATH}/pipeline/iplogs-pipeline.conf"
```

The output is configured to export to an Elasticsearch cluster. Set the variable `ELASTICSEARCH_HOSTS` with your server, like `https://host1:9300`. Don't forget to set the username `ELASTICSEARCH_USER` and the password `ELASTICSEARCH_PASSWORD`.

The timezone used in custom_timestamp.rb is setted for America/Sao_Paulo. Use your timezone to create correct time-related attributes.


## Variables:

These are the variables that you have to set, getting from [Secrets](https://www.elastic.co/guide/en/logstash/current/keystore.html) or system environment (not recommended):
- **AWS_ACCESS_KEY_ID**: The AWS access key to access the S3 bucket where the logs are.
- **AWS_SECRET_ACCESS_KEY**: The AWS secret key to access the S3 bucket where the logs are.
- **AWS_S3_BUCKET**: The AWS S3 bucket. If it's a Cisco managed bucket, use the content before the /.
- **AWS_S3_REGION**: The AWS S3 region.
- **AWS_S3_PREFIX**: An AWS S3 "folder" prefix. If it's Cisco-managed bucket, use the content after the / in the Data Path. If the logs are stored directly in the bucket, leave it blank.
- **AWS_S3_SUFIX**: An sufix to filter logs by date, if you want to collect a specific year, month, day...
- **CUSTOMER_NAME**: Just to mark the events, in case you collect more than one customer.
- **UMBRELLA_ACCOUNT_NUMBER**: Just to mark the events, in case you collect more than one customer.
- **LOGSTASH_PATH**: The dir where you saved the scripts dir, MaxMind GeoIP2 db and ua-parser files.
- **ELASTICSEARCH_TEMPLATES_PATH**: The dir where you save the templates dir for Elasticsearch.
- **ELASTICSEARCH_HOSTS**: The Elasticsearch host or hosts to export DNS logs, comma-separated hosts. Please, use HTTPS for security!
- **ELASTICSEARCH_USER**: The username to authenticate to a secure Elasticsearch.
- **ELASTICSEARCH_PASSWORD**: The password to authenticate to a secure Elasticsearch.
