class Player
  attr_accessor :name
  def initalize(n)
    @name = n
  end
end


class Board
  attr_accessor :b
  def initialize
    @b = {}
    (1..9).each {|position| @b[position] = ' '}
  end

  def draw_board 
    system 'clear'
    puts "  #{b[1]}  |  #{b[2]}  |  #{b[3]}  "
    puts "-----------------"
    puts "  #{b[4]}  |  #{b[5]}  |  #{b[6]}  "
    puts "-----------------"
    puts "  #{b[7]}  |  #{b[8]}  |  #{b[9]}  "
  end

  def empty_positions
    b.select {|k, v| v == " " }.keys
  end

  def player_picks_square
    puts "Pick a square. (1-9)"
    position = gets.chomp.to_i
    until empty_positions.include?(position)
      puts "That square is filled. Pick a different square. (1-9)"
      position = gets.chomp.to_i
    end
      b[position] = 'X'
  end


  def computer_picks_square
    position = empty_positions.sample
    b[position] = 'O'
  end

  def check_winner
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
      return "Player" if b.values_at(*line).count('X') == 3
      return "Computer" if b.values_at(*line).count('O') == 3
    end
    nil
  end
end


class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end

def run
  loop do
    @board.draw_board
    
    begin
      board.player_picks_square
      board.computer_picks_square
      board.draw_board
      winner = board.check_winner
    end until winner or board.empty_positions.empty?

    if winner
      puts "#{winner} won!"
      puts "Play again? (y/n)"
      break if gets.chomp.downcase != "y"
    else
      puts "It's a tie!"
      puts "Play again? (y/n)"
      break if gets.chomp.downcase != "y"
    end

    @board = Board.new
  end

  puts "Thanks for playing!"
end



end 





Game.new.run















































