require 'socket'

# create a socket pair
sock1, sock2 = Socket.pair(Socket::AF_UNIX, Socket::SOCK_STREAM, 0)

# fork a child process, listen on sock2
fork do
  trap('INT') { puts "child exiting\n"; exit }

  loop do
    sock2.puts Time.now
    puts sock2.gets
  end
end

trap('INT') { puts "parent exiting\n"; exit }

loop do
  selected = select([sock1], [sock1], nil, nil)

  if(selected[0][0] && selected[1][0])
    rd = selected[0][0]
    wr = selected[1][0]
    puts rd.gets
    sleep 0.5
    wr.puts "OK"
  end
end

Process.waitall
