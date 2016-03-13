class GameManager

  def initialize(players,table, renderer)
    @players = players
    @table = table
    @renderer = renderer
    start_game
  end

  def start_game
    refresh_display
    first_turn
  end

  #keeps refreshing display
  def refresh_display
    @renderer.screen_render
    @table.display_table
  end
  #Game Manager determins first turn
  def first_turn
    @turn = 1
    @this_players_turn = @players[0]
    puts "#{@this_players_turn.name} starts"
    take_turn(@this_players_turn)
  end

  #player takes their turn // checks if winner? // sends winner
  #to game-end
  def take_turn(player)
    refresh_display
    player.turn(@table)
    winner = check_win
    check_end(winner)
  end

  #initiates 'other' player's turn
  def change_turn
    @turn += 1
    @this_players_turn = @players.reject{|x| x == @this_players_turn}[0]
    take_turn(@this_players_turn)
  end

  #prompts table class to check if there is a winner
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
      if winner.is_ai
        winner.gloat(winner)
      else
        loser = (@players.reject{|x| x == winner})[0]
        if loser.is_ai
          loser.rematch(winner)
        end
      end
      puts "#{winner.name} wins the game!"
      puts

    else
      puts "Its a tie"
    end
  end
end
