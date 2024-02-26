#!/bin/sh

# For more information visit: https://github.com/downthecrop/TwitchVOD

while [ true ]; do
	Date=$(date +%Y%m%d-%H%M%S)
	streamlink --ffmpeg-copyts --plugin-dirs "home/plugins" $streamOptions $streamLink $streamQuality -o /home/download/$streamName"-$Date".mkv
	sleep 60s
done