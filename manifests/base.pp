class logrotate::base {

  if !(defined(Package['logrotate'])){
    package { 'logrotate':
      ensure => latest,
    }
  }

}
