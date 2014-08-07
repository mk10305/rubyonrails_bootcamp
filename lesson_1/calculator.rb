def prompt(msg) 
  puts "==> #{msg}"
end

def integer(value)
  value.to_i
  end

prompt "Welcome!"
prompt "Please enter the first number?"
num1 = gets.chomp

prompt "Please enter the second number?"
num2 = gets.chomp

prompt "Enter 1 for Addition, 2 for Subtraction, 3 for multiplication, and 4 for division"
operator = gets.chomp


if operator == '1'
  result = integer(num1) + integer(num2)
elsif operator == '2'
  result = integer(num1) - integer(num2)
elsif operator == '3'
  result = integer(num1) * integer(num2)
elsif operator == '4'
  result = num1.to_f / num2.to_f

end

prompt "The result is #{result}"