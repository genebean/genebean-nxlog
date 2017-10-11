# vim:ft=ruby
source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['~> 5.0']

group :development, :unit_tests do
  if puppetversion =~ / 4\./
    gem 'rgen',                  '~> 0.8'
  elsif puppetversion =~ / 5\./
    gem 'CFPropertyList',        '~> 2.3'
  end

  gem 'coveralls',               require: false
  gem 'metadata-json-lint',      '~> 2.0'
  gem 'puppet',                  puppetversion
  gem 'puppet-syntax',           '~> 2.4'
  gem 'puppetlabs_spec_helper',  '~> 2.2'
  gem 'rspec-puppet',            '~> 2.6'
  gem 'rspec-puppet-facts',      '~> 1.8'
  gem 'semantic_puppet',         '~> 1.0'
  gem 'syck',                    '>= 1.3.0'
  gem 'yamllint',                '~> 0.0.9'

  # puppet-lint and plugins
  gem 'puppet-lint',                                      '~> 2.2'
  gem 'puppet-lint-absolute_classname-check',             '~> 0.2'
  gem 'puppet-lint-absolute_template_path',               '~> 1.0'
  gem 'puppet-lint-empty_string-check',                   '~> 0.2'
  gem 'puppet-lint-leading_zero-check',                   '~> 0.1'
  gem 'puppet-lint-resource_reference_syntax',            '~> 1.0'
  gem 'puppet-lint-spaceship_operator_without_tag-check', '~> 0.1'
  gem 'puppet-lint-trailing_newline-check',               '~> 1.1'
  gem 'puppet-lint-undef_in_function-check',              '~> 0.2'
  gem 'puppet-lint-unquoted_string-check',                '~> 0.3'
  gem 'puppet-lint-variable_contains_upcase',             '~> 1.2'
end

group :packaging do
  gem 'puppet-blacksmith', '~> 3.4'
end
