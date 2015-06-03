# Class: nxlog
#
# This module manages nxlog. See README.md for more details.
#
class nxlog (
  $conf_dir      = $::nxlog::params::conf_dir,
  $conf_file     = $::nxlog::params::conf_file,
  $nxlog_root    = $::nxlog::params::nxlog_root,
  $output_local  = $::nxlog::params::output_local,
  $output_remote = $::nxlog::params::output_remote,) inherits ::nxlog::params {
  anchor { '::nxlog::start':
  } ->
  class { '::nxlog::install':
  } ->
  class { '::nxlog::config':
  } ->
  class { '::nxlog::service':
  } ->
  anchor { '::nxlog::end':
  }
}
