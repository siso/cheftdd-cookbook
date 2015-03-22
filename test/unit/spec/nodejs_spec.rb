# Encoding: utf-8

require_relative 'spec_helper'

describe 'cheftdd::nodejs' do
  before do
    stub_resources
  end

  cached(:chef_run) do
    ChefSpec::SoloRunner.new(UBUNTU_OPTS) do |node|
      node.set['public_info']['remote_ip'] = '10.10.10.10'
      stub_resources
      # Stub the node and any calls to Environment.Load to return this environment
      env = Chef::Environment.new
      env.name '_default'
      allow(node).to receive(:chef_environment).and_return(env.name)
      allow(Chef::Environment).to receive(:load).and_return(env)
    end.converge(described_recipe)
  end

  it 'include nodejs recipe' do
    expect(chef_run).to include_recipe('nodejs')
  end

  # Follow instructions to install reveal.js on https://github.com/hakimel/reveal.js/
  it 'install grunt-cli' do
    expect(chef_run).to run_execute('npm install -g grunt-cli')
  end

  it 'install git' do
    expect(chef_run).to install_apt_package('git')
  end

  it 'clone reveal.js GitHub repository' do
    expect(chef_run).to run_execute('git clone https://github.com/hakimel/reveal.js.git')
  end

  it 'install npm packages' do
    expect(chef_run).to run_execute('npm install')
  end
end
