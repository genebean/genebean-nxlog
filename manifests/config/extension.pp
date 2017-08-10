# allow for custom extension blocks
#
# Example Puppet Code:
# ::nxlog::config::extension { 'json':
#   ext_module  => 'om_udp',
# }
#
# Resulting output:
#
define nxlog::config::extension (
  $conf_dir        = lookup('nxlog::conf_dir'),
  $conf_file       = lookup('nxlog::conf_file'),
  $ext_module      = lookup('nxlog::ext_module'),
  $ext_options     = lookup('nxlog::ext_options'),
  $order_extension = lookup('nxlog::order_extension'),
  ) {

  require ::nxlog

  concat::fragment { "extension_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order_extension,
    content => template('nxlog/extension.erb'),
  }
}
