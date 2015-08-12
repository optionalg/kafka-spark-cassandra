# encoding: UTF-8
# Cookbook Name:: kafka_wrapper
# Attribute:: default
#

default["kafka_wrapper"]["version"] = "0.8.2.1"
default["kafka_wrapper"]["scala_version"] = "2.11"
default["kafka_wrapper"]["mirror"] = "http://apache.mirrors.tds.net/kafka"
# shasum -a 256 /tmp/kitchen/cache/kafka_2.11-0.8.2.1.tgz
default["kafka_wrapper"]["checksum"] = "9fb84546149b477bdbf167da8ca880a2c1199aeb24b2d5cd17aac0973ba4e54b"

default["kafka_wrapper"]["user"] = "kafka"

# heap options are set low to allow for local development
default["kafka_wrapper"]["kafka_heap_opts"] = "-Xmx1G -Xms256M"

default["kafka_wrapper"]["jmx"]["port"] = ""
default["kafka_wrapper"]["jmx"]["opts"] = "-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

default["kafka_wrapper"]["install_java"] = true

default["kafka_wrapper"]["install_dir"] = "/opt/kafka"
default["kafka_wrapper"]["data_dir"] = "/var/log/kafka"
default["kafka_wrapper"]["log_dir"] = "/var/log/kafka"
#default["kafka_wrapper"]["bin_dir"] = "/usr/local/kafka/bin"
#default["kafka_wrapper"]["config_dir"] = "/usr/local/kafka/config"

default["kafka_wrapper"]["service_style"] = "upstart"

# Kafka configuration settings are detailed here.
# https://kafka.apache.org/08/configuration.html
# Required settings are specified below as they may need special handling
# by wrapper cookbooks.  All others are fixed at default levels.  This
# allows wrapper cookbooks to override a value then subsequently remove
# the override and allow the host to fall back to the default value.
default["kafka_wrapper"]["broker.id"] = nil
default["kafka_wrapper"]["port"] = 9092
default["kafka_wrapper"]["zookeeper.connect"] = nil

# Check in /var/log/kafka/server.log for invalid entries
#
default["kafka_wrapper"]["conf"]["server"] = {
  "file" => "server.properties",
  "entries" => {
    ## Settings are set to defaults by kafka but can be optionally
    ## overridden in the server.properties file such as bumping the default
    ## replication factor from 1 to 2 with:
    # "default.replication.factor" => 2,
    #
    # For a full list reference kafka's config documentation

    "num.network.threads" => 3,
    "num.io.threads" => 8,
    #"socket.send.buffer.bytes" => 102400,
    #"socket.receive.buffer.bytes" => 102400,
    #"socket.request.max.bytes" => 104857600,
    "num.partitions" => 1,
    "num.recovery.threads.per.data.dir" => 1,
    "log.retention.hours" => 96,
    #"log.segment.bytes" => 1073741824,
    #"log.retention.check.interval.ms" => 300000,
    "log.cleaner.enable" => "true",
    "zookeeper.connection.timeout.ms" => 6000,
    "log.dirs" => node["kafka_wrapper"]["data_dir"],
    "delete.topic.enable" => "false" 
  }
}

default["kafka_wrapper"]["conf"]["log4j"] = {
  "file" => "log4j.properties",
  "entries" => {
    "log4j.additivity.kafka.controller" => "false",
    "log4j.additivity.kafka.log.LogCleaner" => "false",
    "log4j.additivity.kafka.network.RequestChannel$" => "false",
    "log4j.additivity.kafka.request.logger" => "false",
    "log4j.additivity.state.change.logger" => "false",
    "log4j.appender.cleanerAppender.DatePattern" => "'.'yyyy-MM-dd-HH",
    "log4j.appender.cleanerAppender.File" => "log-cleaner.log",
    "log4j.appender.cleanerAppender.layout.ConversionPattern" => "[%d] %p %m (%c)%n",
    "log4j.appender.cleanerAppender.layout" => "org.apache.log4j.PatternLayout",
    "log4j.appender.cleanerAppender" => "org.apache.log4j.DailyRollingFileAppender",
    "log4j.appender.controllerAppender.DatePattern" => "'.'yyyy-MM-dd-HH",
    "log4j.appender.controllerAppender.File" => "${kafka.logs.dir}/controller.log",
    "log4j.appender.controllerAppender.layout.ConversionPattern" => "[%d] %p %m (%c)%n",
    "log4j.appender.controllerAppender.layout" => "org.apache.log4j.PatternLayout",
    "log4j.appender.controllerAppender" => "org.apache.log4j.DailyRollingFileAppender",
    "log4j.appender.kafkaAppender.DatePattern" => "'.'yyyy-MM-dd-HH",
    "log4j.appender.kafkaAppender.File" => "${kafka.logs.dir}/server.log",
    "log4j.appender.kafkaAppender.layout.ConversionPattern" => "[%d] %p %m (%c)%n",
    "log4j.appender.kafkaAppender.layout" => "org.apache.log4j.PatternLayout",
    "log4j.appender.kafkaAppender" => "org.apache.log4j.DailyRollingFileAppender",
    "log4j.appender.requestAppender.DatePattern" => "'.'yyyy-MM-dd-HH",
    "log4j.appender.requestAppender.File" => "${kafka.logs.dir}/kafka-request.log",
    "log4j.appender.requestAppender.layout.ConversionPattern" => "[%d] %p %m (%c)%n",
    "log4j.appender.requestAppender.layout" => "org.apache.log4j.PatternLayout",
    "log4j.appender.requestAppender" => "org.apache.log4j.DailyRollingFileAppender",
    "log4j.appender.stateChangeAppender.DatePattern" => "'.'yyyy-MM-dd-HH",
    "log4j.appender.stateChangeAppender.File" => "${kafka.logs.dir}/state-change.log",
    "log4j.appender.stateChangeAppender.layout.ConversionPattern" => "[%d] %p %m (%c)%n",
    "log4j.appender.stateChangeAppender.layout" => "org.apache.log4j.PatternLayout",
    "log4j.appender.stateChangeAppender" => "org.apache.log4j.DailyRollingFileAppender",
    "log4j.appender.stdout.layout.ConversionPattern" => "[%d] %p %m (%c)%n",
    "log4j.appender.stdout.layout" => "org.apache.log4j.PatternLayout",
    "log4j.appender.stdout" => "org.apache.log4j.ConsoleAppender",
    "log4j.logger.kafka.controller" => "TRACE, controllerAppender",
    "log4j.logger.kafka" => "INFO, kafkaAppender",
    "log4j.logger.kafka.log.LogCleaner" => "INFO, cleanerAppender",
    "log4j.logger.kafka.network.RequestChannel$" => "WARN, requestAppender",
    "log4j.logger.kafka.request.logger" => "WARN, requestAppender",
    "log4j.logger.state.change.logger" => "TRACE, stateChangeAppender",
    "log4j.rootLogger" => "WARN, stdout "
  }
}
