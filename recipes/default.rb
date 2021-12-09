#
# Cookbook:: mongo_db_setup
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.


include_recipe 'mongo_db_setup::mongo_db'
include_recipe 'mongo_db_setup::tomcat'
