include_recipe "spark_wrapper::default"

service "spark_master" do
  action :start
end
