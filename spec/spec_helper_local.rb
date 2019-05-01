# Code per https://github.com/puppetlabs/puppetlabs_spec_helper#using-coveralls
require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter,
]

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.vendor/'
  add_filter '/.vendor/'
end
