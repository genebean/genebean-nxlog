# Controls the NXLog service
class nxlog::service inherits nxlog {
  case $facts['kernel'] {
    'Linux', 'Windows' : {
      unless ($nxlog::ensure_setting =~ /absent/) {
        service { 'nxlog':
          ensure    => 'running',
          enable    => true,
          subscribe => Concat["${nxlog::conf_dir}/${nxlog::conf_file}"],
        }
      }
    } # end Windows

    default            : {
      # lint:ignore:80chars
      fail("The NXLog module is not yet supported on ${facts['os']['name']}")
      # lint:endignore
    }

  } # end $::operatingsystem case
} # end class
