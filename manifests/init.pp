class perun (
  $ensure     = $perun::params::ensure,
  $user       = $perun::params::user,
  $allow_from = $perun::params::allow_from,
  $ssh_key    = $perun::params::ssh_key,
  $ssh_type   = $perun::params::ssh_type,
  $packages   = $perun::params::packages,
  $use_repo   = $perun::params::use_repo
) inherits perun::params {

  if ! ($ensure in [present,absent,latest]) {
    fail("Invalid ensure state: ${ensure}")
  }

  class { 'perun::install':
    ensure   => $ensure,
    packages => $packages,
    use_repo => $use_repo,
  }

  class { 'perun::config':
    ensure     => $ensure,
    user       => $user,
    allow_from => $allow_from,
    ssh_key    => $ssh_key,
    ssh_type   => $ssh_type,
  }

  anchor { 'perun::begin': ; }
    -> Class['perun::install']
    -> Class['perun::config']
    -> anchor { 'perun::end': ; }
}
