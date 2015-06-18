# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "genebean/centos6-puppet-64bit"
  #config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder ".",             "/vagrant"

  config.vm.provision "shell", inline: "yum -y install multitail vim nano"
  config.vm.provision "shell", inline: "puppet module install puppetlabs-concat"

end
