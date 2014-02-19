class perun (
  $ensure         = $perun::params::ensure,
  $user           = $perun::params::user,
  $allow_from     = $perun::params::allow_from,
  $ssh_key        = $perun::params::ssh_key,
  $ssh_type       = $perun::params::ssh_type,
  $packages       = $perun::params::packages,
  $use_repo       = $perun::params::use_repo,
  $own_repo_class = $perun::params::own_repo_class
) inherits perun::params {

  if ! ($ensure in [present,absent,latest]) {
    fail("Invalid ensure state: ${ensure}")
  }

  validate_string($user, $allow_from, $ssh_key, $ssh_type)
  validate_array($packages)
  validate_bool($use_repo)

  class { 'perun::config':
    ensure     => $ensure,
    user       => $user,
    allow_from => $allow_from,
    ssh_key    => $ssh_key,
    ssh_type   => $ssh_type,
  }

  class { 'perun::install':
    ensure         => $ensure,
    packages       => $packages,
    use_repo       => $use_repo,
    own_repo_class => $own_repo_class,
  }

  anchor { 'perun::begin': ; }
    -> Class['perun::config']
    -> Class['perun::install']
    -> anchor { 'perun::end': ; }
}
