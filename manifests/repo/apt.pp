class perun::repo::apt (
  $ensure  = $perun::params::ensure,
  $baseurl = $perun::params::baseurl,
  $repos   = $perun::params::apt_repos,
  $pin     = $perun::params::apt_pin,
) inherits perun::params {

  $_ensure = $ensure ? {
    latest  => present,
    default => $ensure
  }

  apt::key { 'meta':
    ensure      => $_ensure,
    key         => 'C3C8B519',
    key_content => template('perun/meta.gpg.erb'),
  }

  Apt::Source {
    ensure      => $_ensure,
    location    => $baseurl,
    repos       => $repos,
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
      priority   => $pin,
    }
  }
}
