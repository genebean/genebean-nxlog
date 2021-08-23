# allow for custom input blocks
#
# Example Puppet Code:
# ::nxlog::config::input { 'sawyer':
#   input_module  => 'im_msvistalog',
#   input_execs    => [
#     'delete($Keywords)',
#     '$raw_event = to_json()',
#   ],
# }
#
# Resulting output:
#
define nxlog::config::input (
  $conf_dir        = $::nxlog::conf_dir,
  $conf_file       = $::nxlog::conf_file,
  $input_execs     = $::nxlog::input_execs,
  $input_file_path = $::nxlog::input_file_path,
  $input_module    = $::nxlog::input_module,
  $input_type      = $::nxlog::input_type,
  $input_options   = $::nxlog::input_options,
  $input_template  = $::nxlog::input_template,
  $order_input     = $::nxlog::order_input,
  ) {

  concat::fragment { "input_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order_input,
    content => template($input_template),
  }
}
