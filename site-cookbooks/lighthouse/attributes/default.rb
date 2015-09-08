require 'digest'

default['lighthouse']['user']='passworks'

default["rvm"]["installs"] = {
  "wigglebottom" => {
    "default_ruby"  => "ruby-2.2.0",
    "rubies"        => ["2.2.0"]
  }
}

# postgressql
default['postgresql']['version']              = "9.3"
default['postgresql']['password']['postgres'] = "ab68f7d7af96aa83386fa41d3b444728"