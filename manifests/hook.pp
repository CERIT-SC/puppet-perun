define perun::hook (
  $service,
  $type,
  $content,
  $hookname  = $title,
  $ensure    = $perun::params::ensure,
  $perun_dir = $perun::params::perun_dir
) {
  require perun

  if ! ($type in ['pre','post','mid']) {
    fail("Invalid type: ${type}")
  }

  $_ensure = $ensure ? {
    latest  => file,
    present => file,
    default => $ensure,
  }

  file { "${perun::params::perun_dir}/${service}.d/${type}_${hookname}":
    ensure  => $_ensure,
    content => $content,
  }
}
