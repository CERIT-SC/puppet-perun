class perun::conf::dns_alias_whitelist {
  if is_array($perun::aliases) {
    $_aliases = $perun::aliases
  }
  elsif is_string($perun::aliases) {
    $_aliases = [$perun::aliases]
  }
  else {
    fail('$perun::aliases should be array or string')
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
