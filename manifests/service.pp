class perun::service {
  if ((! empty($perun::service)) and
    ($perun::service != undef))
  {
    service { $perun::service:
      enable => true,
    }
  }
}
