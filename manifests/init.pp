class perun (
  $ensure            = $perun::params::ensure,
  $user              = $perun::params::user,
  $allow_from        = $perun::params::allow_from,
  $ssh_key           = $perun::params::ssh_key,
  $ssh_type          = $perun::params::ssh_type,
  $perun_conf        = $perun::params::perun_conf,
  $packages_base     = $perun::params::packages_base,
  $packages_standard = $perun::params::packages_standard,
  $packages_extra    = $perun::params::packages_extra,
  $service           = $perun::params::service,
  $use_repo          = $perun::params::use_repo,
  $own_repo_class    = $perun::params::own_repo_class,
  $require_class     = $perun::params::require_class,
  $baseurl           = $perun::params::baseurl,
  $repos             = $perun::params::apt_repos,
  $pin               = $perun::params::apt_pin,
  $gpgkey            = $perun::params::gpgkey,
  $conf_append       = $perun::params::conf_append,
  $perun_dir         = $perun::params::perun_dir,
) inherits perun::params {

  if ! ($ensure in [present,absent,latest]) {
    fail("Invalid ensure state: ${ensure}")
  }

  validate_string($user, $allow_from, $ssh_key, $ssh_type)
  validate_string($own_repo_class, $require_class)
  validate_string($baseurl, $gpgkey, $repos)
  validate_array($packages_base, $packages_standard, $packages_extra)
  validate_bool($use_repo)
  validate_bool($conf_append)
  validate_absolute_path($perun_dir)
  
  if $pin != undef {
    validate_integer($pin)
  }

  if ! empty($perun_conf) {
    validate_absolute_path($perun_conf)
  }

  if ! empty($require_class) {
    require($require_class)
  }

  contain perun::config
  contain perun::install
  contain perun::service

  Class['perun::config']
    -> Class['perun::install']
    ~> Class['perun::service']
}
