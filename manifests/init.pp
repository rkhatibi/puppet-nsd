# Class: nsd
#
# Installs and configures NSD, the authoritative DNS resolver from NLnet Labs
#
class nsd (
  Stdlib::Absolutepath $config_d,
  String[1] $config_file,
  String[1] $control_cmd,
  String[1] $database,
  Stdlib::Absolutepath $zonedir,
  String[1] $group = 'nsd',
  Array[Stdlib::Ip::Address] $interface = ['::0','0.0.0.0'],
  Optional[String] $logfile = undef,
  String[1] $owner = 'nsd',
  Variant[String,Undef] $package_name = 'nsd',
  Stdlib::Port $port = 53,
  String[1] $service_name = 'nsd',
  Boolean $service_reload = false,
  Integer $verbosity = 0,
  Boolean $zonepurge = false,
) {

  contain nsd::install
  contain nsd::config
  include nsd::service

  Class['nsd::install']
  -> Class['nsd::config']
  ~> Class['nsd::service']

}
