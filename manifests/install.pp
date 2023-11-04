# install class
class nsd::install {

  if $nsd::package_name {
    package { 'nsd':
      ensure => installed,
      name   => $nsd::package_name,
    }
  }

}
