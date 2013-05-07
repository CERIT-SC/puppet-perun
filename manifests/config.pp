class perun::config (
  $ensure,
  $user,
  $allow_from,
  $ssh_key,
  $ssh_type
) {
  $_ensure = $ensure ? {
    latest    => present,
    installed => present,
    default   => $ensure
  }

  ssh_authorized_key { 'perunv3':
    ensure  => $_ensure,
    key     => $ssh_key,
    type    => $ssh_type,
    user    => $user,
    options => [
      "from=\"${allow_from}\"",
      'command="/opt/perun/bin/perun"',
      'no-pty',
      'no-X11-forwarding',
      'no-agent-forwarding',
      'no-port-forwarding',
      'no-user-rc'
    ],
  }
}
