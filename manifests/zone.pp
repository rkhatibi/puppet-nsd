# Define: nsd::zone
#
define nsd::zone (
  String $template,
  Hash $vars = {},
  String $zone = $name,
  Enum['epp','hiera'] $func = 'epp',
) {

  include nsd

  $config_file = $nsd::config_file
  $owner       = $nsd::owner
  $zonedir     = $nsd::zonedir
  $zonefile    = "${zone}.zone"

  concat::fragment { "nsd-zone-${zone}":
    order   => '05',
    target  => $config_file,
    content => template('nsd/zone.erb'),
  }

  file { "${zonedir}/${zonefile}":
    owner   => $owner,
    group   => '0',
    mode    => '0640',
    content => call($func, $template),
    notify  => Exec["nsd-control reload ${zone}"],
  }

  exec { "nsd-control reload ${zone}":
    command     => "nsd-control reload ${zone}",
    refreshonly => true,
    require     => Class['nsd::service'],
  }
}
