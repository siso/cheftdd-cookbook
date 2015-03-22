#
# Cookbook Name:: cheftdd
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get update/upgrade" do
  command "apt-get update"
  action :run
end
