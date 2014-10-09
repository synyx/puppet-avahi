[![Build Status](https://travis-ci.org/synyx/puppet-avahi.png)](https://travis-ci.org/synyx/puppet-avahi)

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with avahi](#setup)
    * [What avahi affects](#what-avahi-affects)
    * [Beginning with avahi](#beginning-with-avahi)
    * [Advanced configuration](#advanced-configuration)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The avahi module allows to set up a mDNS responder for your local network
and manage the announced services with simple definitions.

##Module Description

Avahi is the most widely used implementation of Multicast DNS on Linux based
systems. This module manages the setup & configuration of the server component
of the Avahi toolkit.

##Setup

###What avahi affects

* Package, service & configuration files for avahi-daemon

###Beginning with avahi

To install the Avahi daemon with default parameters

```puppet
    class { 'avahi': }
```

The defaults – like for example the announced hostname – are determined by the
facts provided by puppet or derived from operating system dependent facts. The
defaults are usually sufficient for production environments, though without
additional service definitions Avahi does not usually do much by itself.

###Advanced configuration

A typical use case for bigger network installations, is the ability to forward
mDNS announcements between two or more IP networks. Since multicast DNS is
specified to be link-local, the easiest way to do so, is to setup an Avahi
daemon on a machine, which resides in all those networks (for example DHCP server).

To make Avahi daemon forward multicast DNS between two networks on different
network interfaces

```puppet
  class { 'avahi':
    allow_interfaces => ['eth1', 'eth2'],
    enable_reflector => true
  }
```

##Usage

###Classes and Defined Types

####Class: `avahi`

The primary class of the `avahi` module. It orchestrates the setup of the
daemon package and it's configuration on the system. The corresponding
configuration settings can also be looked up in the [`avahi-daemon documentation](http://avahi.org/download/avahi-daemon.conf.5.xml)

**Parameters within `avahi`:**

#####`avahi_hostname`

This sets the default for the hostname announced via mDNS. This also becomes
the default for service declarations that don't define a hostname themselves.
Defaults to the value of `$::hostname` from `facter`.

#####`avahi_domainname`

The mDNS domain name, under which services are announced. Defaults to `local`.
   
#####`allow_interfaces`

When given, make `avahi-daemon` only listen & broadcast on the specified interfaces.

#####`deny_interfaces`

When given, make `avahi-daemon` ignore the specified interfaces and not listen
or broadcast on the given interfaces at all.


#####`enable_reflector`

When set to `true`, let `avahi-daemon` act as a mDNS repeater between all the networks,
which it is connected to. Combined with `allow_interfaces` or `deny_interfaces`, this
allows you to bridge, for example, mDNS announcement from a printer-only network to the
user machine network.

####Defined Type: `avahi::service`

Next to the services announced by default (often DBUS-aware software), this class allows
to explicitly announce other services via mDNS, either on the host itself or even on behalf
of other hosts. The `title` for this defined type will be used as the human readable name.

**Parameters within `avahi::service`**

#####`type`

The type of service to be announced. This is usually corresponding to an entry in
`/etc/protocols` and is used (in conjunction with `transport`) by mDNS browsing
software to determine the actions available to the user.

#####`port`

The TCP or UDP port providing this service.

#####`transport

The transport protocol for this particular service. This can be either `tcp` (the default)
or `udp`.

#####`protocol`

The IP protocol(s) available to reach this service. This can be either `any` (the default),
`ipv4` (only available via IPv4) or `ipv6` (only available via IPv6).

#####`hostname`

The fully qualified hostname on which the service is running. This is used, when announcing
services on behalf of another machine or device, which itself is not capable of announcing
mDNS services to the network. If not given, the service is announced for the machine running
`avahi-daemon` itself.

##Limitations

The module is currently only tested on Debian & Puppet 3.7.

##Development

Pull requests are welcome, but right now we doubt anyone will start using it, since it is
very limited.
