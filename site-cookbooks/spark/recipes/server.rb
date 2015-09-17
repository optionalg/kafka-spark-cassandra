include_recipe "spark::default"

# Start a spark master with upstart
service "spark_master" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :stop => true
  action [:enable, :stop, :start]
end