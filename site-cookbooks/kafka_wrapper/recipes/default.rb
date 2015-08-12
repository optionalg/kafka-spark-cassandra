# encoding: UTF-8
# Cookbook Name:: kafka_wrapper
# Recipe:: default
#

include_recipe "kafka_wrapper::install"
include_recipe "kafka_wrapper::configure"
include_recipe "kafka_wrapper::service"
