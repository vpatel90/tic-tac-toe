require_relative '../lib/game'
require_relative '../lib/renderer'
require_relative '../lib/player'
require_relative '../lib/table'
require_relative '../lib/game_manager'
require_relative '../lib/negamax'
require_relative '../lib/computer'
require_relative '../lib/human'
require_relative '../paint/lib/paint.rb'
# Starts game => Creates Players (Human and Computer)
# Creates game table
# Creates game manager

class PlayerData
  def initialize
    renderer = Renderer.new
    renderer.screen_render
    puts "Are you playing with a (F)riend or would you like to challenge (N)ightmaretron?"
    input = get_input
    player_names = get_names(input)
    new_game = Game.new(player_names, renderer)
  end

  def validate(input,names)
    if names
      if input.length == 0
        return "Player #{rand(99)}"
      end
      return input
    else
      case input.upcase
      when "F"
        2
      when "N"
        1
      else
        get_input
      end
    end
  end

  def get_input(names=false)
    print "> "
    input = validate(gets.chomp,names)
  end

  def get_names(n)
    names = []
    n.times do |x|
      puts "What is Player #{x+1}'s name?"
      name = get_input(true)
      names.push(name)
    end
    return names
  end
end
PlayerData.new
