puts "Enter a number between 0 and 100"


number = gets.chomp.to_i

if number < 0
	puts "You can't enter a negative number"

elsif number >= 0 && number <= 50
	puts "The number you entered is between 0 and 50"

elsif number >= 51 && number <= 100
	puts "The number you entered is between 51 and 100"

else
	puts "The number is greater than 100"

end