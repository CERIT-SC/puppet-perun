class perun::repo::zypp (
) {

  $_ensure = $perun::ensure ? {
    latest  => present,
    default => $perun::ensure
  }

  yum::gpgkey { $perun::gpgkey:
    ensure => $_ensure,
    source => 'puppet:///modules/perun/RPM-GPG-KEY-perunv3',
  }

  zypprepo { 'perunv3':
    enabled      => 1,
    gpgcheck     => 1,
    descr        => 'Perun repository',
    baseurl      => $perun::baseurl,
    gpgkey       => "file://${perun::gpgkey}",
    type         => 'rpm-md',
    autorefresh  => 1,
    keeppackages => 0,
    require      => Yum::Gpgkey[$perun::gpgkey],
  }
}
