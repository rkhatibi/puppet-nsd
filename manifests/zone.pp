# Define: nsd::zone
#
define nsd::zone (
  String $template,
  String[1] $zone = $name,
  Hash $zonedata = {},
  Enum['epp','hiera'] $func = 'epp',
) {

  include nsd

  concat::fragment { "nsd-zone-${zone}":
    order   => '05',
    target  => $config_file,
    content => epp('nsd/zone', {
      'config_file' => $nsd::config_file,
      'owner'       => $nsd::owner,
      'zonedir'     => $nsd::zonedir,
      'zonefile'    => "${zone}.zone",
    }),
  }

  file { "${zonedir}/${zonefile}":
    owner   => $owner,
    group   => '0',
    mode    => '0640',
    content => call($func, $template),
    notify  => Exec["nsd-control reload ${zone}"],
  }

  exec { "nsd-control reload ${zone}":
    command     => "${nsd::control_cmd} reload ${zone}",
    refreshonly => true,
    require     => Class['nsd::service'],
  }
}
