#
# Cookbook Name:: zookeeper_wrapper
# Recipe:: default
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

bag = data_bag_item('config', node['zookeeper-cluster']['databag'])

node.default['zookeeper-cluster']['config']['instance_name'] = node['ipaddress']
node.default['zookeeper-cluster']['config']['ensemble'] = bag['ensemble']

include_recipe 'zookeeper-cluster::default'
