# Necessary steps to run specs
package 'build-essential' do
  action :install
end

gem_package 'bundler' do
  action :install
end

gem_package 'rspec' do
  action :install
end

execute "bundle install" do
  cwd "/vagrant"
  action :run
end

# Items for testing specs

template "motd" do
  path '/etc/motd'
  mode 0644
  owner "root"
  group "root"
end

execute "apt-get update" do
  action :run
end

package 'apache2-mpm-worker' do
  action :install
end
