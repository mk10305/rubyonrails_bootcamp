number = 4936
thousands = number/1000
hundreds = number % 1000 /100
tens = number % 1000 % 100 / 10
ones = number % 1000 % 100 % 10 

puts "Thousands = #{thousands}"
puts "Hundreds = #{hundreds}"
puts "Tens= #{tens}"
puts "Ones = #{ones}"