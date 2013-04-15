# Class: quagga
#
# This class installs quagga daemon
#
# Parameters:
#
# Actions:
# - Install quagga
# - Manage quagga services
#
# Requires:
#
# Sample usage:
# - include quagga
#
class quagga (
  $quagga_name          = params_lookup('quagga_name'),
  $owner            = params_lookup('owner'),
  $group            = params_lookup('group'),
  
  $daemons_conf         = params_lookup('daemons_conf'),
  
  $zebra_conf           = params_lookup('zebra_conf'),
  $zebra_conf_template      = params_lookup('zebra_conf_template'),
  
  $debian_conf          = params_lookup('debian_conf'),
  $debian_conf_template     = params_lookup('debian_conf_template'),
  
  $vtysh_conf           = params_lookup('vtysh_conf'),
  $vtysh_conf_template      = params_lookup('vtysh_conf_template'),
  
  $zebra            = params_lookup('zebra'),
  $vtysh            = params_lookup('vtysh'),

) inherits quagga::params {
  $bool_zebra  = any2bool($zebra)
  $bool_vtysh  = any2bool($vtysh)
  
  $zebra_enabled = $quagga::bool_zebra ? {
    true  => 'yes',
    false => 'no',
  }
  
  $vtysh_enabled = $quagga::bool_vtysh ? {
    true  => 'yes',
    false => 'no',
  }
  
  package { 'quagga':
    ensure  => installed,
    name    => $quagga::quagga_name,
  }
  
  service { 'quagga':
    ensure    => running,
    name      => $quagga::quagga_name,
    enable    => true,
    subscribe   => Package['quagga'],
  }

  concat{$quagga::daemons_conf:
    owner => $quagga::owner,
    group => $quagga::group,
    mode  => '0644',
  }
   
  concat::fragment{'header':
    target  => $quagga::daemons_conf,
    content => "# Managed by puppet!\n\n",
    order   => 01,
  }
  
  if $quagga::bool_zebra {
    file { 'zebra_conf':
      name  => $quagga::zebra_conf,
      content => template($quagga::zebra_conf_template),
      owner   => $quagga::owner,
      group   => $quagga::group,
      mode  => '0640',
    }
    concat::fragment{'zebra':
      target  => $quagga::daemons_conf,
      content => "zebra=yes\n",
      order   => 02,
    }
  }
  
  if $quagga::bool_vtysh {
    file { 'vtysh_conf':
      name  => $quagga::vtysh_conf,
      content => template($quagga::vtysh_conf_template),
      owner   => $quagga::owner,
      group   => $quagga::group,
      mode  => '0660',
    }
  }
  
  if $quagga::debian_conf != undef {
    file { 'debian_conf':
      name  => $quagga::debian_conf,
      content => template($quagga::debian_conf_template),
      owner   => $quagga::owner,
      group   => $quagga::group,
      mode  => '0644',
    }
  }
}
