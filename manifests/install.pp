class perun::install (
  $ensure,
  $packages,
  $use_repo
) {
  if ($use_repo == true) {
    case $::operatingsystem {
      debian:        { }
      redhat,centos: { require perun::repo::yum }
      sles,sled:     { require perun::repo::zypp }
      default:       { fail("Unsupported OS: ${::operatingsystem}") }
    }
  }

  if size($packages)>0 {
    package { $packages:
      ensure => $ensure,
    }
  } else {
    warning('No Perun package(s) for installation')
  }
}
