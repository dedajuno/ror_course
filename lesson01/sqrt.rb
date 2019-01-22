puts "Input a:"
a = gets.to_i
puts "Input b:"
b = gets.to_i
puts "Input c:"
c = gets.to_i

D = b ** 2 - 4 * a * c

if D > 0 
  x1 = (-b + Math.sqrt(D)) / (2 * a)
  x2 = (-b - Math.sqrt(D)) / (2 * a)
  print "Discriminant is equal to #{D}, x1 = #{x1}, x2 = #{x2}"
elsif D == 0
  x1 = -b / (2 * a)
  x2 = x1
  print "Discriminant is equal to #{D}, x1 = #{x1}, x2 = #{x2}"
else D < 0
  print "none"
end
