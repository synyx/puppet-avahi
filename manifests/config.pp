# == Class avahi::config
#
# This class is called from avahi
#
class avahi::config (
  $avahi_hostname     = $::avahi::avahi_hostname,
  $avahi_domainname   = $::avahi::avahi_domainname,
  $allow_interfaces   = $::avahi::allow_interfaces,
  $deny_interfaces    = $::avahi::deny_interfaces,
  $enable_reflector   = $::avahi::enable_reflector,
  $enable_p2p         = $::avahi::enable_p2p,
  $enable_wide_area   = $::avahi::enable_wide_area,
  $conf_dir           = $::avahi::conf_dir,
  $daemon_config_file = $::avahi::daemon_config_file,
) {
  file { $conf_dir:
    ensure => directory
  }

  file { "${conf_dir}/${daemon_config_file}":
    mode    => '0644',
    content => template('avahi/avahi-daemon.conf.erb')
  }
}
