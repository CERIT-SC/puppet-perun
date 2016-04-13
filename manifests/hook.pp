define perun::hook (
  $service,
  $type,
  $content,
  $hookname  = $title,
  $ensure    = $perun::ensure,
  $perun_dir = $perun::params::perun_dir
) {
  if ! ($type in ['pre','post','mid']) {
    fail("Invalid type: ${type}")
  }

  # ensure hook
  $_ensure_f = $ensure ? {
    latest  => file,
    present => file,
    default => $ensure,
  }

  # create directory for service hooks
  if ($_ensure_f == file) and
    (! defined(File["${perun::params::perun_dir}/${service}.d"])
  {
    file { "${perun::params::perun_dir}/${service}.d":
      ensure  => directory,
      require => Class['perun::install'],
    }
  }

  # ensure hook
  file { "${perun::params::perun_dir}/${service}.d/${type}_${hookname}":
    ensure  => $_ensure_f,
    content => "# This file is managed by Puppet!
${content}",
    require => Class['perun::install'],
    notify  => Class['perun::service'],
  }
}
