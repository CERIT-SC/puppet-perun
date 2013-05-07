class perun::repo::yum (
  $ensure = $perun::params::ensure,
  $gpgkey = $perun::params::yum_gpgkey
) inherits perun::params {

  $_ensure = $ensure ? {
    latest    => present,
    installed => present,
    default   => $ensure
  }

  yum::gpgkey { $gpgkey:
    ensure => $_ensure,
    source => 'puppet:///modules/perun/RPM-GPG-KEY-perunv3',
  }

  yumrepo { 'perunv3':
    enabled  => 1,
    gpgcheck => 1,
    descr    => 'Perun repository',
    baseurl  => 'https://homeproj.cesnet.cz/rpm/perunv3/stable/noarch',
    gpgkey   => "file://${gpgkey}",
    require  => Yum::Gpgkey[$gpgkey],
  }
}
