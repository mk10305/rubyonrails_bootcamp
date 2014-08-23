class Card_Management
  attr_accessor:deck, :player_cards

  def initialize
   puts "Welcome to BlackJack"

    suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
    cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
    @deck = suits.product(cards)

    @player_cards = []
    @dealer_cards = []
  end

  def shuffle_cards
    deck.shuffle!
  end

  def initial_cards_dealing
    @player_cards << deck.pop
    @dealer_cards << deck.pop
    @player_cards << deck.pop
    @dealer_cards << deck.pop
  end


end


class Players < Card_Management
  attr_accessor:player_name

  def initialize
    puts "Hey What's Your Name"
    @player_name = gets.chomp
    puts "Hi! #{player_name}!, My name is R2D2, I will be playing against you"

    
  end
end




deck = Card_Management.new
deck.shuffle_cards
deck.initial_cards_dealing
player = Players.new

