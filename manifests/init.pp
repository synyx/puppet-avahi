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
  $package_name       = $::avahi::params::package_name,
  $service_name       = $::avahi::params::service_name,
  $avahi_hostname     = $::hostname,
  $avahi_domainname   = 'local',
  $allow_interfaces   = [],
  $deny_interfaces    = [],
  $enable_reflector   = false,
  $enable_p2p         = false,
  $enable_wide_area   = true,
  $conf_dir           = $::avahi::params::conf_dir,
  $daemon_config_file = $::avahi::params::daemon_config_file,
) inherits avahi::params {

  validate_string($avahi_hostname)
  validate_string($avahi_domainname)
  validate_array($allow_interfaces)
  validate_array($deny_interfaces)
  validate_bool($enable_reflector)
  validate_bool($enable_p2p)
  validate_bool($enable_wide_area)

  class { 'avahi::install': } ->
  class { 'avahi::config': } ~>
  class { 'avahi::daemon': } ->
  Class['avahi']
}
