# projects/myproject/vagrant/chef/cookbooks/my_cookbook/recipes/server.rb

execute "install zend key" do
#this command will be executed if "zend" is not found in apt-key list
  command "wget http://repos.zend.com/zend.key -O- | apt-key add -"
  not_if "apt-key list| /bin/grep -c zend"
end

execute "install zend repository " do
#just like we did with the key, we will only install the repository if its not found
  command "echo 'deb http://repos.zend.com/zend-server/deb server non-free' >> /etc/apt/sources.list"
  not_if "grep 'http://repos.zend.com/zend-server/deb' -c /etc/apt/sources.list"
end

execute "install mongo key" do
  command "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
  not_if "apt-key list| /bin/grep -c 10gen"
end

execute "install mongo repo" do
  command "echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' >> /etc/apt/sources.list"
  not_if "grep 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart' -c /etc/apt/sources.list"
end

execute "update apt" do
  # we are telling apt to update but be quiet and confirm any prompts
  command "apt-get update -q -y"
end

#specify packages we want to install
package "zend-server-ce-php-5.3"
package "php-5.3-mongo-zend-server"
package "mongodb-10gen"

cookbook_file "/etc/apache2/sites-enabled/app.conf" do
  source "app.conf"
  group "root"
  owner "root"
end

execute "disable default site" do
  command "a2dissite default"
end

execute "configure apache env" do
  command "echo '. /etc/profile.d/oracle_instantclient.sh' >> /etc/apache2/envvars"
  not_if "grep 'orcal_instantclient.sh' -c /etc/apache2/envvars"
end

service "apache2" do
  action :restart
end
