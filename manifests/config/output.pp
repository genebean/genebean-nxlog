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
  $conf_dir         = lookup('nxlog::conf_dir'),
  $conf_file        = lookup('nxlog::conf_file'),
  $order_output     = lookup('nxlog::order_output'),
  $output_address   = lookup('nxlog::output_address'),
  $output_execs     = lookup('nxlog::output_execs'),
  $output_file_path = lookup('nxlog::output_file_path'),
  $output_module    = lookup('nxlog::output_module'),
  $output_options   = lookup('nxlog::output_options'),
  $output_port      = lookup('nxlog::output_port'),
  ) {

  require ::nxlog

  concat::fragment { "output_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order_output,
    content => template('nxlog/output.erb'),
  }
}
