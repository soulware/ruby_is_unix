SELF_PIPE = IO.pipe

fork do
  puts "child pid: #{$$}"
end

puts "parent pid: #{$$}"
trap('SIGCHLD') { SELF_PIPE[1].puts '.' }

selected = select(SELF_PIPE, nil, nil, nil)
puts "parent: something wrote to SELF_PIPE (assuming it was the SIGCHLD handler)"

Process.waitall
