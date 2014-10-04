#
# Cookbook Name:: npm
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# execute "grunt and bower" do
#   user "root"
#   command "npm install -g grunt-cli bower"
#   action :run
# end

# execute "yeomon" do
#   user "root"
#   command "npm install -g yo"
#   action :run
# end

# execute "basic scaffolding" do
#   user "root"
#   command "npm install -g generator-webapp"
#   action :run
# end

# execute "angular" do
#   user "root"
#   command "npm install -g generator-angular"
#   action :run
# end

bash "install yeoman and angular" do
  user "root"
  not_if "which yo"
  code   <<-EOH
    npm install -g grunt-cli bower
    npm install -g yo
    npm install -g generator-webapp
    npm install -g generator-angular
  EOH
end