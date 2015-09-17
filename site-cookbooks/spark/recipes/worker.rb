include_recipe "spark::default"

# Start a spark worker with upstart
service "spark_worker" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :stop => true
  action [:enable, :stop, :start]
end
