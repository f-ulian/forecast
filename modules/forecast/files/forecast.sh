#!/bin/bash

#===================================================================================
#
# FILE: forecast.sh
#
# USAGE: bash forecast.sh
#
# DESCRIPTION: Capture using CURL the weather forecast from Joao Pessoa every minute
#
#===================================================================================

# Starting Vars
logFile="/var/log/forecast.log"
forecastDir="/var/log/forecast/"

getForecast(){
# Generate new Time Stamp
  timeStamp="$(date +%Y%m%d)_$(date +%H%M)"

# Ensure output directory
  if [ ! -d $forecastDir ]; then
    mkdir $forecastDir
    if [ $? -ne 0 ]; then
      echo "$timeStamp - Output Directory Creation Failed: $forecastDir" >> $logFile
      exit 1
    fi
  fi

# Download and test forecast info
  curl -s http://wttr.in/joao_pessoa > /var/log/forecast/$timeStamp.txt
  if [ $? -ne 0 ]; then
    echo "$timeStamp - Curl Failed" >> $logFile
    exit 1
  else
    echo "$timeStamp - Curl Finished with Success" >> $logFile
  fi
}

# Starting Script
while true
do
  getForecast
  sleep 60
done
