class resqueweb (
  $ensure         = $::resqueweb::params::ensure,
  $package_name   = $::resqueweb::params::package_name,
  $package_ensure = $::resqueweb::params::package_ensure,
  $service_name   = $::resqueweb::params::service_name,
  $service_manage = $::resqueweb::params::service_manage,
  $service_enable = $::resqueweb::params::service_enable,
  $service_ensure = $::resqueweb::params::service_ensure
) inherits resqueweb::params {
  case $ensure {
    'absent': {
      if $service_manage {
        service { $service_name:
          ensure => 'stopped'
        }

        Service[$service_name] -> Package[$package_name]
      }

      package { $package_name:
        ensure => $ensure
      }
    }
    'present': {
      package { $package_name:
        ensure => $package_ensure
      }

      if $service_manage {
        service { $service_name:
          ensure => $service_ensure,
          enable => $service_enable
        }
      }

      Package[$package_name] -> Service[$service_name]
    }
    default: {
      fail("Invalid value ${ensure} passed for parameter ensure. Value should be present or absent")
    }
  }
}
