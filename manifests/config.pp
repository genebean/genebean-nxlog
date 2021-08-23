# Configures NXLog by building a config file
class nxlog::config (
  $conf_dir        = $::nxlog::conf_dir,
  $conf_file       = $::nxlog::conf_file,
  $header_template = $::nxlog::header_template,
  $header_options  = $::nxlog::header_options,
  $nxlog_root      = $::nxlog::nxlog_root,
  ) {
  concat { "${conf_dir}/${conf_file}":
    ensure         => present,
    ensure_newline => true,
  }
  $content = $::kernel ? {
    'Windows' => "\r\n",
    default   => "\n",
  }
  concat::fragment { 'conf_header':
    target  => "${conf_dir}/${conf_file}",
    content => template($header_template),
    order   => '01',
  }

  # Ensure there is a blank line at the end of the file
  concat::fragment { 'conf_footer':
    target  => "${conf_dir}/${conf_file}",
    content => $content,
    order   => '99',
  }

}

