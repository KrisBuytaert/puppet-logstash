# = Class: logstash::shipper
#
# Description of logstash::shipper
#
# == Parameters:
#
# $param::   description of parameter. default value if any.
#
# == Actions:
#
# Describe what this class does. What gets configured and how.
#
# == Requires:
#
# Requirements. This could be packages that should be made available.
#
# == Sample Usage:
#
# == Todo:
#
# * Update documentation
#
class logstash::shipper (
  $logstash_server ='localhost',
  $verbose = 'no',
  $jarname ='logstash-1.1.0-monolithic.jar',
  # TODO This needs refactoring :)
  $logfiles = '"/var/log/messages", "/var/log/syslog", "/var/log/*.log"'
) {

  file {'/etc/logstash/shipper.conf':
    ensure  => 'file',
    group   => '0',
    mode    => '0644',
    owner   => '0',
    content => template('logstash/shipper.conf.erb'),
  }

  file { '/etc/rc.d/init.d/logstash-shipper':
    ensure => 'file',
    group  => '0',
    mode   => '0755',
    owner  => '0',
    source => 'puppet:///modules/logstash/logstash-shipper' ;
  }

  file { '/usr/local/logstash/conf/shipper-wrapper.conf':
    ensure   => 'file',
    group    => '0',
    mode     => '0644',
    owner    => '0',
    content  => template('logstash/shipper-wrapper.conf.erb');
  }

  #  file { '/etc/logrotate.d/syslog':
  #  ensure   => 'file',
  #  group    => '0',
  #  mode     => '0644',
  #  owner    => '0',
  #  source   => 'puppet:///modules/logstash/syslog.logrotate';
  #}

  service { 'logstash-shipper':
    ensure    => 'running',
    hasstatus => true,
    enable    => true,
  }

}

