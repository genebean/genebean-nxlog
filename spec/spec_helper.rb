require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter 'spec/fixtures'
end

require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'

