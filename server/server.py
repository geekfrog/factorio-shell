import socket

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind(('0.0.0.0', 34197))
print 'Bind UDP on 34197...'
while True:
    data, addr = s.recvfrom(1024)
    print 'Received from %s:%s.' % addr
    if len(data) >=2:
        s.sendto('\x09%s\x00\x13\x00\x00\x0043.248.191.27:%s' % (data[1], addr[1]), addr)
		