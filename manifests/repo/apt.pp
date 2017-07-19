class perun::repo::apt {
  $_ensure = $perun::ensure ? {
    latest  => present,
    default => $perun::ensure
  }

  apt::key { 'meta':
    ensure      => $_ensure,
    key         => 'F11383F552848522E4EACA443573FD94A385CDB0',
    key_content => template('perun/meta.gpg.erb'),
  }

  Apt::Source {
    ensure      => $_ensure,
    location    => $perun::baseurl,
    repos       => $perun::repos,
    include_src => false,
    require     => Apt::Key['meta'],
  }

  apt::source { 'meta_repo_all':
    release => 'all',
  }

  apt::source { 'meta_repo':
    release => $::lsbdistcodename,
  }

  if $pin != false {
    apt::pin { 'meta_repo':
      ensure     => $_ensure,
      originator => 'meta@cesnet.cz,a=stable',
      priority   => $perun::pin,
    }
  }
}
