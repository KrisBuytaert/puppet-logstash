class logstash {
  include logstash::common
}





class logstash::shipper (
  $logstash_server ='localhost',
  $verbose = 'no',
  $jarname ='logstash-1.1.0-monolithic.jar',
  # TODO This needs refactoring :)
  $logfiles = '"/var/log/messages", "/var/log/syslog", "/var/log/*.log"'
)
{

  file {
    '/etc/logstash/shipper.conf':
      ensure  => 'file',
      group   => '0',
      mode    => '0644',
      owner   => '0',
      content => template('logstash/shipper.conf.erb'),
  }


  file {
    '/etc/rc.d/init.d/logstash-shipper':
      ensure => 'file',
      group  => '0',
      mode   => '0755',
      owner  => '0',
      source => 'puppet:///modules/logstash/logstash-shipper' ;
  }




  file {
    '/usr/local/logstash/conf/shipper-wrapper.conf':
      ensure   => 'file',
      group    => '0',
      mode     => '0644',
      owner    => '0',
      content  => template('logstash/shipper-wrapper.conf.erb');
  }

  service { 'logstash-shipper':
    ensure    => 'running',
    hasstatus => 'true',
    enable    => 'true',
  }



  file { '/etc/logrotate.d/syslog':
    ensure   => 'file',
    group    => '0',
    mode     => '0644',
    owner    => '0',
    source   => 'puppet:///modules/logstash/syslog.logrotate';
  }



}


class logstash::server(
  $verbose = 'no',
  $jarname ='logstash-1.1.0-monolithic.jar'
)
{

  file {
    '/etc/logstash/indexer.conf':
      ensure  => 'file',
      group   => '0',
      mode    => '0644',
      owner   => '0',
      source  => 'puppet:///modules/logstash/indexer.conf';
  }

  file {
    '/etc/rc.d/init.d/logstash-server':
      ensure => 'file',
      group  => '0',
      mode   => '0755',
      owner  => '0',
      source => 'puppet:///modules/logstash/logstash-server' ;
  }




  file {
    '/usr/local/logstash/conf/server-wrapper.conf':
      ensure   => 'file',
      group    => '0',
      mode     => '0644',
      owner    => '0',
      content  => template('logstash/server-wrapper.conf.erb');
  }

  service { 'logstash-server':
    ensure    => 'running',
    hasstatus => 'true',
    enable    => 'true',
  }



}

class logstash::web ($jarname ='logstash-1.1.0-monolithic.jar') {


  file {
    '/etc/rc.d/init.d/logstash-web':
      ensure => 'file',
      group  => '0',
      mode   => '0755',
      owner  => '0',
      source => 'puppet:///modules/logstash/logstash-web' ;
  }




  file {
    '/usr/local/logstash/conf/web-wrapper.conf':
      ensure   => 'file',
      group    => '0',
      mode     => '0644',
      owner    => '0',
      content  => template('logstash/web-wrapper.conf.erb');
  }


  service { 'logstash-web':
    ensure    => 'running',
    hasstatus => 'true',
    enable    => 'true',
  }



}


