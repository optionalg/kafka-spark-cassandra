# Cookbook Name:: cassandra
# Recipe:: service
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

# Load the databag with all the seed servers ip
bag = data_bag_item("config", node["cassandra"]["databag"])

template "/etc/cassandra/cassandra.yaml" do
	source "cassandra.yaml.erb"
	notifies :restart, "service[cassandra]", :delayed
	variables(
		:cluster_name => node["cassandra"]["cluster_name"],
		:num_tokens => node["cassandra"]["num_tokens"],
		:seeds => bag["seeds"]
	)
	action :create
end

template "/etc/cassandra/cassandra-rackdc.properties" do
	source "cassandra-rackdc.properties.erb"
	notifies :restart, "service[cassandra]", :delayed
	variables(
		:datacenter => node["cassandra"]["datacenter"],
		:rack => node["cassandra"]["rack"]
	)
	action :create
end
