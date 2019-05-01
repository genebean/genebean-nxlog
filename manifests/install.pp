# Installs NXLog
class nxlog::install (
  $ensure_setting = $nxlog::ensure_setting,
  $package_name   = $nxlog::package_name,
  ) {
  case $facts['kernel'] {
    'Linux'   : {
      package { $package_name:
        ensure => $ensure_setting,
      }
    }

    'Windows' : {
      package { $package_name:
        ensure   => $ensure_setting,
        provider => 'chocolatey',
      }
    } # end Windows

    default   : {
      # lint:ignore:80chars
      fail("The NXLog module is not yet supported on ${facts['os']['name']}")
      # lint:endignore
    }

  } # end $facts['kernel'] case
} # end class
