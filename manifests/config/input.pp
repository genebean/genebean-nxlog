# allow for custom input blocks
#
# Example Puppet Code:
# ::nxlog::input { 'sawyer':
#   output_module  => 'im_msvistalog',
#   input_execs    => [
#     'delete($Keywords)',
#     '$raw_event = to_json()',
#   ],
# }
#
# Resulting output:
#
define nxlog::config::input (
  $conf_dir     = $::nxlog::conf_dir,
  $conf_file    = $::nxlog::conf_file,
  $order        = '10',
  $input_module = undef,
  $input_execs  = [],
  concat::fragment { "input_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order,
    content => template('nxlog/input.erb'),
  }
}
