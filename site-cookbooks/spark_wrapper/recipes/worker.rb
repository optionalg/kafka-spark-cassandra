include_recipe "spark_wrapper::default"

service "spark_worker" do
  action :start
end
