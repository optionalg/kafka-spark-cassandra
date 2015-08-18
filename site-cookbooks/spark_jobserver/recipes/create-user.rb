#
# Cookbook Name:: spark_jobserver
# Recipe:: create-user
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

jobserver_user = node["jobserver"]["user"]

user jobserver_user do
	comment "Spark Jobserver system user"
	system true
	action :create
end
