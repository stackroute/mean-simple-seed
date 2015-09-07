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

}

include nodejs
