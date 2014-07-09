# Puppet Perun module

This module installs [Perun](http://perun.metacentrum.cz/) slave
scripts and configures remote access to these management scripts
from server.

### Requirements

Module has been tested on:

* Puppet 3.5
* OS:
 * Debian 6,7
 * RHEL/CentOS 6
 * SLES/SLED 11 SP3

Required modules:

* yum (https://github.com/CERIT-SC/puppet-yum)
* stdlib (https://github.com/puppetlabs/puppetlabs-stdlib)

# Quick Start

Setup client

```puppet
include perun
```

Full configuration options:

```puppet
class { 'perun':
  ensure         => present|absent|latest,   # ensure state
  user           => 'root',                  # local privileged user
  allow_from     => 'foo.example.com',       # enabled remote Perun server name
  ssh_type       => 'ssh-rsa' or 'ssh-dss',  # SSH key type
  ssh_key        => '...',                   # SSH key
  perun_conf     => '...',                   # Perun configuration file
  packages       => [..],                    # list of packages for install
  use_repo       => false|true,              # include external repository
  own_repo_class => '...',                   # use own repository class
  require_class  => '...',                   # custom required class
}
```

### Configuration override

Some configuration can be sourced from `/etc` (typically
`/etc/perunv3.conf`). Definition `perun::conf` allows
to specify these changes in form of shell script snippets.

Full configuration options:

```puppet
perun::conf { 'name':
  ensure     => present|absent,              # ensure state
  order      => number,                      # location in file
  content    => '...',                       # configuration script
  perun_conf => '...',                       # configuration file
}
```

Example:

```puppet
perun::conf { 'service_blacklist':
  ensure  => present,
  content => 'SERVICE_BLACKLIST=(passwd)',
}
```

### Hooks

Hooks are executed before, during or after particular
service propagation. Hook content is a shell script.

Full configuration options:

```puppet
perun::hook { 'hook_name':
  ensure    => present|absent,               # ensure state
  service   => '...',                        # Perun service name
  type      => 'pre' or 'post' or 'mid',     # execution time
  content   => '...',                        # commands to run
  perun_dir => '...',                        # parent directory of hooks
}
```

Example:

```puppet
perun::hook { 'passwd_mail':
  ensure  => present,
  service => 'passwd',
  type    => 'post',
  content => 'echo | mail -s "Perun done on passwd" root',
}
```
