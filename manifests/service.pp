# == Define avahi::service
#
define avahi::service(
  $type,
  $port,
  $transport = 'tcp',
  $protocol  = 'any',
  $hostname  = undef,
) {

# The base class must be included first because it is used by parameter defaults
  if ! defined(Class['avahi']) {
    fail('You must include the avahi base class before using any avahi defined resources')
  }

  validate_re($type, '^[a-zA-z0-9-]+$')
  if ! is_numeric($port) {
    fail("${port} is not a valid port number")
  }
  validate_re($transport, '^(tcp|udp)$')
  validate_re($protocol, '^(any|ipv4|ipv6)$')

  if $hostname {
    validate_string($hostname)
  }

  $service_dir = "${::avahi::conf_dir}/services"
  $service_file = regsubst(downcase($title), '\s+', '-', 'G')

  file { "${service_dir}/${service_file}.service":
    ensure  => present,
    content => template('avahi/avahi.service.erb'),
    notify  => Service[$::avahi::service_name]
  }
}
