# Define: nsd::zone_templated
#
define nsd::zone_templated(
  String[1] $zone = $name,
  Hash $zone_data = {}.
) {

  # not sure this needs to be there
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
    ensure  => file,
    owner   => 'root',
    group   => $nsd::group,
    mode    => '0640',
    content => epp('nsd/zone_templated', {} ),
  }


  Nsd::Zone_templated[$zone] ~> Class['nsd::service']

}
