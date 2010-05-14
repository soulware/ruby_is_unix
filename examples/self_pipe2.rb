SELF_PIPE = IO.pipe
['INT', 'TERM'].each { |sig| trap(sig) {shutdown}}

def shutdown
  SELF_PIPE[1].puts '.'
end

selected = select(SELF_PIPE, nil, nil, nil)
puts "SELF_PIPE success" if selected[0][0] == SELF_PIPE[0]
