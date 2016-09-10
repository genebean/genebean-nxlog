[![GitHub tag][gh-tag-img]][gh-link]

## 2016-09-09 Release 1.4.0  
* Camilo Cota (@camilocot) added the `input_type` setting
* I updated the Gemfile to make json and json_pure work with multiple ruby
  versions.
* Added additional puppet-lint tests and update puppet-lint
* Added a Travis test for Puppet 3.x w/ strict variables

## 2015-10-07 Release 1.3.0  
* Jaime Viloria (@cerealcake) added support for specifying output options

## 2015-10-07 Release 1.2.2  
* Fixed an indentation issue

## 2015-10-07 Release 1.2.0  
* Fixed error in example code in the README
* Added support for using processors
* Added support for output execs
* Adjusted the service resource so that it restarts when the config is updated

## 2015-10-07 Release 1.1.0  
* Jaime Viloria (@cerealcake) added support for specifying options for
  extension modules.
* @egouraud added support for specifying the input file used by some input
  modules.
* support for defining the package name was added
* nxlog_root was made optional as it is not needed on Linux when installing via
  packages.

## 2015-06-18 Release 1.0.0  
* Initial release

[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-nxlog.svg?label=newest%20tag
[gh-link]: https://github.com/genebean/genebean-nxlog
