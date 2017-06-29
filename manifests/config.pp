class perun::config {
  $_ensure = $perun::ensure ? {
    latest    => present,
    default   => $ensure
  }

  ssh_authorized_key { 'perunv3':
    ensure  => $_ensure,
    key     => $perun::ssh_key,
    type    => $perun::ssh_type,
    user    => $perun::user,
    options => [
      "from=\"${perun::allow_from}\"",
      'command="/opt/perun/bin/perun"',
      'no-pty',
      'no-X11-forwarding',
      'no-agent-forwarding',
      'no-port-forwarding',
      'no-user-rc'
    ],
  }

  if $perun::perun_conf {
    concat { $perun::perun_conf:
      ensure => $_ensure,
      mode   => '0644',
    }

    perun::conf { 'header':
      perun_conf => $perun::perun_conf,
      order      => 0,
      content    => '# This file is managed by Puppet!',
    }
  }
}
