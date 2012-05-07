class logstash {
  include logstash::common
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


