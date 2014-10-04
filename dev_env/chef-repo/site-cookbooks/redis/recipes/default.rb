#
#
# Cookbook Name:: Redis
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "tcl"

bin = "/usr/local/bin/redis-server"
version  = node[:redis][:version]
file = "redis-#{version}"
url = "http://download.redis.io/releases/redis-#{version}.tar.gz"
installed_version = `#{bin} -v 2>&1`.chomp.split(/\s/)[2].sub("v=","")
log "installed version: #{installed_version}"
do_install = ( version != installed_version )


remote_file "/tmp/redis-#{version}.tar.gz" do
  source "#{url}"
  mode "0644"
  only_if { do_install }
end

bash "install_redis" do
  cwd "/tmp"
  code <<-EOH
    tar zxvf #{file}.tar.gz && cd #{file} && make && make install && cp utils/redis_init_script /etc/init.d/redis && mkdir /etc/redis/ && cp redis.conf /etc/redis/6379.conf
  EOH
  only_if { do_install }
end

file "/tmp/#{file}.tar.gz" do
  action :delete
end
