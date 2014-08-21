
class Player
  attr_accessor:name
  def initialize(n)
    @name = n
  end
end



class Game < Player
   include Comparable
   attr_accessor:user_selection, :computer_selection, :player, :computer

   def initialize
     choices = ['rock', 'paper', 'scissors'] 
     puts "Hi! Let's play Paper, Rock, and Scissors!"

     begin
     puts "Enter your selection: rock, paper, or scissors."
     @user_selection = gets.chomp
     end until choices.include?(@user_selection)

     @computer_selection = choices.shuffle[0]

     @player = Player.new("Bob")
     @computer = Player.new("R2D2")
   end


def selection_msg
     puts "You chose and the computer chose #{computer_selection}" 
end



def <=> (another_hand)
  if self.user_selection == other_hand.computer_selection
    0
  elsif (self.user_selection == "paper" && other_hand.computer_selection== 'rock') || (self.user_selection == "rock" && other_hand.computer_selection == 'scissors') || (self.user_selection == "scissors" && other_hand.computer_selection == 'paper')
    1
  else 
    -1
  end
end

def compare_hands
    if player.user_selection == computer.computer_selection
      puts "It's a tie"
    elsif player.user_selection > computer.computer_selection
      puts "You won!"
    else
      puts "Computer won!"
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
game.compare_hands
game.play_again


