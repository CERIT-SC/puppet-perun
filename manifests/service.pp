class perun::service {
  if ! empty($perun::service) {
    service { $perun::service:
      enable => true,
    }
  }
}
