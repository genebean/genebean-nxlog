# Class: nxlog
#
# This module manages nxlog. See README.md for more details.
#
class nxlog (
  Optional[Stdlib::Absolutepath] $conf_dir,
  Optional[String] $conf_file,
  $ensure_setting,
  $ext_module,
  $ext_options,
  $input_execs,
  $input_file_path,
  $input_module,
  $input_type,
  Optional[Stdlib::Absolutepath] $nxlog_root,
  $order_extension,
  $order_header,
  $order_input,
  $order_output,
  $order_route,
  $output_address,
  $output_execs,
  $output_file_path,
  $output_module,
  $output_options,
  $output_port,
  $package_name,
  $processor_module,
  $processor_input_format,
  $processor_output_format,
  $processor_csv_output_fields,
  $route_destination,
  $route_source,
) {

  contain ::nxlog::install
  contain ::nxlog::config
  contain ::nxlog::service

  Class['::nxlog::install']
  -> Class['::nxlog::config']
  ~> Class['::nxlog::service']
}
