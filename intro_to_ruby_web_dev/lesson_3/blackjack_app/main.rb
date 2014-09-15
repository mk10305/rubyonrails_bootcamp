require 'rubygems'
require 'sinatra'

set :sessions, true

BLACKJACK_AMOUNT = 21
DEALER_MIN_HIT = 17
INITIAL_POT_AMOUNT = 500


helpers do

  def calculate_total(cards)
    #extract values of nested arrays. We don't care about suits
    arr = cards.map{|element| element[1]}

    total = 0
    arr.each do |a|
      if a == "A"
        total += 11
      else
        #if it is 'J', 'Q', etc then it means that it's value is 0, so increment by 10. Otherwise just increment by integer val of card
        total += a.to_i ==0 ? 10: a.to_i
      end
    end

#loop through however many times there is an Ace. If the total is greater than 21, detect 10 from total
  arr.select{|element| element == "A"}.count.times do
    break if total <= BLACKJACK_AMOUNT 
    total -= 10
  end

  total
end

def card_image(card)
  #to build image URL
  suit = case card[0]
    when 'H' then 'hearts'
    when 'D' then 'diamonds'
    when 'C' then 'clubs'
    when 'S' then 'spades'
  end

  value = card[1]

  if ['J', 'Q', 'K', 'A'].include?(value)
    value = case card[1]
      when 'J' then 'jack'
      when 'Q' then "queen"
      when 'K' then "king"
      when 'A' then "ace"
    end
  end

"<img src='/images/cards/#{suit}_#{value}.jpg' class='card_image'>"
end

def winner!(msg)
  @play_again = true
  @show_hit_or_stay_buttons = false
  session[:player_pot] = session[:player_pot] + session[:player_bet]
  @winner = "<strong>#{session[:player_name]} wins! </strong> #{msg}"

end

def loser!(msg)
  @play_again = true
  @show_hit_or_stay_buttons = false
  session[:player_pot] = session[:player_pot] - session[:player_bet]

  if (session[:player_pot] <= 0)
    @play_again = false
    @zero_balance = true
    @loser="<strong>#{session[:player_name]} you lose and have no money left to play another round! </strong> #{msg}"
  else
    @loser = "<strong>#{session[:player_name]} loses! </strong> #{msg}"

  end


end

def tie!(msg)
  @play_again = true
  @show_hit_or_stay_buttons = false
  @winner = "<strong>It is a tie </strong> #{msg}"
end


end


before do
  @show_hit_or_stay_buttons = true
 

end



get '/'  do
  if session[:player_name]
    @game_stats = true
    redirect '/game'
  else
    redirect '/new_player'
  end
  
end


get '/new_player' do
  session[:player_pot] = INITIAL_POT_AMOUNT
  #render form
  erb :new_player
end

post '/new_player' do
  if params[:player_name].empty?
    @error = "Name is required"
    halt erb(:new_player)
  end
 session[:player_name] = params[:player_name]
 redirect '/bet'
end



get '/bet' do
  @game_total = true
 
  session[:player_bet] = nil

  erb :bet
end

post '/bet' do

  if params[:bet_amount].nil? || params[:bet_amount].to_i == 0 
    @error = "You must enter a numerical value for your bet"
    halt erb(:bet)
  elsif params[:bet_amount].to_i > session[:player_pot].to_i
    @error = "The bet amount cannot be greater than what you have ($#{session[:player_pot]})"
    halt erb(:bet)
  else
    session[:player_bet] = params[:bet_amount].to_i
    redirect '/game'
  end
end





get '/game' do
  @game_total = true
  @game_bet = true
  session[:turn] = session[:player_name]
  #create a deck and put it in session
  suits = ['H', 'D', 'C', 'S']
  values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  session[:deck] = suits.product(values).shuffle!

  #deal cards
  session[:dealer_cards] = []
  session[:player_cards] = []
  session[:dealer_cards] << session[:deck].pop
  session[:player_cards] << session[:deck].pop
  session[:dealer_cards] << session[:deck].pop
  session[:player_cards] << session[:deck].pop


  erb :game
end


post '/game/player/hit' do
  @game_total = true
  @game_bet = true
  session[:player_cards] << session[:deck].pop
  player_total = calculate_total(session[:player_cards])
  if player_total == BLACKJACK_AMOUNT 
    winner!("#{session[:player_name]} hit blackjack!")
    @game_bet = false
  elsif player_total  > BLACKJACK_AMOUNT 
    loser!(" It looks like #{session[:player_name]} busted at #{player_total} !")
    @game_bet = false
  end

  erb :game, layout: false 


end

post '/game/player/stay' do
  @game_total = true
  @game_bet = true
  @success = "#{session[:player_name]} has chosen to stay."
  @show_hit_or_stay_buttons = false
  redirect '/game/dealer'
end



get '/game/dealer' do
  @game_total = true
  @game_bet = true
  session[:turn] = "dealer"
  @show_hit_or_stay_buttons = false

  dealer_total = calculate_total(session[:dealer_cards])

  if dealer_total == BLACKJACK_AMOUNT 
    @game_bet = false
    loser!("Dealer hit Blackjack")
  elsif dealer_total > BLACKJACK_AMOUNT 
    @game_bet = false
    winner!("Dealer busted at #{dealer_total}.")
  elsif dealer_total >= DEALER_MIN_HIT
    redirect '/game/compare'
  else
    #dealer hits
  @show_dealer_hit_button = true
    
  end
  erb :game, layout: false

end

post '/game/dealer/hit' do
  @game_total = true
  session[:dealer_cards] << session[:deck].pop
  redirect '/game/dealer'

end

get '/game/compare' do
  @game_total = true
  @game_bet = true
  @show_hit_or_stay_buttons = false
  player_total = calculate_total(session[:player_cards])
  dealer_total = calculate_total(session[:dealer_cards])

  if player_total < dealer_total
    @game_bet = false
    loser!("#{session[:player_name]} stayed at #{player_total}, and the dealer stayed at #{dealer_total}.")
  elsif player_total >dealer_total
    @game_bet = false
    winner!("#{session[:player_name]} stayed at #{player_total}, and the dealer stayed at #{dealer_total}.") 
  else
    @game_bet = false
    tie!(" Both #{session[:player_name]} and the dealer stayed at #{player_total}.")
  end

  erb :game, layout: false

end


get '/game_over' do
  erb :game_over
end



















