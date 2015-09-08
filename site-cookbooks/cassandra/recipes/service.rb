# Cookbook Name:: cassandra
# Recipe:: service
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

cassandra_user  = node["cassandra"]["user"]

# init script for spark jobserver
template "etc/init/cassandra.conf" do
	source "cassandra.init.erb"
	owner cassandra_user
	action :create
	mode 770
	notifies :restart, "service[cassandra]", :delayed
	variables(
		:cassandra_user => cassandra_user
	)
end

# Setup the jobserver service with upstart
service "cassandra" do
	provider Chef::Provider::Service::Upstart
	supports :status => true, :restart => true, :stop => true
	action [:enable, :start]
end