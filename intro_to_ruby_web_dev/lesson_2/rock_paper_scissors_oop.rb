

class Game
   attr_accessor:user_selection, :computer_selection

def initialize
  choices = ['rock', 'paper', 'scissors'] 
  puts "Hi! Let's play Paper, Rock, and Scissors!"

  begin
  puts "Enter your selection: rock, paper, or scissors."
  @user_selection = gets.chomp
  end until choices.include?(@user_selection)

  @computer_selection = choices.shuffle[0]
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
  puts "Enter Y if you want to play again or N if you do not want to play again"
  play_again_answer = gets.chomp.upcase
  if play_again_answer == "Y"
    game = Game.new
    game.selection_msg
    game.score_calculation
    game.play_again
  elsif play_again_answer =="N"
    puts "Thanks for Playing! Bye!"
  else
    puts "Please Enter Y or N"
  end

 
end

end



game = Game.new
game.selection_msg
game.score_calculation
game.play_again


