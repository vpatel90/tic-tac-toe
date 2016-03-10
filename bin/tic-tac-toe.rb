require_relative '../lib/player'
require_relative '../lib/table'
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

    table = Table.new.display_table
  end

end

new_game = Game.new(["Vivek"])
