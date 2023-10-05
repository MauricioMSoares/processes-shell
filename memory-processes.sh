#!/bin/bash

if [ ! -d log ]
then
	mkdir log
fi

build_log() {
	processes=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])
	for pid in $processes
	do
		process_name=$(ps -p $pid -o comm=)
		echo -n $(date +%F,%H:%M:%S,) >> log/$process_name.log
		process_size=$(ps -p $pid -o size | grep [0-9])
		echo "$(bc <<< "scale=2;$process_size/1024") MB" >> log/$process_name.log
	done
}

build_log
if [ $? -eq 0 ]
then
	echo "Log has been successfully built!"
else
	echo "An error occurred while building the log."
fi
