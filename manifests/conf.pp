define perun::conf (
  $content,
  $order      = 10,
  $perun_conf = $perun::perun_conf,
) {
  validate_string($content)
  validate_absolute_path($perun_conf)
  validate_re("${order}", '^\d+$')

  concat::fragment { "perun::conf-${name}":
    target  => $perun_conf,
    order   => $order,
    content => "${content}\n",
  }
}
