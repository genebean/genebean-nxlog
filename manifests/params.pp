# Default settings for parameters
class nxlog::params {
  $conf_dir          = undef
  $conf_file         = undef
  $ensure_setting    = latest
  $ext_module        = undef
  $ext_options       = undef
  $input_execs       = []
  $input_module      = undef
  $input_file_path   = undef
  $nxlog_root        = undef
  $output_address    = undef
  $output_file_path  = undef
  $output_module     = undef
  $output_port       = undef
  $route_destination = undef
  $route_source      = undef

  # Ordering for the config fragments
  $order_header      = '01'
  $order_extension   = '05'
  $order_input       = '10'
  $order_output      = '40'
  $order_route       = '90'
}
