# == Class avahi::install
#
class avahi::install {

  package { $avahi::package_name:
    ensure => present,
  }
}
