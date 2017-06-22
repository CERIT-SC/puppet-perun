class perun (
  $ensure            = $perun::params::ensure,
  $user              = $perun::params::user,
  $allow_from        = $perun::params::allow_from,
  $ssh_key           = $perun::params::ssh_key,
  $ssh_type          = $perun::params::ssh_type,
  $perun_conf        = $perun::params::perun_conf,
  $perun_standard    = $perun::params::perun_standard,
  $packages_base     = $perun::params::packages_base,
  $packages_standard = $perun::params::packages_standard,
  $packages_extra    = $perun::params::packages_extra,
  $service           = $perun::params::service,
  $use_repo          = $perun::params::use_repo,
  $own_repo_class    = $perun::params::own_repo_class,
  $require_class     = $perun::params::require_class
) inherits perun::params {

  if ! ($ensure in [present,absent,latest]) {
    fail("Invalid ensure state: ${ensure}")
  }

  validate_string($user, $allow_from, $ssh_key, $ssh_type)
  validate_string($own_repo_class, $require_class)
  validate_array($packages)
  validate_bool($use_repo)

  if $perun_conf != '' {
    validate_absolute_path($perun_conf)
  }

  if $require_class != '' {
    require($require_class)
  }

  class { 'perun::config':
    ensure     => $ensure,
    user       => $user,
    allow_from => $allow_from,
    ssh_key    => $ssh_key,
    ssh_type   => $ssh_type,
    perun_conf => $perun_conf,
  }

  if $perun_standard == true {
    $_packages = concat($packages_base,$packages_standard,$packages_extra)
  }
  else {
    $_packages = concat($packages_base,$packages_extra)
  }

  class { 'perun::install':
    ensure         => $ensure,
    packages       => $_packages,
    use_repo       => $use_repo,
    own_repo_class => $own_repo_class,
  }

  class { 'perun::service':
    service => $service,
  }

  anchor { 'perun::begin': ; }
    -> Class['perun::config']
    -> Class['perun::install']
    ~> Class['perun::service']
    -> anchor { 'perun::end': ; }
}
