f_array = [1,2]

loop do 
  fibo = f_array[-1] + f_array[-2]
  break if fibo > 100
  f_array << fibo
end
print f_array
