#Step 1: Draw a Board
#assign player 1 to X and computer to 0
#loop until a winner or all squares are taken

#Step 2: player 1 picks a square
#check for a winner/number of squares

#Step 3: player 2 picks a square
#check for a winner/number of squares
#if there is a winner, show the winner or else it's a tie



def initialize_board
  b = {}
  (1..9).each { |position| b[position] = ' ' }
  b
end

def draw_board(b)
  system 'clear'
  puts "  #{b[1]}  |  #{b[2]}  |  #{b[3]}  "
  puts "-----------------"
  puts "  #{b[4]}  |  #{b[5]}  |  #{b[6]}  "
  puts "-----------------"
  puts "  #{b[7]}  |  #{b[8]}  |  #{b[9]}  "
end

def empty_positions(b)
  b.select {|k, v| v == " " }.keys
end

def player_picks_square(b)
  puts "Pick a square. (1-9)"
  position = gets.chomp.to_i
  until empty_positions(b).include?(position)
    puts "That square is filled. Pick a different square. (1-9)"
    position = gets.chomp.to_i
  end
    b[position] = 'X'
end

def computer_picks_square(b)
  position = empty_positions(b).sample
  b[position] = 'O'
end

def check_winner(b)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    return "Player" if b.values_at(*line).count('X') == 3
    return "Computer" if b.values_at(*line).count('O') == 3
  end
  nil
end

loop do
  
  board = initialize_board
  draw_board(board)
  
  begin
    player_picks_square(board)
    computer_picks_square(board)
    draw_board(board)
    winner = check_winner(board)
  end until winner or empty_positions(board).empty?

  if winner
    puts "#{winner} won!"
    puts "Play again? (y/n)"
    break if gets.chomp.downcase != "y"
  else
    puts "It's a tie!"
    puts "Play again? (y/n)"
    break if gets.chomp.downcase != "y"
  end
end

puts "Thanks for playing!"
