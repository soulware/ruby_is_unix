fork do
  puts "child pid: #{$$}"
  sleep 1
end

puts "parent pid: #{$$}"
trap('SIGCHLD') { puts "parent: SIGCHLD received" }

Process.waitall