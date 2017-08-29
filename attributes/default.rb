case node['platform']
when 'debian', 'ubuntu'
  default['sysctl']['path'] = '/etc/sysctl.d'
  default['sysctl']['bin'] = '/sbin/sysctl'
end

default['sysctl']['settings'] = {}
