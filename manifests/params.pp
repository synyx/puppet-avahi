# == Class avahi::params
#
# This class is meant to be called from avahi
# It sets variables according to platform
#
class avahi::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'avahi'
      $service_name = 'avahi'
    }
    'RedHat', 'Amazon': {
      $package_name = 'avahi'
      $service_name = 'avahi'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
