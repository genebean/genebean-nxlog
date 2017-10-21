# Installs NXLog
class nxlog::install inherits nxlog {
  case $facts['kernel'] {
    'Linux'   : {
      package { $nxlog::package_name:
        ensure => $nxlog::ensure_setting,
      }
    }

    'Windows' : {
      package { $nxlog::package_name:
        ensure   => $nxlog::ensure_setting,
        provider => 'chocolatey',
      }
    } # end Windows

    default   : {
      # lint:ignore:80chars
      fail("The NXLog module is not yet supported on ${facts['os']['name']}")
      # lint:endignore
    }

  } # end $::kernel case
} # end class
