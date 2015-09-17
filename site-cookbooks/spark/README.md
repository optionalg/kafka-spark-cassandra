# Spark Cookbook

## Recipes
* `default` - Install and configure a Spark node.
* `install` - Install Spark
* `config` - Configure Spark
* `server` - Starts a Spark master.
* `worker` - Starts a Spark worker.
* `create-user` - Creates the Spark system user.

## Attributes
* `default[:spark][:user]` - The system user (defaults to spark)
* `default[:spark][:group]` - The system user group (defaults to spark)
* `default[:spark][:version]` - The spark version that will be downloaded (defaults to 1.4.1)
* `default[:spark][:download_url]` - URL to download spark compiled version (make sure it's compiled with the right java and scala version)
* `default[:spark][:install_dir]` - The directory path where spark will be installed (defaults to /opt/spark)
* `default[:spark][:env][:others]` - Hash with some aditional options for spark-env.sh
* `default[:spark][:defaults][:others]` - Hash with some aditional options fo spark-defaults.conf
* `default[:cassandra-cluster][:databag]` - The name of the databag with all cassandra seed servers (defaults to cassandra)
* `default[:spark][:databag]` - The name of the databag with the spark master hostname (defaults to spark).
* `default[:cassandra][:databag]` - The name of the databag with the cassandra seeds hostname (defaults to cassandra).
* `default[:kafka][:databag]` - The name of the databag with the kafka brockers hostname (defaults to zookeeper).

## Required Databags
## cassandra
Here's a sample of this databag:

```
{
  "id": "cassandra",
  "seeds": [
    "aaa.aaa.aaa.aaa"
  ]
}
```

**seeds -** The hostname of each cassandra seed server.

## spark

Here's a sample of this databag:

```
{
  "id": "spark",
  "master": "bbb.bbb.bbb.bbb",
}
```

**master -** The hostname of the spark master.

## kafka

Here's a sample of this databag:

```
{
  "id": "kafka",
  "nodes": ["bbb.bbb.bbb.bbb"]
}

## TODO
* Talk about the template files, the properties and how the server will be configured.
* Add security options.
* Give a sample to setup a spark cluster with 1 master and 3 workers.