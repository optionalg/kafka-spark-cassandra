#
# Cookbook Name:: cassandra
# Recipe:: install
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "cassandra::create-user"

cassandra_user = node["cassandra"]["user"]

apt_repository "cassandra" do
	uri "http://debian.datastax.com/community"
	components ["main"]
	distribution "stable"
	action :add
end

package "cassandra" do
	action :install
	options "--force-yes"
end

# The cassandra service will be started automatically, therefore we need to stop it
# and clear the data.
# View: http://docs.datastax.com/en/cassandra/2.2/cassandra/install/installDeb.html
service "cassandra" do
	action :stop
end

# Give to the cassandra user the required permissions
["/var/lib/cassandra",
 "/var/lib/cassandra/data", 
 "/var/lib/cassandra/data/system",
 "/var/lib/cassandra/commitlog",
 "/var/lib/cassandra/saved_caches"].each do |dir|
	directory dir do
		recursive true
		owner cassandra_user
		mode 0770
		action :create
	end
end

directory "/var/lib/cassandra/*" do
	recursive true
	action :delete
end

