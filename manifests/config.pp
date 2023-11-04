# config class
class nsd::config {

  concat { $nsd::config_file:
    owner => 'root',
    group => $nsd::group,
    mode  => '0640',
  }

  concat::fragment { 'nsd-header':
    order   => '00',
    target  => $nsd::config_file,
    content => epp('nsd/nsd.conf', {
      'database'  => $nsd::database,
      'interface' => $nsd::interface,
      'logfile'   => $nsd::logfile,
      'port'      => $nsd::port,
      'verbosity' => $nsd::verbosity,
    }),
  }

  file { $nsd::zonedir:
    ensure  => directory,
    owner   => 'root',
    group   => $nsd::group,
    mode    => '0750',
    purge   => $nsd::zonepurge,
    recurse => true,
  }

  exec { 'nsd-control-setup':
    command => 'nsd-control-setup',
    creates => "${nsd::config_d}/nsd_control.pem",
  }

}
