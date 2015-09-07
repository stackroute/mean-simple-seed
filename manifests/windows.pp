class nodejs {

  # The next two resources installs nodejs as recommended by the nodejs web site
  exec { 'run update script':
    command  => '/usr/bin/curl --silent --location https://deb.nodesource.com/setup_0.12 | /bin/bash -',
  }
  package { 'nodejs':
    ensure   => installed,
    require  => Exec['run update script'],
  }

  # Install grunt, coffeescript globally
  exec { 'npm global packages':
    command => '/usr/bin/npm install gulp-cli coffee-script -g',
    require => Package['nodejs']
  }

  # Soft link trick to get over windows' limit of long file names
  file { '/home/vagrant/node_modules':
    ensure => 'directory',
    group  => 'vagrant',
    owner  => 'vagrant',
  }
  file { '/vagrant/node_modules':
      ensure   => 'link',
      target   => '/home/vagrant/node_modules',
      require  => File['/home/vagrant/node_modules']
  }

  # install mongodb
  package { 'mongodb':
    ensure  => installed
  }

}

include nodejs
