class perun::conf::dns_alias_whitelist (
  $aliases,
) {
  if is_array($aliases) {
    $_aliases = $aliases
  }
  elsif is_string($aliases) {
    $_aliases = [$aliases]
  }
  else {
    fail('$aliases should be array or string')
  }

  # replace ' -> '\'' and
  # wrap elements with single quotes
  $_aliases_q =
    join(
      suffix(
        prefix(
          regsubst($_aliases, "'", "'\\\\''", 'G'),
          "'"
        ),
        "'"
      ),
      ' '
    )

  $_op = $perun::conf_append ? {
    true    => '+=',
    default => '='
  }

  perun::conf { 'dns_alias_whitelist':
    content => "DNS_ALIAS_WHITELIST${_op}(${_aliases_q})"
  }
}
