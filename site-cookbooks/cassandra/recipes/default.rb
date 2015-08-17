#
# Cookbook Name:: cassandra
# Recipe:: default
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

include_recipe "cassandra::install"
include_recipe "cassandra::config"
include_recipe "cassandra::service"
