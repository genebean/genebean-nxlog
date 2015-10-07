# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "genebean/centos6-rvm193-64bit"
  #config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder ".",             "/vagrant"

  config.vm.provision "shell", inline: "yum -y install multitail vim nano git"
  config.vm.provision "shell", inline: "su - vagrant -c 'export PUP_MOD=nxlog; rsync -rv --delete /vagrant/ /home/vagrant/$PUP_MOD --exclude bundle; cd /home/vagrant/$PUP_MOD; bundle install --jobs=3 --retry=3 --path=${BUNDLE_PATH:-vendor/bundle}; bundle exec rake spec_prep'"

end
