#!/bin/bash
set -eux

# Update configs if internet is available
if ping -c1 8.8.8.8 &>/dev/null; then
	if [[ -e /data/home-assistant ]]; then
		(
		cd /data/home-assistant
		git fetch --all
		git reset --hard origin/master
		)
	else
		git clone https://github.com/justin8/home-assistant-config.git /data/home-assistant
	fi
	aws s3 sync s3://home-assistant-secrets/ /data/home-assistant/
fi

# Start mosquitto because no service management on this image...
mosquitto -c /data/home-assistant/mosquitto.conf -d

python3 -m homeassistant --config /data/home-assistant
