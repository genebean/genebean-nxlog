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
  ) {

  require ::nxlog

  concat::fragment { "output_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order_output,
    content => epp('nxlog/output.epp'),
  }
}
