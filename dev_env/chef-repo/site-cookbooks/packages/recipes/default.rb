#
# Cookbook Name:: packages
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'yum::epel'

%w{gcc gcc-c++ make wget tree ctags readline-devel zlib-devel libcurl-devel libyaml libyaml-devel zlib readline openssl openssl-devel libxml2 libxml2-devel libxslt libxslt-devel patch kernel-devel ncurses-devel gdbm-devel db4-devel libffi-devel tk-devel ImageMagick ImageMagick-devel ipa-gothic-fonts ipa-mincho-fonts}.each do |name|
    package name do
        action :install
    end
end

package "ruby" do
    action :remove
end

# execute "install rsub" do
#   user "root"
#   command "wget -O /usr/local/bin/rsub https://raw.github.com/aurora/rmate/master/rmate"
#   action :run
# end

# execute "add execute permission for rsub" do
#   user "root"
#   command "chmod +x /usr/local/bin/rsub"
#   action :run
# end

bash "install rsub" do
  user "root"
  not_if   "which rsub"
  code   <<-EOH
    wget -O /usr/local/bin/rsub https://raw.github.com/aurora/rmate/master/rmate
    chmod +x /usr/local/bin/rsub
  EOH
end