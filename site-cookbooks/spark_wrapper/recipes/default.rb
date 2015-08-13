#
# Cookbook Name:: spark_wrapper
# Recipe:: default
#

# Create the user
user node[:spark][:user] do
  system true
  shell "/bin/false"
end

spark_dir = "#{node[:spark][:install_dir]}/spark-#{node[:spark][:version]}"

# Create the home directory
directory node[:spark][:install_dir] do
  owner node[:spark][:user]
  mode 750
  action :create
  recursive true
end

# Download and untar spark
remote_file "#{spark_dir}.tgz" do
  source node[:spark][:download_url]
  backup false
  notifies :run, "execute[unzip spark source]"
  not_if { ::File.exist?(::File.join(node[:spark][:install_dir], spark_dir)) }
end

execute "unzip spark source" do
  command "tar -zxvf #{spark_dir}.tgz -C #{node[:spark][:install_dir]}"
  not_if { ::File.exist?(spark_dir) }
end


[
  "#{spark_dir}",
  "#{spark_dir}/bin",
  "#{spark_dir}/logs",
  "#{spark_dir}/conf"  
].each do |dir|
  directory dir do
    recursive true
    owner node[:spark][:user]
    mode 750
  end
end

bag = data_bag_item('config', node["spark-cluster"]["databag"])

# File to setup spark environment
template "#{spark_dir}/conf/spark-env.sh" do
  source "spark-env.sh.erb"
  owner node[:spark][:username]
  group node[:spark][:group]
  mode 750
  variables(
    :spark_master_ip => bag["master"],
    :others => node["spark"]["env"]["others"]
  )

  notifies :restart, "service[spark_master]", :delayed
  notifies :restart, "service[spark_worker]", :delayed
end

# File with all the slaves
template "#{spark_dir}/conf/slaves" do
  source "slaves.erb"
  owner node[:spark][:username]
  group node[:spark][:group]
  mode 750
  variables(
    :slaves => bag["slaves"]
  )
 
  notifies :restart, "service[spark_master]", :delayed
  notifies :restart, "service[spark_worker]", :delayed
end

# Script to start and stop spark master
template "/etc/init/spark_master.conf" do
  source "spark_master.init.erb"
  owner  node[:spark][:username]
  group  node[:spark][:group]
  action :create
  mode   750
  notifies :restart, "service[spark_master]", :delayed
  variables(
    :spark_dir => spark_dir,
    :spark_master => bag["master"]
  )
end

# Script to start and stop spark workers
template "/etc/init/spark_worker.conf" do
  source "spark_worker.init.erb"
  owner  node[:spark][:username]
  group  node[:spark][:group]
  action :create
  mode   750
  notifies :restart, "service[spark_worker]", :delayed
  variables(
    :spark_dir => spark_dir,
    :spark_master => bag["master"]
  )
end

service "spark_master" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :stop => true
  action :enable
end

service "spark_worker" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :stop => true
  action :enable
end

