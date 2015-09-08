include_recipe "apt"
include_recipe "lighthouse::create_user"
include_recipe "postgresql::server"


apt_repository "nginx" do
    uri "http://nginx.org/packages/ubuntu/"
    components ["nginx"]
    distribution "trusty"
    action :add
end

package "nginx" do
  action :install
  options '--force-yes'
  notifies :restart, "service[nginx]", :delayed
end

apt_repository 'redis' do
  uri          'ppa:rwky/redis'
  distribution 'trusty'
end

package 'redis-server' do
  action :install
  options '--force-yes'
  notifies :restart, "service[redis-server]", :delayed
end

package 'redis-tools' do
  action :install
  options '--force-yes'
end

include_recipe "rvm::system_install"