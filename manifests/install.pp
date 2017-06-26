class perun::install (
) {
  if ! empty($perun::own_repo_class) {
    require($perun::own_repo_class)

  } elsif ($perun::use_repo == true) {
    case $::operatingsystem {
      debian:        { require perun::repo::apt }
      redhat,centos: { require perun::repo::yum }
      sles,sled:     { require perun::repo::zypp }
      default:       { fail("Unsupported OS: ${::operatingsystem}") }
    }
  }

  $_packages = delete_undef_values(flatten($perun::packages_base,$perun::packages_standard,$perun::packages_extra))

  if size($_packages)>0 {
    package { $_packages:
      ensure => $perun::ensure,
    }
  } else {
    warning('No Perun package(s) for installation')
  }
}
