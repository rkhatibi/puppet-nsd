# Class: nsd
#
# Installs and configures NSD, the authoritative DNS resolver from NLnet Labs
#
class nsd (
  Stdlib::Absolutepath $config_d,
  String $config_file,
  String $control_cmd,
  String $database,
  Stdlib::Absolutepath $zonedir,
  String $group = 'nsd',
  Array[Stdlib::Ip::Address] $interface = ['::0','0.0.0.0'],
  Optional[String] $logfile = undef,
  String $owner = 'nsd',
  Variant[String,Undef] $package_name = 'nsd',
  Stdlib::Port $port = 53,
  String $service_name = 'nsd',
  Integer $verbosity = 0,
  Boolean $zonepurge = false,
) {

  contain nsd::install
  contain nsd::config
  include nsd::service

  Class['nsd::install']
  -> Class['nsd::config']
  ~> Class['nsd::service']

  exec { 'nsd-control-setup':
    command => 'nsd-control-setup',
    creates => "${config_d}/nsd_control.pem",
  }

  exec { 'nsd-control reload':
    command     => 'nsd-control reload',
    refreshonly => true,
    require     => Class['nsd::service'],
  }

  exec { 'nsd-control reconfig':
    command     => 'nsd-control reconfig',
    refreshonly => true,
    require     => Class['nsd::service'],
  }

}
