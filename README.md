# Weather Forecast from Joao Pessoa using Shell Script and Puppet

This is a Puppet Managed Script that will create each minute a file with the weather forecast from Joao Pessoa and a backup will be done daily.


## Installation

Use Puppet Server to manage the scripts to the Agents.

The Forecast was created inside a Puppet Module, the Manifest File called site.pp have an example how to call the module to one specific agent as was tested.


## How it Works

```bash
File: "forecast.service"
# Service File created to be used by SystemD so Forecast can be managed like a Service (Start|Stop|Reload|Status)

File: "forecast.sh"
# Main script, will create a file each minute with the weather forecast from Joao Pessoa.
# Logs can be found at: /var/log/forecast.log
# Files can be found at: /var/log/forecast/

File: "forecast_bkp.sh"
# Backup script that will compact and store daily all forecasts and clean the data for the next day.
# Only the last 10 days backups are maintained.
# This script will run on daily basis being managed by a Crontab that Puppet will create with the Manifest.
# Logs can be found at: /var/log/forecast_bkp.log
# Files can be found at: /backup/

File: "init.pp"
# Its the Puppet Manifest file that will send the files to the agent, it will configure the permissions, files
# locations and the cron jobs.
```


## Testing
All files were tested using VM Virtual Box to run one Puppet Server and one Puppet Agent both in Debian 10 Linux.
