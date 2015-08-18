#
# Cookbook Name:: spark_jobserver
# Recipe:: install
#
# Copyright 2015, Passworks
#
# All rights reserved - Do Not Redistribute
#

include_recipe "spark_jobserver::create-user"

jobserver_user = node["jobserver"]["user"]
jobserver_group = node["jobserver"]["group"]
jobserver_download = node["jobserver"]["download"]
jobserver_dir = node["jobserver"]["dir"]
jobserver_log_dir = node["jobserver"]["log_dir"]

# Create the jobserver dir
directory jobserver_dir do
	owner jobserver_user
	group jobserver_group
	mode 0770
	action :create
	recursive true
end

# Download and untar the spark jobserver
remote_file "#{jobserver_dir}/job-server-downloaded.tar.gz" do
	owner jobserver_user
	group jobserver_group
	mode 0770
	source jobserver_download
	backup false
	notifies :run, "execute[unzip jobserver source]"	
	not_if { ::File.exists?("#{jobserver_dir}/job-server-downloaded.tar.gz") }
end

execute "unzip jobserver source" do
	command "tar -xvf #{jobserver_dir}/job-server-downloaded.tar.gz -C #{jobserver_dir}"
	not_if { Dir["#{jobserver_dir}/*"].count > 1 }
end

# Give permissions to the user
ruby_block 'give some permissions' do
	block do
		Dir["#{jobserver_dir}/*"].each do |path|
			f = Chef::Resource::File.new(path, run_context)
			f.owner jobserver_user
			f.group jobserver_group
			f.mode 0770
			f.run_action :create
		end
	end
end

directory jobserver_log_dir do
	owner jobserver_user
	group jobserver_group
	mode 0777
	action :create
	recursive true
end
