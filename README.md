# kafka-spark-cassandra

Chef repository to install/config/execute the following servers:

* Apache Kafka
* Apache Spark
* Spark Jobserver
* Apache Cassandra

Gives support to create clusters.

# Cookbooks
This repository contains the following cookbooks (some are just wrappers):

##java-wrapper
Wrapper of the [java](https://supermarket.chef.io/cookbooks/java) cookbook to install Java 8.

##scala-wrapper
Wrapper of the [scala](https://supermarket.chef.io/cookbooks/scala) cookbook to install Scala 2.11.7.

##zookeeper-wrapper
Wrapper of the [zookeeper-cluster](https://supermarket.chef.io/cookbooks/zookeeper-cluster) cookbook to install Zookeeper 3.5.0.

##kafka
Simplified version of the [apache-kafka](https://supermarket.chef.io/cookbooks/apache_kafka) cookbook to install Kafka 0.8.2.1.

##spark
Cookbook to install Spark 1.4.1.

##spark-jobserver
Cookbook to install [Spark Jobserver](https://github.com/spark-jobserver/spark-jobserver) version 0.5.2.

##cassandra
Cookbook to install the Cassandra from the datastax stable release.

# Databags
The following databags are required:

* **zookeeper.json**: Contains all the zookeeper nodes ip. We assume they are also Kafka brokers (by default)
* **spark.json**: Constains the spark master ip and the workers ip.
* **cassandra.json**: Constains the cassandra seed servers.

**Note:** You can configure the roles to use other databags, for instance you may want to run kafka and zookeeper in separated servers.

# Roles

* **basic-servers:** just installs the java-wrapper.
* **zookeeper-cluster:** installs the zookeeper-wrapper.
* **kafka-cluster:** installs the kafka cookbook.
* **spark-cluster:** installs the spark cookbook.
* **spark-master:** starts a spark master.
* **spark-worker:** starts a spark worker.
* **spark-jobserver:** installs the spark-jobserver.
* **cassandra-cluster:** install the cassandra cookbook.

