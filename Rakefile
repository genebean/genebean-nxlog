require 'rubygems'
require 'metadata-json-lint/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet_blacksmith/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'yamllint/rake_task'

exclude_paths = [
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
]

PuppetLint::RakeTask.new :lint do |config|
  config.fail_on_warnings = true
  config.ignore_paths = exclude_paths
  config.log_format = "%{path}:%{line}:%{check}:%{KIND}:%{message}"
end

PuppetLint.configuration.send('disable_spaceship_operator_without_tag')

PuppetSyntax.check_hiera_keys = true
PuppetSyntax.exclude_paths = exclude_paths
PuppetSyntax.hieradata_paths = [
  "**/data/**/*.yaml",
  "hieradata/**/*.yaml",
  "hiera*.yaml"
]

desc 'Validate manifests, templates, and ruby files'
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['templates/**/*.epp'].each do |template|
    sh "puppet epp validate #{template}"
  end
  Dir['spec/**/*.rb', 'lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ %r{spec/fixtures}
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end #

desc 'Run lint, validate, and spec tests.'
task :tests do
  [:lint, :syntax, :validate, :spec].each do |test|
    Rake::Task[test].invoke
  end
end
