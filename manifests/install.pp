# Installs NXLog
class nxlog::install ($ensure_setting = $::nxlog::ensure_setting,) {
  case $::operatingsystem {
    'Windows' : {
      package { 'nxlog':
        ensure   => $ensure_setting,
        provider => 'chocolatey',
      }
    } # end Windows

    default   : {
      fail("The NXLog module is not yet supported on this ${::operatingsystem}")
    }

  } # end $::operatingsystem case
} # end class
