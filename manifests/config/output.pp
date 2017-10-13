# allow for custom output blocks
#
# Example Puppet Code:
# ::nxlog::config::output { 'sawyer':
#   output_address => 'logserver.example.com',
#   output_module  => 'om_udp',
#   output_port    => '6371',
# }
#
# ::nxlog::config::output { 'local':
#   output_file_path => 'C:/local.log',
#   output_module    => 'om_file',
# }
#
# Resulting output:
#
define nxlog::config::output (
  $conf_dir         = $::nxlog::conf_dir,
  $conf_file        = $::nxlog::conf_file,
  $order_output     = $::nxlog::order_output,
  $output_address   = $::nxlog::output_address,
  $output_execs     = $::nxlog::output_execs,
  $output_file_path = $::nxlog::output_file_path,
  $output_module    = $::nxlog::output_module,
  $output_options   = $::nxlog::output_options,
  $output_template  = $::nxlog::output_template,
  $output_port      = $::nxlog::output_port,
  ) {
  concat::fragment { "output_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order_output,
    content => template($output_template),
  }
}
