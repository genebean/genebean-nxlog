# Installs NXLog
class nxlog::install (
  $ensure_setting = $::nxlog::ensure_setting,
  $package_name   = $::nxlog::package_name,
  $package_source = $::nxlog::package_source,
  $install_options = $::nxlog::install_options,
  ) {
  case $::kernel {
    'Linux'   : {
      package { $package_name:
        ensure => $ensure_setting,
      }
    }
    'Windows' : {
      if $package_source {
        $real_provider = 'windows'
      } else {
        $real_provider = 'chocolatey'
      }
      package { $package_name:
        ensure          => $ensure_setting,
        provider        => $real_provider,
        source          => $package_source,
        install_options => $install_options,
      }
    } # end Windows

    default   : {
      # lint:ignore:80chars
      fail("The NXLog module is not yet supported on this ${::operatingsystem}")
      # lint:endignore
    }

  } # end $::kernel case
} # end class
