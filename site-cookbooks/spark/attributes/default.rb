# The user and the group that will be used
default[:spark][:user] = "spark"
default[:spark][:group] = "spark"

# Spark version and the link that we use to download the compiled version
default[:spark][:version] = "1.4.1"
default[:spark][:download_url] = "https://97010159ed7d6150bf7df2f25118cfc808514446.googledrive.com/host/0B1VEKVUtHYlIflgtOTg3R1JmZjBtbWtjRUczeTIwQmNhVEJaZ0RCTS1wWGZ1ZGRnX2JCa2c/spark-1.4.1.tgz"

# The installation directory
default[:spark][:install_dir] = "/opt/spark"

# Additional properties to spark-env.sh
default[:spark][:env][:others] = {

}

# Additional properties to spark-default.conf
default[:spark][:defaults][:others] = {

}

# databags that will be used
default[:spark][:databag] 		= "spark"
default[:cassandra][:databag] 	= "cassandra"
default[:kafka][:databag] 		= "zookeeper"