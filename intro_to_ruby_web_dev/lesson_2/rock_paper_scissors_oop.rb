

class Game
   attr_accessor:user_selection, :computer_selection

def initialize
  puts "Hi! Let's play Paper, Rock, and Scissors!"
  puts "Enter your selection: rock, paper, or scissors."
  @user_selection = gets.chomp
  computer_choices = ['rock', 'paper', 'scissors'] 
  @computer_selection = computer_choices.shuffle[0]
end


def selection_msg
     puts "You chose #{user_selection} and the computer chose #{computer_selection}" 
end


def score_calculation
  if user_selection == computer_selection
    puts "It is a tie"
  elsif (user_selection == "paper" && computer_selection == 'rock') || (user_selection == "rock" && computer_selection == 'scissors') || (user_selection == "scissors" && computer_selection == 'paper')
  puts "You win!"
  else
  puts "You lose"
  end
end


def play_again
  puts "Do you want to play again? (Y/N)"
  play_again = gets.chomp.upcase
  if play_again == "Y"
    game = Game.new
    game.selection_msg
    game.score_calculation
    game.play_again
  else
    puts "Okay, Thanks for Playing!"
  end
end

end



game = Game.new
game.selection_msg
game.score_calculation
game.play_again


