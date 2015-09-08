lighthouse_user = node['lighthouse']['user']
user lighthouse_user do
  comment "Creating user #{lighthouse_user}"
  system true
  action :create
end