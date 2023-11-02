class nsd::service {

  service { 'nsd':
    ensure  => running,
    enable  => true,
    name    => $nsd::service_name,
  }

}
