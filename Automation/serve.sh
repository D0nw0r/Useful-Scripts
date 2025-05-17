#!/bin/bash
#To be used as serve $port

echo "Starting python3 server on port $1";
python3 -m http.server $1;