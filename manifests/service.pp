class nsd::service {

  service { 'nsd':
    ensure  => running,
    enable  => true,
    name    => $service_name,
  }

}
