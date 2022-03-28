class forecast {

# Sends the Main Forecast script and configure its permissions
  file { "/usr/local/bin/forecast.sh":
    mode => "0655",
    owner => 'root',
    group => 'root',
    source => 'puppet:///modules/forecast/forecast.sh',
  }

# Sends the script that turns the Forecast into a Service and configure its permissions
  file { "/etc/systemd/system/forecast.service":
    mode => "0655",
    owner => 'root',
    group => 'root',
    source => 'puppet:///modules/forecast/forecast.service',
  }

# Sends the Backup Forecast script and configure its permissions
  file { "/usr/local/bin/forecast_bkp.sh":
    mode => "0655",
    owner => 'root',
    group => 'root',
    source => 'puppet:///modules/forecast/forecast_bkp.sh',
  }

# Starts the Forecast as a Service if its not already running and enables it
  service { 'forecast':
    ensure => running,
    enable => true,
    status => '/usr/bin/systemctl status forecast',
    stop => '/usr/bin/systemctl stop forecast',
    start => '/usr/bin/systemctl start forecast',
  }

# Configures the Crontab to start the Backup Script once per day
  cron { 'forecast':
    command => 'bash /usr/local/bin/forecast_bkp.sh',
    user => 'root',
    hour => '0',
    minute => '0',
  }
}
