#
# Cookbook:: postgres
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file '/opt/pgdg-redhat96-9.6-3.noarch.rpm' do
  source 'pgdg-redhat96-9.6-3.noarch.rpm'
end

package "pgdg-redhat96-9.6-3.noarch.rpm" do
  source "/opt/pgdg-redhat96-9.6-3.noarch.rpm"
end

package "postgresql96-server"
package "postgresql96-contrib"

execute "initdb" do
  command "/usr/pgsql-9.6/bin/postgresql96-setup initdb"
  not_if { Dir.exists?("/var/lib/pgsql/9.6/data/") && !Dir.empty?('/var/lib/pgsql/9.6/data/')}
end

service "postgresql-9.6" do
  action [:enable, :start ]
end

service 'memcached' do
  action :nothing
end

