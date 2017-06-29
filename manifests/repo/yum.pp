class perun::repo::yum (
) {

  $_ensure = $perun::ensure ? {
    latest  => present,
    default => $perun::ensure
  }

  yum::gpgkey { $perun::gpgkey:
    ensure => $_ensure,
    source => 'puppet:///modules/perun/RPM-GPG-KEY-perunv3',
  }

  yumrepo { 'perunv3':
    enabled  => 1,
    gpgcheck => 1,
    descr    => 'Perun repository',
    baseurl  => $perun::baseurl,
    gpgkey   => "file://${perun::gpgkey}",
    require  => Yum::Gpgkey[$perun::gpgkey],
  }
}
