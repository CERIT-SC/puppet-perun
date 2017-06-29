class perun::repo::apt {
  $_ensure = $perun::ensure ? {
    latest  => present,
    default => $perun::ensure
  }

  apt::key { 'meta':
    ensure      => $_ensure,
    key         => 'C3C8B519',
    key_content => template('perun/meta.gpg.erb'),
  }

  Apt::Source {
    ensure      => $_ensure,
    location    => $perun::baseurl,
    repos       => $perun::repos,
    include_src => false,
    require     => Apt::Key['meta'],
  }

  apt::source { 'meta_depot_all':
    release => 'all',
  }

  apt::source { 'meta_depot':
    release => $::lsbdistcodename,
  }

  if $pin != false {
    apt::pin { 'meta_depot':
      ensure     => $_ensure,
      originator => 'meta@cesnet.cz,a=stable',
      priority   => $perun::pin,
    }
  }
}
