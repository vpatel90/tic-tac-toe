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
    if player_names.at(1) == nil
      players.push(Computer.new("Nightmaretron"))
      input = diff_set
      players.last.set_difficulty(input)
    end
    table = Table.new
    GameManager.new(players,table)
    #Displays table and basic logic to change items in table
    # new_table.display_table
    # new_table.change(5, "O")
  end

  def diff_set
    puts "How smart do you want me to me?"
    puts "(1) Easy"
    puts "(2) Normal"
    puts "(3) Nightmare"
    print "> "
    input = diff_validate(gets.chomp)
  end

  def diff_validate(input)
    case input.to_i
    when 1
      1
    when 2
      2
    when 3
      3
    else
      puts "Please enter a valid input"
      diff_set
    end

  end

end

new_game = Game.new(["Vivek","Van"])
