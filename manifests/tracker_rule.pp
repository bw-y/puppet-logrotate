define logrotate::tracker_rule(
  $spath     = 'undef',
  $dpath     = 'undef',
  $ensure    = 'present',
  $cron_min  = '*/2',
  $cron_hour = '*',
){
  include logrotate::base

  case $ensure {
    'present': {
      if $spath == 'undef' or $dpath == 'undef' {
        fail("Logrotate::Tracker_rule[${name}]: spath or dpath not specified")
      }
    }
    'absent': {}
    default: {
      fail("Logrotate::Tracker_rule[${name}]: invalid ensure value")
    }
  }

  $rule_path = "/etc/logrotate.d/${name}.conf"
  $rule_cron = "tracker log rotate ${name}"

  file { $rule_path:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('logrotate/tracker_rule.erb'),
    require => Class['logrotate::base'],
  }

  cron { $rule_cron:
    minute  => $cron_min,
    hour    => $cron_hour,
    command => "/usr/sbin/logrotate -vf $rule_path",
    user    => root,
    ensure  => $ensure,
    require => File[$rule_path]
  }

}
