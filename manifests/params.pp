# == Class resqueweb::params
#
# This class is meant to be called from resqueweb.
# It sets variables according to platform.
#
class resqueweb::params {
  case $::operatingsystem {
    'Ubuntu': {
      case $::operatingsystemrelease {
        '14.04': {
          $ensure = 'present'
          $package_name   = 'resque-web'
          $package_ensure = 'present'
          $service_manage = true
          $service_name   = true
          $service_enable = true
          $service_ensure = 'running'
        }
        default: {
          fail("Ubuntu ${::operatingsystemrelease} not supported")
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
