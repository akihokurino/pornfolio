#
# Cookbook Name:: gem
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# gemをアップデート
execute "gem update --system" do
    command "gem update --system"
    action :run
end

%w(ruby-debug-ide bundle rubocop).each do |name|
    gem_package name do
        action :install
    end
end

# railsをインストール
gem_package "rails" do
    action :install
    version "#{node['rails']['build']}"
end