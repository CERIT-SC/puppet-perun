class perun::params {
  $user = 'root'
  $allow_from = 'perun.ics.muni.cz'
  $ssh_key = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC26+QiDtZ3bnLiLllySgsImSPUX0/sFBmo//3PmqOsuJIBdWB5BLU5Ws+pTRxefqC8SHfI92ZQoGXe7aJniTXxbRPa0FZJ3fskAHwpbiJfstGVZ1hddBcHIvial3v5Rd++zRiKslDVTkXLlb+b1pTnjyTVbD/6kGILgnUz7RKY5DnXADVnmTdPliQCabhE41AhkWdcuWpHBNwvxONKoZJJpbuouDbcviX4lJu9TF9Ij62rZjcoNzg5/JiIKTcMVi8L04FTjyCMxKRzlo00IjSuapFnXQNNZUL5u/mfPA/HpyIkSAOiPXLhWy9UuBNo7xdrCmfTh1qUvzbuWXJZN3d9'
  $ssh_type = 'ssh-rsa'
  $ensure = latest
  $use_repo = true
  $own_repo_class = ''
  $require_class = ''
  $perun_dir = '/opt/perun/bin'

  case $::operatingsystem {
    debian: {
      $packages = ['remctl-client','perun-slave','perun-slave-meta']
      $service = 'perun_propagate'
      $baseurl = 'ftp://depot1.mc.cesnet.cz/'
      $apt_repos = 'main'
      $apt_pin = 490
    }

    redhat,centos: {
      $packages = ['perun-slave']
      $service = undef
      $baseurl = 'https://homeproj.cesnet.cz/rpm/perunv3/stable/noarch'
      $gpgkey = '/etc/pki/rpm-gpg/RPM-GPG-KEY-perunv3'
    }

    sles,sled: {
      $packages = ['perun-slave']
      $service = undef
      $baseurl = 'https://homeproj.cesnet.cz/rpm/perunv3/stable/noarch'
      $gpgkey = '/etc/pki/RPM-GPG-KEY-perunv3'
    }

    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }
}
