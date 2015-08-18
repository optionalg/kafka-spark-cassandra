#
# Cookbook Name:: spark_jobserver
# Recipe:: config
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

jobserver_user = node["jobserver"]["user"]
jobserver_group = node["jobserver"]["group"]
jobserver_dir = node["jobserver"]["dir"]

# We load the spark-cluster databag in order to get the spark master
bag = data_bag_item('config', node["jobserver"]["databag"])

# jobserver.conf to setup some configurations
template "#{jobserver_dir}/jobserver.conf" do
	source "jobserver.conf.erb"
	owner jobserver_user
	group jobserver_group
	mode 770
	variables(
		:master => "spark://#{bag["master"]}:7077"
	)
end

# settings.sh to setup environment variables
template "#{jobserver_dir}/settings.sh" do
	source "settings.sh.erb"
	owner jobserver_user
	group jobserver_group
	mode 770
	variables(
		:jobserver_user => jobserver_user,
		:jobserver_group => jobserver_group,
		:jobserver_dir => jobserver_dir,
		:jobserver_log_dir => node["jobserver"]["log_dir"],
		:jobserver_pidfile => node["jobserver"]["pidfile"],
		:jobserver_memory => node["jobserver"]["memory"],
		:jobserver_spark_version => node["jobserver"]["spark_version"],
		:jobserver_spark_home => node["jobserver"]["spark_home"],
		:jobserver_spark_conf_dir => node["jobserver"]["conf_dir"],
		:jobserver_scala_version => node["jobserver"]["scala_version"]
	)
end
