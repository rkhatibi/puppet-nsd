# Class: nsd::remote
#
# Configure remote control of the nsd daemon process
#
class nsd::remote (
  Boolean $enable = true,
  Array[String] $interface = ['::1', '127.0.0.1'],
  Stdlib::Port $port = 8952,
  Optional[Stdlib::Absolutepath] $server_key_file = undef,
  Optional[Stdlib::Absolutepath] $server_cert_file = undef,
  Optional[Stdlib::Absolutepath] $control_key_file = undef,
  Optional[Stdlib::Absolutepath] $control_cert_file = undef,
) {

  include nsd

  concat::fragment { 'nsd-remote':
    order   => '10',
    target  => $nsd::config_file,
    content => epp('nsd/remote', {
      'enable'            => $enable,
      'interface'         => $interface,
      'port'              => $port,
      'server_key_file'   => $server_key_file,
      'server_cert_file'  => $sserver_cert_file,
      'control_key_file'  => $control_key_file,
      'control_cert_file' => $control_cert_file,
    }),
  }

}
