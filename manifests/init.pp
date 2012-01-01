
class logstash::common {

  file {
    "/usr/local/logstash/":
      ensure   => "directory";
    "/etc/logstash/":
      ensure   => "directory";
    "/usr/local/logstash/bin/":
      ensure   => "directory";
    "/usr/local/logstash/lib/":
      ensure   => "directory";
    "/usr/local/logstash/conf":
      ensure   => "directory";
    "/usr/local/logstash/logs":
      ensure   => "directory";
    "/var/log/logstash/":
      ensure   => "directory",
      recurse  => true;
  }


  # Obviously I abused fpm to create a logstash package and put it on my repository 
  package {
    "logstash":
      ensure => "latest";
  }
}

class logstash {
  include logstash::common
}



class logstash::simple { 


  file {
    "/usr/local/logstash/logstash.jar":
      ensure  => "file",
      source  => "puppet:///modules/logstash/logstash-1.0.14-monolithic.jar",
      require => File['/usr/local/logstash'];
    "/etc/logstash/simple.conf":
      ensure  => "file",
      source  => "puppet:///modules/logstash/simple.conf",
      require => File['/etc/logstash'];
    "/etc/init.d/logstash-simple":
      ensure  => "file", 
      mode    => 0744,
      source  => "puppet:///modules/logstash/logstash-simple",
      require => [ File['/usr/local/logstash/logstash.jar'], File['/var/log/logstash/'] ],
  }

#	service { 'logstash-simple':
#			ensure => 'running',
#			enable => true,
#			hasrestart => true,
#			hasstatus => true,
#			require => [ File['/etc/logstash/simple.conf'], File['/etc/init.d/logstash-simple'] ]
#	}

}



class logstash::shipper {

  file { 
    '/etc/logstash/shipper.conf':
      ensure  => 'file',
      group   => '0',
      mode    => '644',
      owner   => '0',
      source  => "puppet:///modules/logstash/shipper.conf";
  }



}


class logstash::server {


  file { 
    '/etc/logstash/indexer.conf':
      ensure  => 'file',
      group   => '0',
      mode    => '644',
      owner   => '0',
      source  => "puppet:///modules/logstash/indexer.conf";
  }
}

class logstash::web {

  # Most probably only the rc script goes inhere .. 



}


