puts "Input a:"
a = gets.to_i
puts "Input b:"
b = gets.to_i
puts "Input c:"
c = gets.to_i

discr = b ** 2 - 4 * a * c
disqrt = Math.sqrt(discr)

if discr > 0 
  x1 = (-b + disqrt) / (2 * a)
  x2 = (-b - disqrt) / (2 * a)
  print "Discriminant is equal to #{discr}, x1 = #{x1}, x2 = #{x2}"
elsif discr == 0
  x1 = -b / (2 * a)
  x2 = x1
  print "Discriminant is equal to #{discr}, x1 = #{x1}, x2 = #{x2}"
else discr < 0
  print "none"
end
