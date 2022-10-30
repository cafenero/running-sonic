#!/bin/bash

TIME=$(date "+%H:%M:%S")
USAGE=$(df -h | grep ubuntu | awk '{print $3}' | sed -e 's/G//g')
echo $TIME $USAGE
