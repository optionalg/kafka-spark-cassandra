default["postgresql"]["users"] = [
  {
    "username" => "passworks",
    "password" => "passworks",
    "superuser" => true,
    "replication" => false,
    "createdb" => true,
    "createrole" => false,
    "inherit" => true,
    "replication" => false,
    "login" => true
  }
]

# default["postgresql"]["databases"] = [
#   {
#     "name" => "test",
#     "owner" => "passworks",
#     "encoding" => "UTF-8",
#     "locale" => "en_US.UTF-8",
#     "extensions" => ["hstore", "json"],
#     "postgis" => true
#   }
# ]
