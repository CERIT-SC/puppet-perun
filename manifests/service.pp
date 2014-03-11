class perun::service (
  $service
) {
  if $service {
    service { $service:
      enable => true,
    }
  }
}
