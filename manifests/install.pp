class nsd::install {

  package { 'nsd':
    ensure => installed,
    name   => $package_name,
  }

}
