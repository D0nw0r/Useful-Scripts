import os
import sys


## making nmap dir ##
dir_name = "nmap"
if not os.path.isdir(dir_name):
    os.mkdir(dir_name)
    print("[+]" * 15)
    print("Making nmap directory")
else:
    print("[+]" * 15)
    print("Directory already present, skipping to scan")

### Scan
print("[+]" * 15)
print("Scanning target")
if(len(sys.argv) <=2):
    os.system(f"nmap -T4 -p- -A -sC -vv {sys.argv[1]} -oA nmap/initial")
elif(sys.argv[2] == "-Pn"):
    os.system(f"nmap -T4 -p- -A -sC -vv {sys.argv[1]} -Pn -oA nmap/initial")








