class logstash::simple { 
		
	package { 'java-1.6.0-openjdk':
					ensure => 'installed';
		}
	file {
		"/usr/local/logstash/":
			ensure => "directory",
			recurse => true;
		"/usr/local/logstash/logstash.jar":
			ensure => "file",
			source => "puppet:///modules/logstash/logstash-1.0.14-monolithic.jar",
			require => File['/usr/local/logstash'];
		"/etc/logstash/":
			ensure => "directory";
		"/var/log/logstash/": 
			ensure => "directory";
	}

	file { 
		"/etc/logstash/simple.conf":
			ensure => "file",
			source => "puppet:///modules/logstash/simple.conf",
			require => File['/etc/logstash'];
		"/etc/init.d/logstash-simple":
			ensure => "file", 
			mode => 0744,
			source => "puppet:///modules/logstash/logstash-simple",
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



class logstash::server {

	include elasticsearch

}
