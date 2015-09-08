#
# Cookbook Name:: lighthouse
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "lighthouse::install"
include_recipe "lighthouse::service"