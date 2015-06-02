# Configures NXLog by building a config file
class nxlog::config (
  $conf_dir      = $::nxlog::conf_dir,
  $conf_file     = $::nxlog::conf_file,
  $output_local  = $::nxlog::output_local,
  $output_remote = $::nxlog::output_remote,) {
  concat { "${conf_dir}/${conf_file}":
    ensure         => present,
    ensure_newline => true,
    warn           => true,
  }

  concat::fragment { 'conf_header':
    target => "${conf_dir}/${conf_file}",
    source => 'puppet:///modules/nxlog/conf_header.txt',
    order  => '01',
  }

  concat::fragment { 'conf_ext_json':
    target => "${conf_dir}/${conf_file}",
    source => 'puppet:///modules/nxlog/conf_ext_json.txt',
    order  => '05',
  }

  concat::fragment { 'conf_in_eventlog_json':
    target => "${conf_dir}/${conf_file}",
    source => 'puppet:///modules/nxlog/conf_in_eventlog_json.txt',
    order  => '10',
  }

  if ($output_local) {
    concat::fragment { 'conf_output_local':
      target  => "${conf_dir}/${conf_file}",
      content => template('nxlog/conf_output_local_json.erb'),
      order   => '90',
    }
  }

  if ($output_remote) {
    concat::fragment { 'conf_output_host':
      target  => "${conf_dir}/${conf_file}",
      content => template('nxlog/conf_output_host.erb'),
      order   => '90',
    }
  }

}
