#
# Cookbook Name:: monit_bin
# Recipe:: default
#
# Copyright (C) 2012 HiganWorks LLC
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

include_recipe 'chef-sugar::default'

service "monit" do
  case node["platform"]
  when "ubuntu"
    provider Chef::Provider::Service::Upstart if upstart?
    provider Chef::Provider::Service::Systemd if systemd?
    action :enable
  when "smartos"
    provider Chef::Provider::Service::Simple
    pattern "/opt/local/sbin/monit"
    restart_command "/usr/sbin/init q"
    reload_command "/opt/local/sbin/monit reload"
    start_command "/usr/sbin/init q"
    status_command "/usr/bin/pgrep /opt/local/sbin/monit"
  when "debian"
    provider Chef::Provider::Service::Init::Debian
    supports :restart => true, :reload => true, :status => true
    action :enable
  end
end
