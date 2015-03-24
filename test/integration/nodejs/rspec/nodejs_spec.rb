# Encoding: utf-8

require_relative 'spec_helper'

describe command('nodejs --version') do
  its(:stdout) { should match(/v0.10.37/) }
end

describe package('git') do
  it { should be_installed }
end

describe file('/opt/reveal.js') do
  it { should be_directory }
end

describe port('80') do
  it { should be_listening }
end

describe iptables do
  it { should have_rule('-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -m comment --comment "Allow the Internet access the web-server" -j ACCEPT').with_chain('INPUT') }
end
