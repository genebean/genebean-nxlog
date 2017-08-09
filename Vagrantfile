# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "genebean/centos-7-rvm-multi"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: "yum -y install multitail vim nano git"
  config.vm.provision "shell", inline: "gem install --no-ri --no-rdoc bundler"
  config.vm.provision "shell", inline: "su - vagrant -c 'export PUP_MOD= @configs[:puppet_module]; rsync -rv --delete /vagrant/ /home/vagrant/$PUP_MOD --exclude bundle; cd /home/vagrant/$PUP_MOD; bundle install --jobs=3 --retry=3; bundle exec rake spec_prep'"
end
