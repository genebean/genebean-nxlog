# allow for custom porcessor blocks
#
# Example Puppet Code:
# ::nxlog::config::processor { 'tranformer':
#   processor_module  => 'pm_transformer',
#   processor_input_format    => 'syslog_rfc3164',
#   processor_output_format   => 'csv',
#   processor_csv_output_fields => [
#     '$facility',
#     '$severity',
#     '$timestamp',
#     '$hostname',
#     '$application',
#     '$pid',
#     '$message',
#   ],
# }
#
# Resulting output:
#
define nxlog::config::processor (
  $conf_dir                    = $::nxlog::conf_dir,
  $conf_file                   = $::nxlog::conf_file,
  $order_processor             = $::nxlog::order_output,
  $processor_module            = $::nxlog::processor_module,
  $processor_template          = $::nxlog::processor_template,
  $processor_input_format      = $::nxlog::processor_input_format,
  $processor_output_format     = $::nxlog::processor_output_format,
  $processor_csv_output_fields = $::nxlog::processor_csv_output_fields,
  ) {
  if !$processor_template and $processor_module  {
    $real_processor_template = $processor_module ? {
      'pm_transformer' => "nxlog/processor/${$::nxlog::params::prefix}transformer.erb",
      default          => undef,
    }
    if (!is_array($processor_csv_output_fields)) {
      fail('processor_csv_output_fields must be an array.')
    }
  } else {
    $real_processor_template = $processor_template
  }

  if ($real_processor_template == undef ) {
    fail("A template for ${processor_module} has not been created yet.")
  }

  concat::fragment { "processor_${name}":
    target  => "${conf_dir}/${conf_file}",
    order   => $order_processor,
    content => template($real_processor_template),
  }
}
