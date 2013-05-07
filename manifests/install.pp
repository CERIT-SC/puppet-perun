class perun::install (
  $ensure,
  $packages,
  $use_repo
) {
  if ($use_repo == true) {
    case $::operatingsystem {
      debian:         { } #TODO
      redhat,centos:  { require perun::repo::yum }
      default:        { fail("Unsupported OS: ${::operatingsystem}") }
    }
  }

  if size($packages)>0 {
    package { $packages:
      ensure  => $ensure,
    }
  } else {
    warning('No Perun package(s) for installation')
  }
}
