#
# Cookbook Name:: postgresql_wrapper
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Object-relational SQL database, version 9.x server
include_recipe "postgresql::server"

include_recipe "postgresql::client"
