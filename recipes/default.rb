#
# Cookbook:: sysctl
# Recipe:: default
#
# Copyright:: 2017, Nate Catelli, All Rights Reserved.


node['sysctl']['settings'].each do |k, v|
  sysctl_set "#{k}" do
    value "#{v}"
    action :set
  end
end
