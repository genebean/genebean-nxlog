# Controls the NXLog service
class nxlog::service (
  $conf_dir   = $::nxlog::conf_dir,
  $conf_file  = $::nxlog::conf_file,
  $ensure_setting = $nxlog::ensure_setting,
  ) {
  case $::kernel {
    'Linux', 'Windows' : {
      unless ($ensure_setting =~ /absent/) {
        service { 'nxlog':
          ensure    => 'running',
          enable    => true,
          subscribe => Concat["${conf_dir}/${conf_file}"],
        }
      }
    } # end Windows

    default            : {
      # lint:ignore:80chars
      fail("The NXLog module is not yet supported on this ${::operatingsystem}")
      # lint:endignore
    }

  } # end $::operatingsystem case
} # end class
