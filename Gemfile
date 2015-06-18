source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
  puppetversion = "#{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['>= 3.7.3', '< 4.0']
end

gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 0.1.0'
gem 'puppet-lint', ['>= 0.3.2', '< 1.1.0']
gem 'facter', '>= 1.7.0'
gem 'puppet-blacksmith'
gem 'rspec-puppet', '~>2.0'

