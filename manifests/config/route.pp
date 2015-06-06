# allow for custom route blocks
#
# Example Puppet Code:
# ::nxlog::route { 'Remote':
#   route_source      => ['eventlog_json'],
#   route_destination => [
#     'remote_host',
#     'local_file',
#   ],
# }
#
# Resulting output:
#
define nxlog::config::route (
  $conf_dir          = $::nxlog::conf_dir,
  $conf_file         = $::nxlog::conf_file,
  $order             = '90',
  $route_source      = [],
  $route_destination = [],
  concat::fragment { "route_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order,
    content => template('nxlog/route.erb'),
  }
}
