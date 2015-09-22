#
# Cookbook Name:: spark
# Recipe:: config
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

spark_user  = node[:spark][:user]
spark_group = node[:spark][:group]
spark_dir   = "#{node[:spark][:install_dir]}/spark-#{node[:spark][:version]}"

spark_cluster_databag     = data_bag_item("config", node["spark"]["databag"])
cassandra_cluster_databag = data_bag_item("config", node["cassandra"]["databag"])
kafka_cluster_databag     = data_bag_item("config", node["kafka"]["databag"])

# Will use this file to setup some environment variables that will be used
# by spark jobs.
# File to setup spark environment
template  "#{spark_dir}/conf/spark-env.sh" do
  source  "spark-env.sh.erb"
  owner   spark_user
  group   spark_group
  mode    0770
  variables(
    :spark_master   => spark_cluster_databag["master"],
    :others         => node["spark"]["env"]["others"]
  )

  #notifies :restart, "service[spark_master]", :delayed
  #notifies :restart, "service[spark_worker]", :delayed
end

# File to setup spark defaults
template "#{spark_dir}/conf/spark-defaults.conf" do
  source "spark-defaults.conf.erb"
  owner spark_user
  group spark_group
  mode 0770
  variables(
    :spark_master   => spark_cluster_databag["master"],
    :kafka_hosts    => kafka_cluster_databag["nodes"].join(":9092, ") + ":9092",
    :cassandra_host => cassandra_cluster_databag["seeds"].sample,
    :others         => node[:spark][:defaults][:others]
  )

  #notifies :restart, "service[spark_master]", :delayed
  #notifies :restart, "service[spark_worker]", :delayed
end

# Script to start and stop spark master
template "/etc/init/spark_master.conf" do
  source "spark_master.init.erb"
  owner  spark_user
  group  spark_group
  action :create
  mode   0770
  variables(
    :spark_dir    => spark_dir,
    :spark_master => spark_cluster_databag["master"]
  )
  #notifies :restart, "service[spark_master]", :delayed
  #notifies :restart, "service[spark_master]", :delayed
end

# Script to start and stop spark workers
template "/etc/init/spark_worker.conf" do
  source "spark_worker.init.erb"
  owner  spark_user
  group  spark_group
  action :create
  mode   0770
  variables(
    :spark_dir    => spark_dir,
    :spark_master => spark_cluster_databag["master"]
  )
  #notifies :restart, "service[spark_worker]", :delayed
  #notifies :restart, "service[spark_worker]", :delayed
end
