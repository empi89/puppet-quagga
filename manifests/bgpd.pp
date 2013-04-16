# Class: quagga:bgpd
class quagga::bgpd (
    $owner                        = params_lookup('owner'),
    $group                        = params_lookup('group'),
    
    $bgp_config                   = params_lookup('bgp_config'),
    $hostname                     = params_lookup('hostname'),
    $logfile                      = params_lookup('logfile'),
    $password                     = params_lookup('passwd'),
    $bgp_config                   = params_lookup('bgp_config'),
    
    $bgpd_conf                   = params_lookup('bgpd_conf'),
    $bgpd_conf_template          = params_lookup('bgpd_conf_template'),
    
) inherits quagga::params {
    file { 'bgpd_conf':
        name    => $quagga::bgpd::bgpd_conf,
        content => template($quagga::bgpd::bgpd_conf_template),
        owner   => $quagga::bgpd::owner,
        group   => $quagga::bgpd::group,
        mode    => '0640',
        notify  => Service['quagga'],
        require => Package['quagga'],
        replace => false,
    }
    
    concat::fragment{'bgpd':
      target  => $quagga::daemons_conf,
      content => "bgpd=yes\n",
      order   => 02,
    }

}