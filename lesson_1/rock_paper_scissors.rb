puts "Hi! Let's play Paper Rock Scissors!"


begin

puts "Enter P for paper, R for rock, or S for scissors"

selection = gets.chomp.upcase

if selection == "P"
  selection = "paper"
elsif selection == "R"
  selection = "rock"
elsif selection == "S"
  selection = "scissors"
end


puts "You picked #{selection}"

computer_choices = ['rock', 'paper', 'scissors']

computer_selection = computer_choices.shuffle[0]

puts "The computer selected #{computer_selection}"

if selection == computer_selection
  puts "It is a tie"
elsif selection == ("paper" && computer_selection == 'rock') || selection == ("rock" && computer_selection == 'scissors') || selection == ("scissors" && computer_selection == 'paper')
  puts "You win!"
else
  puts "You lose"
end

puts "Do you want to play again? (Y/N)"

play_again = gets.chomp.upcase

end while play_again == "Y"

puts "Ok! Thanks for playing! Bye!"