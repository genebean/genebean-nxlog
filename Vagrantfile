# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "genebean/centos-7-rvm-multi"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: "yum -y install multitail vim nano git"
  config.vm.provision "shell", inline: "su - vagrant -c 'rvm install ruby-2.5.7; rvm use ruby 2.5.7 --default'"
  config.vm.provision "shell", inline: "gem install bundler"
  config.vm.provision "shell", inline: "su - vagrant -c 'export PUP_MOD=genebean-nxlog; rsync -rv --delete /vagrant/ /home/vagrant/$PUP_MOD --exclude bundle; cd /home/vagrant/$PUP_MOD; bundle install --jobs=3 --retry=3; bundle exec rake spec_prep'"
end
