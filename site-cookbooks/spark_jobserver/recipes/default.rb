#
# Cookbook Name:: spark_jobserver
# Recipe:: default
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

include_recipe "spark_jobserver::install"
include_recipe "spark_jobserver::config"
include_recipe "spark_jobserver::service"
