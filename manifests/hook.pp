define perun::hook (
  $service,
  $type,
  $content,
  $hookname  = $title,
  $ensure    = $perun::params::ensure,
  $perun_dir = $perun::params::perun_dir
) {
  if ! ($type in ['pre','post','mid']) {
    fail("Invalid type: ${type}")
  }

  # ensure directory with service hooks
  if ! defined(File["${perun::params::perun_dir}/${service}.d"]) {
    $_ensure_d = $ensure ? {
      latest  => directory,
      present => directory,
      default => $ensure,
    }

    file { "${perun::params::perun_dir}/${service}.d":
      ensure => $_ensure_d,
    }
  }

  # ensure hook
  $_ensure_f = $ensure ? {
    latest  => file,
    present => file,
    default => $ensure,
  }

  file { "${perun::params::perun_dir}/${service}.d/${type}_${hookname}":
    ensure  => $_ensure_f,
    content => "# This file is managed by Puppet!
${content}",
    require => Class['perun::install'],
    notify  => Class['perun::service'],
  }
}
