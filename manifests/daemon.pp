# == Class avahi::daemon
#
# This class is meant to be called from avahi
# It ensure the service is running
#
class avahi::daemon {

  service { $::avahi::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => false,
    hasrestart => true,
  }
}
