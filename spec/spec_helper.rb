require 'rubygems'

require 'coveralls'
require 'hiera'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts
require 'simplecov'
Coveralls.wear!

SimpleCov.formatter = Coveralls::SimpleCov::Formatter

SimpleCov.start do
  add_filter '/spec'
  add_filter '/vendor'
  add_filter '/.vendor'
end

RSpec.configure do |c|
    c.after(:suite) do
        RSpec::Puppet::Coverage.report!
    end
end
