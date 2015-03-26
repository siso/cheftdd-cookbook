#
# Cookbook Name:: cheftdd-demo
# Recipe:: nodejs
#
# Copyright (C) 2015 Acme Corp.
#
# All rights reserved - GNU General Public License v3+
#

#
# Install reveal.js - https://github.com/hakimel/reveal.js/
#

# install nodejs, from package by default
include_recipe 'nodejs'

execute 'install grunt-cli' do
  command 'npm install -g grunt-cli'
  action :run
end

# execute 'install grunt-daemon' do
#   command 'npm install grunt-daemon --save-dev'
#   action :run
# end

package 'git' do
  action :install
end

execute 'clone reveal.js GitHub repository' do
  command 'git clone https://github.com/hakimel/reveal.js.git'
  action :run
  cwd '/opt'
  not_if { File.exist?('/opt/reveal.js') }
end

execute 'install npm packages' do
  command 'npm install'
  action :run
  cwd '/opt/reveal.js'
end

execute 'start serving node.js app' do
  command 'grunt serve --port 80 &'
  action :run
  cwd '/opt/reveal.js'
end

# Open http://localhost:80 to view your presentation

add_iptables_rule('INPUT', '-p tcp -m state --state NEW --dport 80 -s 0.0.0.0/0 -j ACCEPT', 50, 'Allow the Internet access the web-server')
