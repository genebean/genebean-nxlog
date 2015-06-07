# allow for custom extension blocks
#
# Example Puppet Code:
# ::nxlog::extension { 'json':
#   ext_module  => 'om_udp',
#}
#
# Resulting output:
#
define nxlog::config::extension (
  $conf_dir        = $::nxlog::conf_dir,
  $conf_file       = $::nxlog::conf_file,
  $ext_module      = $::nxlog::ext_module,
  $order_extension = $::nxlog::order_extension,) {
  concat::fragment { "extension_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order_extension,
    content => template('nxlog/extension.erb'),
  }
}
