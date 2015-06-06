# allow for custom output blocks
#
# Example Puppet Code:
# ::nxlog::custom_output { 'sawyer':
#   output_address => 'logserver.example.com',
#   output_module  => 'om_udp',
#   output_port    => '6371',
#}
#
# Resulting output:
#
define nxlog::config::output (
  $conf_dir         = $::nxlog::conf_dir,
  $conf_file        = $::nxlog::conf_file,
  $order            = '40',
  $output_address   = undef,
  $output_file_path = undef,
  $output_module    = undef,
  $output_name      = undef,
  $output_port      = undef,) {
  concat::fragment { "output_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order,
    content => template('nxlog/output.erb'),
  }
}
