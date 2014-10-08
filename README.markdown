####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with avahi](#setup)
    * [What avahi affects](#what-avahi-affects)
    * [Beginning with avahi](#beginning-with-avahi)
    * [Advanced configuration](#advanced-configuration)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
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

TBD

##Limitations

The module is currently only tested on Debian & Puppet 3.7.

##Development

Pull requests are welcome, but right now we doubt anyone will start using it, since it is
very limited.