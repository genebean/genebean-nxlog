# allow for custom extension blocks
#
# Example Puppet Code:
# ::nxlog::extension { 'json':
#   ext_module  => 'om_udp',
#}
#
# Resulting output:
#
define nxlog::extension (
  $conf_dir   = $::nxlog::conf_dir,
  $conf_file  = $::nxlog::conf_file,
  $order      = '05',
  $ext_module = undef,) {
  concat::fragment { "extension_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order,
    content => template('nxlog/extension.erb'),
  }
}
