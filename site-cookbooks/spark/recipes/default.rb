#
# Cookbook Name:: spark
# Recipe:: default
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

# install and configure spark
include_recipe "spark::install"
include_recipe "spark::config"