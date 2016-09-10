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
  gem 'puppet-lint',             '~> 1.1'
  gem 'puppetlabs_spec_helper',  '~> 1.0'
  gem 'rspec-puppet',            '~> 2.0'
  
  # puppet-lint plugins
  gem 'puppet-lint-absolute_classname-check', '~> 0.1'
  gem 'puppet-lint-empty_string-check', '~> 0.2'
  gem 'puppet-lint-leading_zero-check', '~> 0.1'
  gem 'puppet-lint-spaceship_operator_without_tag-check', '~> 0.1'
  gem 'puppet-lint-trailing_newline-check', '~> 1.0'
  gem 'puppet-lint-undef_in_function-check', '~> 0.1'
  gem 'puppet-lint-unquoted_string-check', '~> 0.2'
  gem 'puppet-lint-variable_contains_upcase', '~> 1.0'
end

group :packaging do
  gem 'puppet-blacksmith',       '>= 3.3.0'
end
