# control class
class nsd::control {

  exec { 'nsd-control reconfig':
    command     => 'nsd-control reconfig',
    refreshonly => true,
  }

  exec { 'nsd-control reload':
    command     => 'nsd-control reload',
    refreshonly => true,
  }

}
