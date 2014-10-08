# == Class: avahi
#
# Full description of class avahi here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class avahi (
  $package_name = $avahi::params::package_name,
  $service_name = $avahi::params::service_name,
) inherits avahi::params {

  # validate parameters here

  class { 'avahi::install': } ->
  class { 'avahi::config': } ~>
  class { 'avahi::service': } ->
  Class['avahi']
}
