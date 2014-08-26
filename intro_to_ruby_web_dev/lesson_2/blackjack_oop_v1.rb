#how to add player

class Player
  attr_accessor :name, :cards, :total
  def initialize(n)
    @name = n
    @cards = []
    @total = 0
  end

  #value of cards method
  def calculate_total
    #create a new array card_values to just contain the values of the cards
    card_values = cards.map {|value| value[1]}
    total = 0

    #loop through these card values. If the value is an Ace, give it 11, if it is J, Q, or K, give it a value of 10. Otherwise just use the face value
    card_values.each do |card|
      if card == 'Ace'
        total += 11
      elsif card.to_i == 0 
        total = total + 10
      else
        total += card.to_i
      end
    end

    #count all the Aces we have using the select and count methods. And then go through the loop the number of times Ace is in the array and subtract 10 each time the total value is over 21.

    card_values.select {|e| e == "A"}.count.times do
      if total > 21
        total -= 10
      end
    end
    @total = total
  end


  def <=>(player)
    if total == player.total
      puts "It is a tie"
    elsif (total < player.total)
      puts "Dealer loses"
    elsif (total > player.total)
      puts "Player wins"
    end
  end
end


  class Deck
    attr_accessor :suits, :cards, :deck
    def initialize
      @suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
      @cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
      @deck = suits.product(cards)
    end

    def shuffle_cards
      deck.shuffle!
    end

  end


  class Game
    attr_accessor :player, :dealer, :game_cards
    def initialize
      puts "Welcome! Let's play some BlackJack"
      puts "Before we start, what is your name?"
      player_name = gets.chomp
      @player = Player.new(player_name)
      @dealer = Player.new("Dealer")
      @game_cards = Deck.new
    end

    def hit(player, msg, name)
      game_cards.shuffle_cards
      new_card = game_cards.deck.pop
      puts msg
      player.cards << new_card
      player.calculate_total
      puts "The new card #{player.name} was dealt with is #{player.cards.last[1]} of #{player.cards.last[0]}"
      puts "#{player.name}'s cards sum up to be #{player.total}"

      if player.total == 21
        puts "#{name} hit BlackJack! #{name} win!"
        play_again
      elsif player.total > 21
        puts "Sorry, looks like #{name} busted. #{name} loses"
        play_again
      end
    end

    def run
      puts "Thanks #{player.name}, I will now deal you and the Dealer two cards"
      puts "Dealing Cards......"

      game_cards.shuffle_cards

      #deal initial cards
      #@player is an object @dealer is an object. They both have empty cards array
      player.cards << game_cards.deck.pop
      dealer.cards << game_cards.deck.pop
      player.cards << game_cards.deck.pop
      dealer.cards << game_cards.deck.pop

      player.calculate_total
      dealer.calculate_total

      #display what cards player and dealer have
      puts "#{@player.name} you have the following cards:#{@player.cards[0][1]} of #{@player.cards[0][0]} and a #{@player.cards[1][1]} of #{@player.cards[1][0]}"
      puts "And Your cards sum up to be #{@player.total}"
      puts ""
      puts "The Dealer's cards: #{@dealer.cards[0][1]} of #{@dealer.cards[0][0]} and the other card is face down"
  
      #player conditionals
      if player.total == 21
        puts "Yay! #{@player.name}, you hit blackjack"
        #Note: Don't need > 21 scenario, because the max value two cards can have is 21
      end

        while player.total < 21 
        puts "Enter 1 if you want to Hit or Enter 2 if you want to Stay"
        hit_or_stay = gets.chomp

        if !['1', '2'].include?(hit_or_stay)
          puts "Error. Please enter either 1 or 2"
          next #next means to go the next iteration of loop
        end

        if hit_or_stay == "2"
          puts "You chose to Stay"
          break #break means exit the loop and compare with dealer's cards
        end
        
        #If the user decides to Hit
        hit(@player, "#{player.name}, you chose hit, dealing new card...", "You")
      end #end while loop

      #dealer_conditionals
      if dealer.total == 21
        puts "Dealer hit BlackJack."
      end

      #dealer keeps hitting until it gets a value of at least 17
      while dealer.total < 17
        hit(@dealer, "The Dealer is choosing to get a new card....", "Dealer")
      end #end while loop


      #show dealer cards
      puts "Dealer cards: "
      dealer.cards.each do |card|
        puts "==> #{card}"
      end

      #show player cards
      puts "Your cards: "
      player.cards.each do |card|
        puts "==> #{card}"
      end

      player <=> dealer
      play_again
    end

    def play_again
      begin
      puts ""
      puts "Would you like to play again? Enter 1 for Yes or Enter 2 for No"
      player_answer = gets.chomp
      play_again_choices = ['1', '2']
      if player_answer == "1"
        puts "Starting a new game"
        game = Game.new.run
      elsif player_answer =="2"
        puts "Goodbye!"
        exit
      end
      end until play_again_choices.include?(player_answer)
      
    end
  end



game = Game.new.run







