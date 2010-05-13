require 'socket'

# create a socket pair
sock1, sock2 = Socket.pair(Socket::AF_UNIX, Socket::SOCK_STREAM, 0)

# fork a child process, listen on sock2
fork { puts sock2.gets }

# send some data on sock1
sock1.puts "hello world"

