# Class: nxlog
#
# This module manages nxlog. See README.md for more details.
#
class nxlog (
  $conf_dir          = $::nxlog::params::conf_dir,
  $conf_file         = $::nxlog::params::conf_file,
  $ensure_setting    = $::nxlog::params::ensure_setting,
  $ext_module        = $::nxlog::params::ext_module,
  $input_execs       = $::nxlog::params::input_execs,
  $input_module      = $::nxlog::params::input_module,
  $nxlog_root        = $::nxlog::params::nxlog_root,
  $order_extension   = $::nxlog::params::order_extension,
  $order_header      = $::nxlog::params::order_header,
  $order_input       = $::nxlog::params::order_input,
  $order_output      = $::nxlog::params::order_output,
  $order_route       = $::nxlog::params::order_route,
  $output_address    = $::nxlog::params::output_address,
  $output_file_path  = $::nxlog::params::output_file_path,
  $output_module     = $::nxlog::params::output_module,
  $output_port       = $::nxlog::params::output_port,
  $route_destination = $::nxlog::params::route_destination,
  $route_source      = $::nxlog::params::route_source,
) inherits ::nxlog::params {
  validate_absolute_path($nxlog_root)
  validate_absolute_path($conf_dir)
  validate_string($conf_file)

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
