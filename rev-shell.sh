#!/bin/bash
## to be used with alias rev $portNumber

echo "Starting Revshell on port $1";
echo "python3 -c 'import pty;pty.spawn("/bin/bash")';";
echo "python3 -c 'import pty;pty.spawn("/bin/sh")';";
rlwrap nc -lnvp $1;