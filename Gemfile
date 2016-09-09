source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
  puppetversion = "#{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['>= 3.7.3', '< 4.0']
end

group :development, :unit_tests do
  if RUBY_VERSION < '2.0'
    gem 'json',                  '1.8.3'
    gem 'json_pure',             '1.8.3'
  else
    gem 'json',                  '>= 2.0.2'
    gem 'json_pure',             '>= 2.0.2'
  end

  gem 'metadata-json-lint',      '~> 0.0.6'
  gem 'puppet',                  puppetversion
  gem 'puppet-lint',             ['>= 1.0.0', '< 1.1.0']
  gem 'puppetlabs_spec_helper',  '~> 1.0'
  gem 'rspec-puppet',            '~> 2.0'
end

group :packaging do
  gem 'puppet-blacksmith',       '>= 3.3.0'
end
