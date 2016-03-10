require_relative '../lib/player'
require_relative '../lib/table'
require_relative '../lib/game_manager'
# Starts game => Creates Players (Human and Computer)
# Creates game table
# Creates game manager

class Game
  def initialize(player_names)
    players = []
    player_names.each do |name|
      players.push(Human.new(name))
    end
    players.push(Computer.new("Nightmaretron")) if player_names.at(1) == nil
    table = Table.new
    GameManager.new(players,table)
    #Displays table and basic logic to change items in table
    # new_table.display_table
    # new_table.change(5, "O")
  end

end

new_game = Game.new(["Vivek"])
