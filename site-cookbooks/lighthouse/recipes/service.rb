service 'nginx' do
  supports status: true, restart: true, stop: true
  action [:enable, :start]
end

service 'redis-server' do
  supports status: true, restart: true, stop: true
  action [:enable, :start]
end
