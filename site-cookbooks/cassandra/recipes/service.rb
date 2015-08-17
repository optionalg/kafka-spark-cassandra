# Cookbook Name:: cassandra
# Recipe:: service
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

# See https://supermarket.chef.io/cookbooks/monit_wrapper
include_recipe "monit_wrapper"

service "cassandra" do
	action [:enable, :start]
end
