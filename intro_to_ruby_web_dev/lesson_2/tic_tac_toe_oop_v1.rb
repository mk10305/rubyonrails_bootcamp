class Board

  def initialize
    @data = {}
    (1..9).each{|position| @data[position] = Square.new('')}
  end


  def draw
    puts "Drawing .. board.."
    puts @data.inspect
  end


end


class Square
  def initialize(value)
    @value = value
  end
end

board = Board.new
board.draw