#
# Cookbook Name:: spark
# Recipe:: create-user
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

spark_user = node[:spark][:user]
spark_group = node[:spark][:group]

user spark_user do
	comment "Spark system user"
	system true
	action :create
end
