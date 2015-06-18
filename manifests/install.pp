# Installs NXLog
class nxlog::install ($ensure_setting = $::nxlog::ensure_setting,) {
  case $::kernel {
    'Linux'   : {
      package { 'nxlog':
        ensure => $ensure_setting,
      }
    }

    'Windows' : {
      package { 'nxlog':
        ensure   => $ensure_setting,
        provider => 'chocolatey',
      }
    } # end Windows

    default   : {
      # lint:ignore:80chars
      fail("The NXLog module is not yet supported on this ${::operatingsystem}")
      # lint:endignore
    }

  } # end $::kernel case
} # end class
