#
# Cookbook Name:: cassandra
# Recipe:: create-user
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

cassandra_user = node["cassandra"]["user"]

user cassandra_user do
	comment "Cassandra system user"
	system true
	action :create
end
