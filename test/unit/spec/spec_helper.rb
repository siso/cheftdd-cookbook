# Encoding: utf-8
require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

::LOG_LEVEL = :error

::UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '14.04',
  log_level: ::LOG_LEVEL
}

::CHEFSPEC_OPTS = {
  log_level: ::LOG_LEVEL
}

def stub_resources
  stub_command('which sudo').and_return(true)
  allow(File).to receive(:exist?).and_call_original
  stub_command('/usr/sbin/apache2 -t').and_return(0)
  stub_command('/usr/sbin/httpd -t').and_return(0)
end

def server_runner_resources(server)
  server.create_data_bag('environment_data', fixtures_databags('environment_data', '_default_server'))
  server.create_node('web01', fixtures_nodes('web01'))
end

def stub_environments(server)
  Dir['./test/integration/environments/*.json'].sort.each do |f|
    env_data = JSON.parse(IO.read(f), symbolize_names: false)
    env_name = env_data['name']
    server.create_environment(env_name, env_data)
  end
end

at_exit { ChefSpec::Coverage.report! }
