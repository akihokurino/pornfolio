#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

service 'iptables' do
    action [:disable, :stop]
end

# service "iptables" do
#   supports :status => true, :restart => true, :reload => true
#   action [:enable, :start]
# end

# template "/etc/sysconfig/iptables" do
#   source "iptables.erb"
#   owner "#{node.user}"
#   group "#{node.user}"
#   mode 0600
#   notifies :restart, 'service[iptables]'
# end



