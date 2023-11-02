class nsd::install {

  if $nsd::package_name {
    package { 'nsd':
      ensure => installed,
      name   => $package_name,
    }
  }

}
