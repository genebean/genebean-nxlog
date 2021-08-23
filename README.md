[![Build Status][travis-img-master]][travis-ci]
[![Puppet Forge][pf-img]][pf-link]
[![GitHub tag][gh-tag-img]][gh-link]

# nxlog

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nxlog](#setup)
    * [What nxlog affects](#what-nxlog-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nxlog](#beginning-with-nxlog)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages NXLog. It is primarily targeted at Windows but should work
on Linux too so long as the package is available via some repository. Automated
testing is done via Travis CI and tests against both Puppet 3.x and 4.x.


## Module Description

This module installs the `nxlog` package, builds a config file using
`puppetlabs-concat`, and manages the `nxlog` service. Since the config file
for NXLog is broken up into sections, and most of these can be repeated, the
choice was made to utilize defined types similar to the way the Apache module
does with virtual hosts.


## Setup

### What nxlog affects

* nxlog package
* nxlog config file
* nxlog service


### Beginning with nxlog

This is an example of how to build a full config file:

```puppet
class {'nxlog':
  conf_dir       => 'C:/Program Files (x86)/nxlog/conf', # note the /'s here
  conf_file      => 'nxlog.conf',
  ensure_setting => latest,
  nxlog_root     => 'C:\Program Files (x86)\nxlog',
}

nxlog::config::extension { 'json':
  ext_module => 'xm_json',
}

nxlog::config::input { 'eventlog_json':
  input_execs  => [
    'delete($Keywords)',
    '$raw_event = to_json()',
  ],
  input_module => 'im_msvistalog',
}

nxlog::config::output { 'local_json':
  output_file_path => 'C:\eventlog-json.txt',
  output_module    => 'om_file',
}

nxlog::config::output { 'logserver':
  output_address   => 'logserver.example.com',
  output_module    => 'om_udp',
  output_port      => '6371',
}

nxlog::config::route { 'local':
  route_destination => [ 'local_json', ],
  route_source      => [ 'eventlog_json', ],
}

nxlog::config::route { 'logserver':
  route_destination => [ 'logserver', ],
  route_source      => [ 'eventlog_json', ],
}
```
### Use custom windows package
```puppet
class {'nxlog':
  conf_dir        => 'C:/Program Files (x86)/nxlog/conf', # note the /'s here
  conf_file       => 'nxlog.conf',
  ensure_setting  => present,
  package_source  => 'C:\\Temp\\nxlog.msi',
  install_options => '/qn'
  nxlog_root      => 'C:\\Program Files (x86)\\nxlog',
}
```
## Usage
### Class nxlog

These settings are used both in the config file and by the other parts of the
module.

`conf_dir` - the directory where nxlog.conf resides

`conf_file` - the name of the config file

`ensure_setting` - this is passed to the package resource

`service_provider` - provider for service nxlog (need change for CentOS7 and RHEL7 to redhat)

`nxlog_root` - the installation directory for the nxlog program. On Windows this is a required setting as NXLog will not start otherwise

`header_options` - an array of options for the added to header. Each item in
  the array will be an line in this section of the config file

`header_template` - override default template for header nxlog conf_file

### Defined Types

Each of these builds a section of the config file.

`nxlog::config::extension` - builds an Extension section using the specified
name.

* `ext_module` - the name of the extension module to use
* `ext_options` - an array of options for the added ext_module. Each item in
  the array will be an line in this section of the config file
* `ext_template` - for use custom template

`nxlog::config::input` - builds an Input section using the specified name.

* `input_execs`  - an array of Exec statements to include (Optional)
*	`input_file_path` - defines the path to use if reading from a local file
* `input_module` - the name of the input module to use
* `input_type` - the name of the registered input reader function to use
* `input_options` - an array of options for the added input_module. Each 
  item in the array will be an line in this section of the config file
* `input_template` - for use custom template

`nxlog::config::output` - builds an Output section using the specified name.

* `output_address`   - the address of the remote host to send data to
* `output_execs`  - an array of Exec statements to include (Optional)
*	`output_file_path` - defines the path to use if writing to a local file
* `output_module`    - the name of the output module to use
* `output_options` - an array of options for the added output_module. Each 
  item in the array will be an line in this section of the config file
* `output_template` - for use custom template
*	`output_port`      - the port on the remote host to send data to

`nxlog::config::processor` - builds a Processor section using the specified name.

* `processor_module` - the name of the processor module to use
* `processor_template` - for use custom template
* `porcessor_input_format` - the format of the data being converted or processed
* `processor_output_format` - the format to convert the data to
* `processor_csv_output_fields` - fields which are placed in the CSV lines.
  The field names must have the dollar sign "$" prepended

`nxlog::config::route` - builds a Route section using the specified name.

*	`route_destination` - an array of outputs to send data to
* `route_source`      - an array of inputs to send to the named destination
* `route_template`    - for use custom template


## Limitations

On Windows it is assumed that you are using [Chocolatey][chocolatey] to install
packages.

On Linux it is assumed that you have a custom repo which contains `nxlog-ce`.
You can work around this by installing the program separately and setting
`ensure_setting => present`.

`nxlog::config::processor` chooses a template based on the value of
`processor_module`. Not all of the possible modules have had templates generated
for them yet... if you want one that does not yet feel free to file a bug report
or, better yet, send a pull request.


## Development

Pull requests are welcome! A Vagrantfile is included in this module to aide in
testing and development. All code must have tests before it will be merged but I 
am happy to help with that part.


## Contributors

* Jaime Viloria (@cerealcake) - Added support for specifying output options.
* Jaime Viloria (@cerealcake) - Added support for specifying options for
  extension modules.
* @egouraud - Added support for specifying the input file used by some input
  modules.
* Camilo Cota (@camilocot) - Added the `input_type` setting


[chocolatey]: https://chocolatey.org
[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-nxlog.svg
[gh-link]: https://github.com/genebean/genebean-nxlog
[pf-img]: https://img.shields.io/puppetforge/v/genebean/nxlog.svg
[pf-link]: https://forge.puppetlabs.com/genebean/nxlog
[travis-ci]: https://travis-ci.org/genebean/genebean-nxlog
[travis-img-master]: https://img.shields.io/travis/genebean/genebean-nxlog/master.svg
