# Controls the NXLog service
class nxlog::service ($ensure_setting = $::nxlog::ensure_setting,) {
  case $::kernel {
    'Linux', 'Windows' : {
      unless ($ensure_setting =~ /absent/) {
        service { 'nxlog':
          ensure => 'running',
          enable => true,
        }
      }
    } # end Windows

    default            : {
      fail("The NXLog module is not yet supported on this ${::operatingsystem}")
    }

  } # end $::operatingsystem case
} # end class
