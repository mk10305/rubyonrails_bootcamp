require 'rubygems'
require 'sinatra'

set :sessions, true




helpers do
  def initialize_board
    b = {}
    (1..9).each { |position| b[position] = ' ' }
    b
  end



  def empty_positions(b)
    b.select {|k, v| v == " " }.keys
  end

  def player_picks_square(b,position)
   unless b[position] == 'X' || b[position] =='O'
    b[position]= 'X'
    end
    b
  end

  def computer_picks_square(b)
    position = empty_positions(b).sample
    b[position] = 'O' if position
    b
  end

  def check_winner(b)
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
      return "Player" if b.values_at(*line).count('X') == 3
      return "Computer" if b.values_at(*line).count('O') == 3
    end
    nil
  end

  def winner!
    @play_again = true
    @game_on = true
    session[:player_total] += 1
    @success = "<strong> #{session[:character_name]} wins! </strong> "

  end

  def loser!
    @play_again = true
    @game_on = true
    session[:opponent_total] += 1
    @error = "<strong> #{session[:character_name]} loses! </strong> "
   
  end

  def tie!
    @play_again = true
    @game_on = true
    @success = "<strong>It is a tie </strong> "
  end

  def icon_image(player)
    #to build image URL
    icon = case player
      when 'Bugs Bunny' then 'bugs_bunny'
      when 'Road Runner' then 'road_runner'
      when 'Tweety Bird' then 'tweety'
      when 'Porky Pig' then 'porky_pig'
      when 'Elmer Fudd' then 'elmer_fudd'
      when 'Wile E. Coyote' then 'coyote'
      when 'Sylvester the Cat' then 'sylvester'
      when 'Daffy Duck' then 'daffy_duck'
    end

  "<img class='navbar-right navimage' src='/images/icons/#{icon}.jpg'>"
  end

end


before do
end


get '/'  do
  session[:board] = initialize_board
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



post '/players/:pos' do
  pos= params[:pos].to_i
  session[:board] = player_picks_square(session[:board], pos)  # saving player's position
  session[:board] = computer_picks_square(session[:board]) # computer play


  winner = check_winner(session[:board])


 if winner
    #puts winner
    if winner == "Player"
      winner!
    elsif winner == "Computer"
      loser!
    end
    erb :game
  else
if empty_positions(session[:board]).empty?
   tie!
   erb :game
else
 redirect '/game'
 end

   
  end
 
end

get '/game' do
  @game_on = true
  erb :game
end

get '/game_over' do
  @game_on = false
  erb :game_over
end