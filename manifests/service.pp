class perun::service (
) {
  if $perun::service {
    service { $perun::service:
      enable => true,
    }
  }
}
