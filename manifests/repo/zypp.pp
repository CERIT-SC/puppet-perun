class perun::repo::zypp (
  $ensure  = $perun::params::ensure,
  $baseurl = $perun::params::baseurl,
  $gpgkey  = $perun::params::gpgkey
) inherits perun::params {

  $_ensure = $ensure ? {
    latest  => present,
    default => $ensure
  }

  yum::gpgkey { $gpgkey:
    ensure => $_ensure,
    source => 'puppet:///modules/perun/RPM-GPG-KEY-perunv3',
  }

  zypprepo { 'perunv3':
    enabled      => 1,
    gpgcheck     => 1,
    descr        => 'Perun repository',
    baseurl      => $baseurl,
    gpgkey       => "file://${gpgkey}",
    type         => 'rpm-md',
    autorefresh  => 1,
    keeppackages => 0,
    require      => Yum::Gpgkey[$gpgkey],
  }
}
