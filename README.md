# kafka-spark-cassandra

Chef repository to install/config/execute the following servers:

* Apache Kafka
* Apache Spark
* Spark Jobserver
* Apache Cassandra

# Cookbooks
This repository contains the following cookbooks (some are just wrappers):

##java-wrapper
Wrapper of the [java](https://supermarket.chef.io/cookbooks/java) cookbook to install Java 8.

##scala-wrapper
Wrapper of the [scala](https://supermarket.chef.io/cookbooks/scala) cookbook to install Scala 2.11.7.

##[zookeeper-wrapper](https://github.com/passworks/kafka-spark-cassandra/blob/master/site-cookbooks/zookeeper_wrapper)
Wrapper of the [zookeeper-cluster](https://supermarket.chef.io/cookbooks/zookeeper-cluster) cookbook to install Zookeeper 3.5.0.

##[kafka](https://github.com/passworks/kafka-spark-cassandra/blob/master/site-cookbooks/kafka_wrapper)
Simplified version of the [apache-kafka](https://supermarket.chef.io/cookbooks/apache_kafka) cookbook to install Kafka 0.8.2.1.

##[spark](https://github.com/passworks/kafka-spark-cassandra/tree/master/site-cookbooks/spark_wrapper)
Cookbook to install Spark 1.4.1.

##[spark-jobserver](https://github.com/passworks/kafka-spark-cassandra/blob/master/site-cookbooks/spark_jobserver)
Cookbook to install [Spark Jobserver](https://github.com/spark-jobserver/spark-jobserver) version 0.5.2.

##[cassandra](https://github.com/passworks/kafka-spark-cassandra/tree/master/site-cookbooks/cassandra)
Cookbook to install the Cassandra from the datastax stable release.

# Databags
## `zookeeper.json`
Contains all the zookeeper nodes ip. We assume they are also Kafka brokers.

## `spark.json`
Constains the spark master ip and the workers ip.

## `cassandra.json`
Constains the cassandra seed servers.


# Roles
## `Basic Server`
Base role for all the cluster nodes.
### Installed Cookbooks
* java_wrapper

### Sample

**`/nodes/<server-ip>.json`**

```
{
  "run_list": [
     "role[basic-server]"
  ],
  "automatic": {
    "ipaddress": "<server-ip>"
  }
}
```

## `Zookeeper Cluster`
Role for all the zookeeper nodes.
### Installed Cookbooks
* java_wrapper
* zookeeper_wrapper

### Sample
**`/nodes/<server-ip>.json`**

```
{
  "run_list": [
	"role[zookeeper-cluster]"
  ],
  "automatic": {
    "ipaddress": "<server-ip>"
  }
}
```

**`/data_bags/zookeeper.json`**

```
{
  "id": "zookeeper",
  "nodes": [
    "<server-ip>"
  ]
}
```

**Note:** You can change the databag name, and then just override the attribute `default[zookeeper-cluster][databag]` with the new name.

## `Kafka Cluster`
Role for all the Kafka brokers.
### Installed Cookbooks
* java_wrapper
* zookeeper_wrapper
* kafka

### Sample
**`/nodes/<server-ip>.json`**

```
{
  "run_list": [
	 "role[kafka-cluster]"
  ],
  "automatic": {
    "ipaddress": "<server-ip>"
  },
  "apache_kafka": {
    "broker.id": 0
  }  
}
```

**Note:** 

* The broker-id must be different for each of the cluster brokers.
* For now we assume that the kafka brokers are the same as the zookeeper nodes, so, we are using the zookeeper databag.

## `Spark Master`
Role for the spark master.
### Installed Cookbooks
* java_wrapper
* scala_wrapper
* spark

### Sample
**`/nodes/<server-ip>.json`**

```
{
  "run_list": [
  	"role[spark-master]"
  ],
  "automatic": {
    "ipaddress": "<server-ip>"
  }
}
```

**`/data_bags/spark.json`**

```
{
  "id": "spark",
  "master": "<server-ip>"
}
```

## `Spark Worker`
Role for all the spark workers. 
### Installed Cookbooks
* java_wrapper
* scala_wrapper
* spark

### Sample
**`/nodes/<server-ip>.json`**

```
{
  "run_list": [
  	"role[spark-worker]"
  ],
  "automatic": {
    "ipaddress": "<server-ip>"
  }
}
```

**`/data_bags/spark.json`**

```
{
  "id": "spark",
  "master": "<server-ip>"
}
```

## `Spark Jobserver`
Role for the spark jobserver.
### Installed Cookbooks
* java_wrapper
* scala_wrapper
* spark_jobserver

### Sample
**`/nodes/<server-ip>.json`**

```
{
  "run_list": [
  	"role[spark-jobserver]"
  ],
  "automatic": {
    "ipaddress": "<server-ip>"
  }
}
```

## `Cassandra`
Role for all the cassandra nodes.
### Installed Cookbooks
* java_wrapper
* monit_wrapper
* cassandra

### Sample
**`/nodes/<server-ip>.json`**

```
{
  "run_list": [
  	"role[cassandra-cluster]"
  ],
  "automatic": {
    "ipaddress": "<server-ip>"
  }
}
```

**`/data_bags/cassandra.conf`**

```
{
  "id": "cassandra",
  "seeds": [
    "<server-ip>"
  ]
}
```

**Note:** The `seeds` attribute must contain all the cassandra seed servers.
