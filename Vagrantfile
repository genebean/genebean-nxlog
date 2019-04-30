# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "genebean/centos-7-puppet-latest"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: "yum -y install multitail pdk"
  config.vm.provision "shell", inline: "su - vagrant -c 'export PUP_MOD=genebean-nxlog; rsync -rv --delete /vagrant/ /home/vagrant/$PUP_MOD'"
end
