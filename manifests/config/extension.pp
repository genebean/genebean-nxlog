# allow for custom extension blocks
#
# Example Puppet Code:
# nxlog::config::extension { 'json':
#   ext_module  => 'om_udp',
# }
#
# Resulting output:
#
define nxlog::config::extension (
  $conf_dir        = $nxlog::conf_dir,
  $conf_file       = $nxlog::conf_file,
  $ext_module      = $nxlog::ext_module,
  $ext_options     = $nxlog::ext_options,
  $order_extension = $nxlog::order_extension,) {

  $extension_template = template('nxlog/extension.erb')

  $extension_converted = $facts['kernel'] ? {
    'Linux'   => dos2unix($extension_template),
    'Windows' => unix2dos($extension_template),
    default   => dos2unix($extension_template),
  }

  concat::fragment { "extension_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order_extension,
    content => $extension_converted,
  }
}
