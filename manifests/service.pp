# Controls the NXLog service
class nxlog::service {
  case $::operatingsystem {
    'Windows' : {
      service { 'nxlog':
        ensure => 'running',
        enable => true,
      }
    } # end Windows

    default   : {
      fail("The NXLog module is not yet supported on this ${::operatingsystem}")
    }

  } # end $::operatingsystem case
} # end class
