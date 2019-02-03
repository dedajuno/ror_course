puts "Input day: "
day = gets.to_i

puts "Input month: "
month = gets.to_i

puts "Input year: "
year = gets.to_i

days_in_year = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

if year % 4 == 0 && year % 100 != 0
  days_in_year[1] = 29
end

index = day + days_in_year.take(month - 1).sum
print index
