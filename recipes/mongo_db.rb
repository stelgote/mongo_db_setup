cookbook_file '/etc/yum.repos.d/mongodb-org.repo' do
  source 'mongodb-org'
  mode '0755'
end

if platform_version.include? '7'
  yum_package node['mongo_db_setup']['name'] do
    action :install
    flush_cache [ :before ]
  end
else
  dnf_package node['mongo_db_setup']['name'] do
    action :install
    flush_cache [ :before ]
  end
end

# cookbook_file '/etc/systemd/system/disable-thp.service' do
  # source 'disable-thp'
  # mode '0755'
# end

# service 'disable-thp' do
  # subscribes :reload, 'cookbook_file[/etc/systemd/system/disable-thp.service]', :immediately
# end

# service 'disable-thp' do
  # action [ :enable, :start ]
# end

service 'mongod' do
  action [ :enable, :start ]
end
