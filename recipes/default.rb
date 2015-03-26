#
# Cookbook Name:: cheftdd
# Recipe:: default
#
# Copyright (C) 2015 Acme Corp.
#
# All rights reserved - GNU General Public License v3+
#

execute "apt-get update/upgrade" do
  command "apt-get update"
  action :run
end

include_recipe 'platformstack::default'
include_recipe 'platformstack::rackops_rolebook'

if node['testkitchen']
  add_iptables_rule('INPUT', '-p tcp -m state --state NEW --dport 22 -s 10.0.0.0/8 -j ACCEPT', 50, 'vagrant access')
end
