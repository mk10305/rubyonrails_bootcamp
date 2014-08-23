
class Player
  include Comparable
  attr_accessor :name, :choice

  def initialize(n)
    @name = n
  end

  def player_choice
    choices = ['rock', 'paper', 'scissors']
  
    begin
      puts "Enter your selection: rock, paper, or scissors."
      @choice = gets.chomp.downcase
    end until choices.include?(@choice)
    @choice
  end

  def computer_choice

    @choice=['rock', 'paper', 'scissors'].sample
    @choice
  end

  def <=>(computer)
    if @choice == computer.choice
      0
    elsif (@choice == "paper" && computer.choice== 'rock') || (@choice == "rock" && computer.choice == 'scissors') || (@choice == "scissors" && computer.choice == 'paper')
      1
    else
      -1
    end
  end

end



class Game
  attr_accessor  :player, :computer

  def initialize
    @player = Player.new("Player 1")
    @computer = Player.new("R2D2")
  end


  def display_choice
    puts "#{player.name} chose #{player.player_choice}" #why not do player.choice. And difference between putting return
    puts "#{computer.name} chose #{computer.computer_choice}"
  end

  def compare_hands
    if @player == @computer 
      puts "It's a tie"
    elsif @player > @computer 
      puts "#{player.name} won!"
    else
      puts "#{computer.name} won!"
    end
  end

  def play_again
    begin
      puts "Enter Y if you want to play again or N if you do not want to play again"
      play_again_answer = gets.chomp.upcase
      play_again_choices = ['Y', 'N']

      if play_again_answer == "Y"
       g= Game.new
       g.display_choice
       g.compare_hands
       g.play_again
      elsif play_again_answer == "N"
        puts "Thanks for Playing! Bye!"
      end
    end until play_again_choices.include?(play_again_answer)
  end


end

class Game_Engine
  def intitialize
  end
  def game_play
    g= Game.new
    puts "Hi! Let's play Paper, Rock, and Scissors!"
    #puts "You are #{player.name} and you will be playing against #{computer.name}"
     g.display_choice
     g.compare_hands
     g.play_again
  end
end

Game_Engine.new.game_play


