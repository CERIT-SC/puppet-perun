define perun::conf (
  $content,
  $order      = 10,
  $ensure     = $perun::ensure,
  $perun_conf = $perun::perun_conf,
) {
  validate_string($content, $order)
  validate_absolute_path($perun_conf)

  concat::fragment { "perun::conf-${name}":
    ensure  => $ensure,
    target  => $perun_conf,
    order   => $order,
    content => "${content}\n",
  }
}
