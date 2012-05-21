# = Class: logstash::common
#
# Description of logstash::common
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
class logstash::common {

  # create parent directory and all folders beneath it.
  file { '/usr/local/logstash/':
    ensure   => 'directory',
  }
  file { '/usr/local/logstash/bin/':
    ensure => 'directory',
  }
  file {'/usr/local/logstash/lib/':
    ensure => 'directory',
  }
  file {     '/usr/local/logstash/logs/':
    ensure => 'directory',
  }
  file {     '/usr/local/logstash/conf/':
    ensure => 'directory',
  }

  file { '/etc/logstash/':
    ensure  => 'directory',
  }

  file { '/var/log/logstash/':
    ensure   => 'directory',
    recurse  => true;
  }

  # Obviously I abused fpm to create a logstash package and put it on my
  # repository
  package { 'logstash':
    ensure => 'latest';
  }

}

