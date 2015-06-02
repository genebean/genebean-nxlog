# allow for custom input blocks
define nxlog::custom_input (
  $conf_dir  = $::nxlog::conf_dir,
  $conf_file = $::nxlog::conf_file,
  $content   = '',
  $order     = '20') {
  concat::fragment { "custom_input_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order,
    content => $content,
  }
}

