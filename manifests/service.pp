# == Class avahi::service
#
# This class is meant to be called from avahi
# It ensure the service is running
#
class avahi::service {

  service { $::avahi::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
