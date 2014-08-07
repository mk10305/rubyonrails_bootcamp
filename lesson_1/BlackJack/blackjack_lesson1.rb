#initialize variables
player_cards = []
dealer_cards = []
play_again = "Y"
suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
deck = suits.product(cards)

#shuffle cards method
def shuffle_cards (deck_of_cards)
  deck_of_cards.shuffle!
end


#value of cards method
def calculate_total(cards)
  #create a new array card_values to just contain the values of the cards
  card_values = cards.map {|value| value[1]}
  total = 0
  #loop through these card values. If the value is an Ace, give it a value of 11, if it is Jack, Queen, or King, give it a value of 10. Otherwise, just use the face value
  card_values.each do |card| 
    if card == 'Ace'
      total += 11
    elsif card.to_i == 0 
      total = total + 10
    else
      total += card.to_i
    end
  end
  #count all the Aces we have using the select and count methods. And then go through the loop the number of times Ace is in the array and subtract 10 each time the total value is over 21
  card_values.select {|e| e == "A"}.count.times do
    if total > 21
      total -= 10 
    end
  end
total
end

def play_again
puts "Do you want to play again? (Y/N)"
play_again = gets.chomp.upcase
end


#Start the game
while play_again == "Y"
puts "Welcome! Let's play some BlackJack"
puts "Before we start, what is your name?"
player_name = gets.chomp

puts "Thanks #{player_name}, I will now deal you and the Dealer two cards"
puts "Dealing cards........"

#shuffle cards
shuffle_cards(deck)

#deal initial cards
player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop


#sum of cards
player_total = calculate_total(player_cards)
dealer_total = calculate_total(dealer_cards)


#display what cards player and dealer have
puts "You, #{player_name}, have the following cards:   #{player_cards[0][1]} of #{player_cards[0][0]} and a #{player_cards[1][1]} of #{player_cards[1][0]}"
puts "And Your cards sum up to be #{player_total}"
puts "The Dealer has the following cards:   #{dealer_cards[0][1]} of #{dealer_cards[0][0]} and the other card is face down"


#player conditionals
if player_total == 21
  puts "Yay! #{player_name}, you hit blackjack. You win"
  play_again()
  exit
  # Note: Don't need > 21 scenario, because the max value two cards can have is 21
end

while player_total < 21
  puts "Enter 1 if you want to Hit or Enter 2 if you want to Stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "Error Please enter either 1 or 2"
    #next means to go to the next iteration of loop
    next
  end

  if hit_or_stay == "2"
    puts "You chose to Stay"
    #break means exit the loop and compare with dealer's cards. 
    break;
  end

  #If the user decides to Hit
  shuffle_cards(deck)
  new_player_card = deck.pop
  puts "#{player_name}, you chose to hit, dealing new card....."
  player_cards << new_player_card
  player_total = calculate_total(player_cards)
  puts "The new card you were dealt with is #{player_cards.last[1]} of #{player_cards.last[0]}"
  puts "Your cards sum up to be #{player_total}"

  if player_total == 21
    puts "Congratulations, you hit blackjack! You win"
    play_again()
    exit
  elsif player_total > 21
    puts "Sorry, looks like you busted. You lose"
    play_again()
    exit
  end
end




#dealer conditionals
if dealer_total == 21
  puts "Dealer hit BlackJack. Sorry you lose"
  play_again()
  exit
end

#dealer keeps hitting until it gets a value of at least 17
while dealer_total < 17
  shuffle_cards(deck)
  new_dealer_card = deck.pop
  puts "The Dealer is choosing to get a new card."
  dealer_cards << new_dealer_card
  dealer_total = calculate_total(dealer_cards)
  puts "The Dealer's cards sum up to be #{dealer_total}"

  #During this process of hitting, need to check if the dealer gets 21 or gets over 21. 
  if dealer_total == 21
    puts "Sorry, the Dealer hit Black. You lose"
    play_again()
    exit
  elsif dealer_total > 21
    puts "Congratulations, the Dealer busted! You win"
    play_again()
    exit
  end
end


#show dealer cards
puts "Dealers cards: "
dealer_cards.each do |card|
  puts "==> #{card}"
end

#show player cards
puts "Your cards: "
player_cards.each do |card|
  puts "==> #{card}"
end

#the dealer either has 17,18,19 or 20. And the player at this point decided to stay. So compare the total values of each to see who won.
if dealer_total > player_total
  puts "Sorry, Dealer won"
  play_again()
  exit
elsif dealer_total < player_total
  puts "Yay, #{player_name}, you win!"
  play_again()
  exit
else 
  puts "It is a tie"
  play_again()
  exit
end
end

puts "Bye"

















