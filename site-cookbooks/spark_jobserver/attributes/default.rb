# The username and the group used by the spark jobserver
default["jobserver"]["user"] = "spark"
default["jobserver"]["group"] = "spark"

# The directory where the jobserver will be installed
default["jobserver"]["dir"] = "/opt/jobserver" 

# The url used to download the jobserver compiled
default["jobserver"]["download"] = "https://97010159ed7d6150bf7df2f25118cfc808514446.googledrive.com/host/0B1VEKVUtHYlIflgtOTg3R1JmZjBtbWtjRUczeTIwQmNhVEJaZ0RCTS1wWGZ1ZGRnX2JCa2c/job-server.tar.gz"

# The directory to store logs
default["jobserver"]["log_dir"] = "/var/log/jobserver"

# The pid file 
default["jobserver"]["pidfile"] = "spark-jobserver.pid"

# Memory allocated by the jobserver
default["jobserver"]["memory"] = "1G"

# Spark version
default["jobserver"]["spark_version"] = "1.4.1"

# Spark home
default["jobserver"]["spark_home"] = "/opt/spark/spark-1.4.1"

# Scala version
default["jobserver"]["scala_version"] = "2.11.7"

# Databag with the spark master hostname
default["jobserver"]["databag"] = "spark"
default["jobserver"]["cassandra"] = "cassandra"