require 'rubygems'
require 'sinatra'

set :sessions, true




helpers do

  def opponent_selects
    computer_choices = ['rock', 'paper', 'scissors']
    computer_selection = computer_choices.shuffle[0]
    computer_selection
  end

  def winner!(msg)
    @play_again = true
    @show_hit_or_stay_buttons = false
    @success = "<strong>#{session[:character_name]} wins! </strong> #{msg}"
    session[:player_total] += 1
  end

  def loser!(msg)
    @play_again = true
    @show_hit_or_stay_buttons = false
    @error = "<strong>#{session[:character_name]} loses! </strong> #{msg}"
    session[:opponent_total] += 1
  end

  def tie!(msg)
    @play_again = true
    @show_hit_or_stay_buttons = false
    @success = "<strong>It is a tie </strong> #{msg}"
  end

  
end


before do
 
  
end



get '/'  do
  if session[:character_name]
    redirect '/game'
  else
    redirect '/players'
  end
  
end


get '/players' do
  session[:player_total] = 0
  session[:opponent_total] = 0
  erb :players
end

post '/players' do
  if (params[:character_name].nil?) || (params[:opponent_name].nil?)
    @error = "Please choose a player AND an opponent"
    halt erb(:players)
  end
 session[:character_name] = params[:character_name]
 session[:opponent_name] = params[:opponent_name]
 redirect '/game'
end




get '/game' do
  erb :game
end

get '/game_outcome' do
  player_selection = session[:player_selection]
  session[:opponent_selection]= opponent_selects
  opponent_selection = session[:opponent_selection]

  if player_selection == opponent_selection
    tie!(" Both #{session[:character_name]} and #{session[:opponent_name]} chose #{session[:player_selection]} ")
  elsif (player_selection == "paper" && opponent_selection == 'rock') || (player_selection == "rock" && opponent_selection == 'scissors') || (player_selection == "scissors" && opponent_selection == 'paper')
    winner!("Congratulations, #{session[:character_name]}! You showed #{session[:character_name]} ") 
    
  else
    loser!("Come on #{session[:character_name]}! I know you can do better. Show #{session[:opponent_name]} who is boss next time")
  end


  erb :game_outcome
end


post '/game/player_selection' do
 session[:player_selection] = params[:player_selection]
 redirect '/game_outcome'
end

get '/game_over' do
  erb :game_over
end



















