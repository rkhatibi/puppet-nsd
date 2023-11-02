# Class: nsd
#
# Installs and configures NSD, the authoritative DNS resolver from NLnet Labs
#
class nsd (
  String $config_d,
  String $config_file,
  String $service_name,
  Variant[String,Undef] $package_name,
  String $control_cmd,
  String $zonedir,
  Boolean $zonepurge = false,
  String $group,
  String $owner,
  String $database,
  Integer $verbosity = 0,
  Integer $port = 53,
  Array[Stdlib::Ip::Address] $interface = ['::0','0.0.0.0'],
  Optional[String] $logfile = undef,
) {

  contain nsd::install
  contain nsd::config
  include nsd::service

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
