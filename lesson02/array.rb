x = 10
array = [x]

loop do 
  x += 5
  break if x > 100
  array << x
end

print array
