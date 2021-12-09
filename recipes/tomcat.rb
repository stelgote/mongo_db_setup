dnf_package 'java-1.8.0-openjdk-headless' do
  action :install
end

directory '/tmp/tomcat'

remote_file "/tmp/tomcat/#{node['mongo_db_setup']['tomcat_file']}" do
  source "https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.33/bin/#{node['mongo_db_setup']['tomcat_file']}"
  action :create
end

archive_file "/tmp/tomcat/#{node['mongo_db_setup']['tomcat_file']}" do
  path "/tmp/tomcat/#{node['mongo_db_setup']['tomcat_file']}"
  destination '/usr/local/tomcat/'
  strip_components 1
end

#link '/usr/local/tomcat/apache-tomcat-9.0.33' do
#  to '/usr/local/tomcat/tomcat'
#  link_type :symbolic
#end

user 'tomcat' do
  action :create
end

#directory '/usr/local/tomcat' do
#  owner 'tomcat'
#  group 'tomcat'
#  recursive true
#end

bash 'Change owner' do
  code <<-EOH
    chown -R tomcat:tomcat /usr/local/tomcat/
  EOH
end

cookbook_file '/etc/systemd/system/tomcat.service' do
  source 'tomcat'
  mode '0755'
end

#service 'tomcat' do
#  subscribes :reload, 'cookbook_file[/etc/systemd/system/tomcat.service]', :immediately
#end

bash 'Reload daemon' do
  code <<-EOH
    systemctl daemon-reload
  EOH
end

service 'tomcat' do
  action [ :enable, :start ]
end
