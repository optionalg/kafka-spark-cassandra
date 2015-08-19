#
# Cookbook Name:: spark_jobserver
# Recipe:: service
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

jobserver_user = node["jobserver"]["user"]
jobserver_group = node["jobserver"]["group"]
jobserver_dir = node["jobserver"]["dir"]

# init script for spark jobserver
template "etc/init/jobserver.conf" do
	source "jobserver.init.erb"
	owner jobserver_user
	group jobserver_group
	action :create
	mode 770
	notifies :restart, "service[jobserver]", :delayed
	variables(
		:jobserver_dir => jobserver_dir
	)
end

# Setup the jobserver service with upstart
service "jobserver" do
	provider Chef::Provider::Service::Upstart
	supports :status => true, :restart => true, :stop => true
	action :enable, :start
end
