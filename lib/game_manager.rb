class GameManager

  def initialize(players,table)
    @players = players
    @table = table
    start_game
  end

  def start_game
    refresh_display
    first_turn
  end

  def refresh_display
    @table.display_table
  end
  #Game Manager determins first turn
  def first_turn
    @turn = 1
    @this_players_turn = @players.sample
    puts "#{@this_players_turn.name} starts"
    take_turn(@this_players_turn)
  end

  def take_turn(player)
    refresh_display
    player.turn
    winner = check_win
    check_end(winner)
  end

  def change_turn
    @turn += 1
    @this_players_turn = @players.reject{|x| x == @this_players_turn}[0]
    puts "now its #{@this_players_turn.name}'s turn"
    take_turn(@this_players_turn)
  end

  def check_win
    return @this_players_turn if @table.check_table == true
    nil
  end

  def check_end(winner)
    if @turn == 9 && winner.nil?
      game_end(winner)
    elsif winner
      winner.wins += 1
      game_end(winner)
    else
      change_turn
    end
  end

  def game_end(winner)
    refresh_display
    if winner
      puts "#{winner.name} wins game end"
    else
      puts "Its a tie"
    end
  end
end
