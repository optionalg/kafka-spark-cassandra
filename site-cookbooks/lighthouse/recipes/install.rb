include_recipe "apt"
include_recipe "lighthouse::create_user"

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


# apt_repository 'redis' do
#   action :add
#   uri "http://ppa.launchpad.net/rwky/redis/ubuntu"
#   distribution 'trusty'
#   components ["main"]
#   keyserver "keyserver.ubuntu.com"
#   key "5862E31D"
#   notifies :run, "execute[apt-get update]", :immediately
# end

# package 'redis-server' do
#   action :install
#   options '--force-yes'
#   notifies :restart, "service[redis-server]", :delayed
# end

# package 'redis-tools' do
#   action :install
#   options '--force-yes'
# end

