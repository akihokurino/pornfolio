#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# ruby自体のインストール
bash "ruby-#{node['build']} install" do
  not_if "ls #{node['install_path']}"
  user "#{node['user']}"
  cwd "/tmp"
  code <<-EOH
    wget http://cache.ruby-lang.org/pub/ruby/#{node['build_path']}/ruby-#{node['build']}.tar.gz
    tar zxvf ruby-#{node['build']}.tar.gz
    cd ruby-#{node['build']}
    ./configure
    make
    make install
    rm -rf /tmp/*
  EOH
end

