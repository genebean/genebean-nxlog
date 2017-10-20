# Configures NXLog by building a config file
class nxlog::config inherits nxlog {
  concat { "${nxlog::conf_dir}/${nxlog::conf_file}":
    ensure         => present,
    ensure_newline => true,
  }

  concat::fragment { 'conf_header':
    target  => "${nxlog::conf_dir}/${nxlog::conf_file}",
    content => epp('nxlog/header.epp'),
    order   => '01',
  }

  # Ensure there is a blank line at the end of the file
  concat::fragment { 'conf_footer':
    target  => "${nxlog::conf_dir}/${nxlog::conf_file}",
    content => "\n",
    order   => '99',
  }

}

