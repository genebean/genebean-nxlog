# Default settings for parameters
class nxlog::params {
  $conf_dir            = undef
  $conf_file           = undef
  $ensure_setting      = latest
  $output_host_address = undef
  $output_host_module  = 'om_udp'
  $output_host_name    = undef
  $output_host_port    = undef
  $output_local        = false
  $output_local_path   = undef
  $output_remote       = true
  $route_host_name     = undef
  $route_host_dest     = undef
  $route_host_source   = undef
}
