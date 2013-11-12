# Puppet Perun module

This module installs [Perun](http://perun.metacentrum.cz/) slave
scripts and configures remote access to these management scripts
from server.

### Requirements

Module has been tested on:

* Puppet 3.1
* OS:
 * Debian 6
 * RHEL/CentOS 6
 * SLES/SLED 11 SP3

Required modules:

* yum (https://github.com/CERIT-SC/puppet-yum)
* stdlib (https://github.com/puppetlabs/puppetlabs-stdlib)

# Quick Start

Setup client

    include perun

Full configuration options:

    class { 'perun':
      ensure     => present|absent|latest,    # ensure state
      user       => 'root',                   # local privileged user
      allow_from => 'foo.example.com',        # enabled remote Perun server name
      ssh_type   => 'ssh-rsa' or 'ssh-dss',   # SSH key type
      ssh_key    => '...',                    # SSH key
      use_repo   => false|true,               # include external repository
      packages   => [..],                     # list of packages for install
    }
