#!/usr/bin/env bash

# Run a command n-times or infinite times.
#   by Tuncay D. (thingsiplay)
#
# Usage: loop [N] COMMAND
#
#   If the first argument N is a number, then it will run the command that many
#   times. If N is not a number, then it will be interpreted as part of the
#   actual command and run indefinitely.
#
# Examples:
#
#   # Run command 3 times.
#   loop 3 echo hello wonderful person \&\& sleep 1
#
#   # Benchmark a command by running it 10 times without output.
#   time loop 10 grep -F [ ~/.* 1>/dev/null 2>/dev/null
#
#   # Watch until a file containing "abc" is created in home then stop.
#   loop 'sleep 1 ; ls ~/ | grep abc && echo found && exit'

int='^[0-9]+$'
if ! [[ ${1} =~ ${int} ]]; then
	while :; do
		eval ${*}
	done
else
	n="${1}"
	shift
	for _ in $(seq 1 "${n}"); do
		eval ${*}
	done
fi