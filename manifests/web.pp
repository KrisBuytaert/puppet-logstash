# = Class: logstash::web
#
# Description of logstash::web
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
class logstash::web (
  $jarname ='logstash-1.1.0-monolithic.jar'
) {

  file { '/etc/rc.d/init.d/logstash-web':
    ensure => 'file',
    group  => '0',
    mode   => '0755',
    owner  => '0',
    source => 'puppet:///modules/logstash/logstash-web' ;
  }

  file { '/usr/local/logstash/conf/web-wrapper.conf':
    ensure   => 'file',
    group    => '0',
    mode     => '0644',
    owner    => '0',
    content  => template('logstash/web-wrapper.conf.erb');
  }

  service { 'logstash-web':
    ensure    => 'running',
    hasstatus => true,
    enable    => true,
  }


}

