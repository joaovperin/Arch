#!/bin/bash

title="System update!"
message="Hello! Please, wake-up and run 'upgr' to perform a system update!"
icon=
# Sends the notification
notify-send --urgency=critical "$title" "$message"
