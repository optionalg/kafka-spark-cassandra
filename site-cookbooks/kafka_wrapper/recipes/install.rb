# encoding: UTF-8
# Cookbook Name:: kafka_wrapper
# Recipe:: install
#

include_recipe "java" if node["kafka_wrapper"]["install_java"]

version_tag = "kafka_#{node["kafka_wrapper"]["scala_version"]}-#{node["kafka_wrapper"]["version"]}"
download_url = ::File.join(node["kafka_wrapper"]["mirror"], "#{node["kafka_wrapper"]["version"]}/#{version_tag}.tgz")
download_path = ::File.join(Chef::Config[:file_cache_path], "#{version_tag}.tgz")

user node["kafka_wrapper"]["user"] do
  comment node["kafka_wrapper"]["user"]
  system true
  shell "/bin/false"
end

directory node["kafka_wrapper"]["install_dir"] do
  recursive true
  owner node["kafka_wrapper"]["user"]
end

remote_file download_path do
  source download_url
  backup false
  checksum node["kafka_wrapper"]["checksum"]
  notifies :run, "execute[unzip kafka source]"
  not_if { ::File.exist?(::File.join(node["kafka_wrapper"]["install_dir"], version_tag)) }
end

execute "unzip kafka source" do
  command "tar -zxvf #{download_path} -C #{node["kafka_wrapper"]["install_dir"]}"
  not_if { ::File.exist?(::File.join(node["kafka_wrapper"]["install_dir"], version_tag)) }
end
