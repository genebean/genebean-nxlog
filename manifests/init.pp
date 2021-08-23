# Class: nxlog
#
# This module manages nxlog. See README.md for more details.
#
class nxlog (
  $conf_dir                    = $::nxlog::params::conf_dir,
  $conf_file                   = $::nxlog::params::conf_file,
  $ensure_setting              = $::nxlog::params::ensure_setting,
  $service_provider            = $::nxlog::params::service_provider,
  $header_template             = $::nxlog::params::header_template,
  $header_options              = $::nxlog::params::header_options,
  $ext_module                  = $::nxlog::params::ext_module,
  $ext_options                 = $::nxlog::params::ext_options,
  $ext_template                = $::nxlog::params::ext_template,
  $input_execs                 = $::nxlog::params::input_execs,
  $input_file_path             = $::nxlog::params::input_file_path,
  $input_module                = $::nxlog::params::input_module,
  $input_type                  = $::nxlog::params::input_type,
  $input_options               = $::nxlog::params::input_options,
  $input_template              = $::nxlog::params::input_template,
  $nxlog_root                  = $::nxlog::params::nxlog_root,
  $order_extension             = $::nxlog::params::order_extension,
  $order_header                = $::nxlog::params::order_header,
  $order_input                 = $::nxlog::params::order_input,
  $order_output                = $::nxlog::params::order_output,
  $order_route                 = $::nxlog::params::order_route,
  $output_address              = $::nxlog::params::output_address,
  $output_execs                = $::nxlog::params::output_execs,
  $output_file_path            = $::nxlog::params::output_file_path,
  $output_module               = $::nxlog::params::output_module,
  $output_options              = $::nxlog::params::output_options,
  $output_template             = $::nxlog::params::output_template,
  $output_port                 = $::nxlog::params::output_port,
  $package_name                = $::nxlog::params::package_name,
  $package_source              = $::nxlog::params::package_source,
  $install_options             = $::nxlog::params::install_options,
  $processor_module            = $::nxlog::params::processor_module,
  $processor_template          = $::nxlog::params::processor_template,
  $processor_input_format      = $::nxlog::params::processor_input_format,
  $processor_output_format     = $::nxlog::params::processor_output_format,
  $processor_csv_output_fields = $::nxlog::params::processor_csv_output_fields,
  $route_destination           = $::nxlog::params::route_destination,
  $route_source                = $::nxlog::params::route_source,
  $route_template              = $::nxlog::params::route_template,
) inherits ::nxlog::params {
  if ($nxlog_root) {
    validate_absolute_path($nxlog_root)
  }
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
