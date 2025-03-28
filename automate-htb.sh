#!/bin/bash


if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <Machine Name> <IP>"
    exit 1
fi

mkdir $1
cd $1

mkdir scans
touch creds
touch users
touch pass
touch hashes

echo "Startup folder complete, can start scanning with:"
echo "nmap -p- -A -T3 $2 -vvv -oA scans/nmap-scan.txt" 

