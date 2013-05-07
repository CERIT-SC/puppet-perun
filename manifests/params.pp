class perun::params {
  $user       = 'root'
  $allow_from = 'perun.ics.muni.cz'
  $ssh_key    = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC26+QiDtZ3bnLiLllySgsImSPUX0/sFBmo//3PmqOsuJIBdWB5BLU5Ws+pTRxefqC8SHfI92ZQoGXe7aJniTXxbRPa0FZJ3fskAHwpbiJfstGVZ1hddBcHIvial3v5Rd++zRiKslDVTkXLlb+b1pTnjyTVbD/6kGILgnUz7RKY5DnXADVnmTdPliQCabhE41AhkWdcuWpHBNwvxONKoZJJpbuouDbcviX4lJu9TF9Ij62rZjcoNzg5/JiIKTcMVi8L04FTjyCMxKRzlo00IjSuapFnXQNNZUL5u/mfPA/HpyIkSAOiPXLhWy9UuBNo7xdrCmfTh1qUvzbuWXJZN3d9'
  $ssh_type   = 'ssh-rsa'
  $ensure     = latest

  $use_repo   = true
  $yum_gpgkey = '/etc/pki/rpm-gpg/RPM-GPG-KEY-perunv3'

  case $::operatingsystem {
    debian: {
      $packages = ['remctl-client','perun-slave','perun-slave-meta']
    }

    redhat,centos: {
      $packages = ['perun-slave']
    }

    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }
}
