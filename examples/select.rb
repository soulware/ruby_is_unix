require 'socket'

# create a socket pair
sock1, sock2 = Socket.pair(Socket::AF_UNIX, Socket::SOCK_STREAM, 0)

# fork a child process, select on sock2, timeout after 1s
fork do
  while selected = select([sock2], nil, nil, 1)
    sock = selected[0][0]
    puts sock.gets
  end
  puts "... done"
end

# send some data on sock1
sock1.puts "hello world"
sock1.puts "hello again"
