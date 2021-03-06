# add the pixelated sources needed to install everything
class pixelated::apt {

  # wheezy backports
  file { '/etc/apt/sources.list.d/wheezy-backports.list':
    source => 'puppet:///modules/pixelated/apt/wheezy-backports.list',
    owner  => 'root',
    notify => Exec['apt_get_update'],
  }

  # pixelated repo
  file { '/etc/apt/sources.list.d/pixelated.list':
    source  => 'puppet:///modules/pixelated/apt/pixelated.list',
    owner   => 'root',
    require => Exec['add_pixelated_key'],
    notify  => Exec['apt_get_update'],
  }

  file { '/etc/apt/preferences.d/pixelated':
    source => 'puppet:///modules/pixelated/apt/pixelated-preferences',
    owner  => 'root',
    notify => Exec['apt_get_update'],
  }

  file { '/tmp/0x287A1542472DC0E3_packages@pixelated-project.org.asc':
    source => 'puppet:///modules/pixelated/0x287A1542472DC0E3_packages@pixelated-project.org.asc',
    notify => Exec['add_pixelated_key']
  }

  exec{'add_pixelated_key':
    command     => '/usr/bin/apt-key add /tmp/0x287A1542472DC0E3_packages@pixelated-project.org.asc',
    refreshonly => true,
    require     => File['/tmp/0x287A1542472DC0E3_packages@pixelated-project.org.asc'],
    notify      => Exec['apt_get_update'],
  }

  # leap repo
  file { '/etc/apt/sources.list.d/leap.list':
    content => 'deb http://deb.leap.se/0.6 wheezy main',
    owner   => 'root',
    require => Exec['add_leap_key'],
    notify  => Exec['apt_get_update'],
  }
  file { '/tmp/0x1E34A1828E20790_leap_archive_key':
    source => 'puppet:///modules/pixelated/0x1E34A1828E20790_leap_archive_key',
    notify => Exec['add_leap_key']
  }
  exec{'add_leap_key':
    command     => '/usr/bin/apt-key add /tmp/0x1E34A1828E20790_leap_archive_key',
    refreshonly => true,
    require     => File['/tmp/0x1E34A1828E20790_leap_archive_key'],
    notify      => Exec['apt_get_update'],
  }

  package { 'leap-keyring':
    ensure  => latest,
    require => Exec['apt_get_update']
  }

  exec { 'apt_get_update':
    command     => '/usr/bin/apt-get -y update',
    refreshonly => true,
  }

}
