class perun::install (
  $ensure,
  $packages,
  $use_repo,
  $own_repo_class,
) {
  if $own_repo_class != '' {
    require($own_repo_class)

  } elsif ($use_repo == true) {
    case $::operatingsystem {
      debian:        { require perun::repo::apt }
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
