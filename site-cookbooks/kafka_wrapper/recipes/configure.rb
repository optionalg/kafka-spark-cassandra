# encoding: UTF-8
# Cookbook Name:: kafka_wrapper
# Recipe:: configure
#

version_tag = "kafka_#{node["kafka_wrapper"]["scala_version"]}-#{node["kafka_wrapper"]["version"]}"

[
  "#{node['kafka_wrapper']['install_dir']}/#{version_tag}/logs",
  node["kafka_wrapper"]["data_dir"],
  node["kafka_wrapper"]["log_dir"],
].each do |dir|
  directory dir do
    recursive true
    owner node["kafka_wrapper"]["user"]
  end
end

broker_id = node["kafka_wrapper"]["broker.id"]
broker_id = 0 if broker_id.nil?

config_dir = "#{node['kafka_wrapper']['install_dir']}/#{version_tag}/config"
bin_dir = "#{node['kafka_wrapper']['install_dir']}/#{version_tag}/bin"

bag = data_bag_item('config', node["zookeeper-cluster"]["databag"])

template ::File.join(config_dir,
                     node["kafka_wrapper"]["conf"]["server"]["file"]) do
  source "properties/server.properties.erb"
  owner "kafka"
  action :create
  mode "0644"
  variables(
    :broker_id => broker_id,
    :port => node["kafka_wrapper"]["port"],
    :zookeeper_connect => bag['ensemble'].map { |m| "#{m}:2181"}.join(','),
    :advertised_host_name => node["ipaddress"],
    :entries => node["kafka_wrapper"]["conf"]["server"]["entries"]
  )
  notifies :restart, "service[kafka]", :delayed
end

