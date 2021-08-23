# Default settings for parameters
class nxlog::params {
  $prefix = $::kernel ? {
    'Windows' => 'win-',
    default   => '',
  }
  $conf_dir                    = undef
  $conf_file                   = undef
  $service_provider            = undef
  $header_options              = undef
  $header_template             = "nxlog/${prefix}header.erb"
  $ensure_setting              = latest
  $ext_module                  = undef
  $ext_options                 = undef
  $ext_template                = "nxlog/${prefix}extension.erb"
  $input_execs                 = []
  $input_module                = undef
  $input_file_path             = undef
  $input_type                  = undef
  $input_options               = undef
  $input_template              = "nxlog/${prefix}input.erb"
  $nxlog_root                  = undef
  $output_address              = undef
  $output_execs                = []
  $output_file_path            = undef
  $output_module               = undef
  $output_options              = undef
  $output_template             = "nxlog/${prefix}output.erb"
  $output_port                 = undef
  $package_name                = $::kernel ? {
    'Linux'   => 'nxlog-ce',
    'Windows' => 'nxlog',
    default   => 'nxlog',
  }
  $package_source              = undef
  $install_options             = undef
  $processor_module            = undef
  $processor_template          = undef
  $processor_input_format      = undef
  $processor_output_format     = undef
  $processor_csv_output_fields = []
  $route_destination           = undef
  $route_source                = undef
  $route_template              = "nxlog/${prefix}route.erb"

  # Ordering for the config fragments
  $order_header                = '01'
  $order_extension             = '05'
  $order_input                 = '10'
  $order_processor             = '30'
  $order_output                = '40'
  $order_route                 = '90'
}
