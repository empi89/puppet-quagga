# Class: quagga::params
#
# This class manages Quagga parameters
#
# Parameters:
# - The $user that Quagga runs as
# - The $group that Quagga runs as
# - The $name is the name of the package and
#   service on the relevant distribution
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class quagga::params {

  $owner        = 'quagga'
  $group        = 'quagga'
  $quagga_name         = 'quagga'
  
  $zebra        = false
  $vtysh        = false
  $bgpd         = false
  $ospfd        = false
  $ospf6d       = false
  $ripd         = false
  $ripngd       = false
  $isisd        = false

  case $::operatingsystem {
    'ubuntu','debian': {
      $conf                  = '/etc/quagga'
      
      $daemons_conf          = '/etc/quagga/daemons'
      $daemons_conf_template = 'quagga/quagga_daemons.conf.erb'
      
      $debian_conf           = '/etc/quagga/debian.conf'
      $debian_conf_template  = 'quagga/quagga_debian.conf.erb'
      
      $zebra_conf            = '/etc/quagga/zebra.conf'
      $zebra_conf_template   = 'quagga/quagga_zebra.conf.erb'
      
      $vtysh_conf            = '/etc/quagga/vtysh.conf'
      $vtysh_conf_template   = 'quagga/quagga_vtysh.conf.erb'
      
      $bgpd_conf             = '/etc/quagga/bgpd.conf'
      $bgpd_conf_template    = 'quagga/quagga_bgpd.conf.erb'
      
      $ospfd_conf            = '/etc/quagga/ospfd.conf'
      $ospfd_conf_template   = 'quagga/quagga_ospfd.conf.erb'
      
      $ospf6d_conf           = '/etc/quagga/opsf6d.conf'
      $ospf6d_conf_template  = 'quagga/quagga_ospf6d.conf.erb'
      
      $ripd_conf             = '/etc/quagga/ripd.conf'
      $ripd_conf_template    = 'quagga/quagga_ripd.conf.erb'
      
      $ripngd_conf           = '/etc/quagga/ripngd.conf'
      $ripngd_conf_template  = 'quagga/quagga_ripngd.conf.erb'
      
      $isisd_conf            = '/etc/quagga/isisd.conf'
      $isisd_conf_template   = 'quagga/quagga_isisd.conf.erb'
      
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}
