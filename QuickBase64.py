import base64
import sys


##I personally use this with an alias bsf
## QuickBase64.py -e / -d text

if(sys.argv[1] == '-e'):
    bytes_text = sys.argv[2].encode('utf-16le')
    b64_text = base64.b64encode(bytes_text)
    print(b64_text.decode())

if(sys.argv[1] == '-d'):
    b64_text = base64.b64decode(sys.argv[2])
    print(b64_text.decode('utf-16le'))