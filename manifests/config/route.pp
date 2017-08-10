# allow for custom route blocks
#
# Example Puppet Code:
# ::nxlog::config::route { 'Remote':
#   route_source      => ['eventlog_json'],
#   route_destination => [
#     'remote_host',
#     'local_file',
#   ],
#}
#
# Resulting output:
#
define nxlog::config::route (
  $conf_dir          = lookup('nxlog::conf_dir'),
  $conf_file         = lookup('nxlog::conf_file'),
  $order_route       = lookup('nxlog::order_route'),
  $route_destination = lookup('nxlog::route_destination'),
  $route_source      = lookup('nxlog::route_source'),
  ) {

  require ::nxlog

  concat::fragment { "route_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order_route,
    content => template('nxlog/route.erb'),
  }
}
