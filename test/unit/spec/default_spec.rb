# Encoding: utf-8

require_relative 'spec_helper'

describe 'cheftdd::default' do
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

  it 'executes apt-get update' do
    expect(chef_run).to run_execute('apt-get update')
  end
end
