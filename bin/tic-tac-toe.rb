require_relative '../lib/renderer'
require_relative '../lib/player'
require_relative '../lib/table'
require_relative '../lib/game_manager'
require_relative '../lib/negamax'
# Starts game => Creates Players (Human and Computer)
# Creates game table
# Creates game manager

class Game
  def initialize(player_names, renderer)
    @renderer = renderer
    @renderer.screen_render
    emoji = ["👻","👽","🤖","😸","🐸","🐶","😀"]
    @players = []
    player_names.each do |name|
      player_emoji = emoji[@renderer.render_emoji_choice(emoji, name) - 1]
      emoji.delete(player_emoji)
      @players.push(Human.new(name, player_emoji))
    end
    if player_names.at(1) == nil
      @players.push(Computer.new("Nightmaretron",emoji.sample))
      input = diff_set
      @players.last.set_difficulty(input)
      @players.last.get_player(@players.first)
    end
    play

  end

  def diff_set
    puts "How smart do you want me to me?"
    puts "(1) Easy"
    puts "(2) Normal"
    puts "(3) Nightmare (Use at your own risk)"#remember to modify diff_validate
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

  def play
    table = Table.new
    GameManager.new(@players,table, @renderer)
    play_again
  end

  def play_again
    puts "Would you like to (P)lay again? check (S)core or (Q)uit"
    puts "> "
    validate(gets.chomp)
  end

  def validate(input)
    case input.upcase
    when "P"
      play
    when "S"
      @players.each do |player|
        puts "#{player.name} has #{player.wins} wins"
      end
      play_again
    when "Q"
      exit
    else
      puts "Please enter a valid input"
      play_again
    end

  end
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
renderer = Renderer.new
renderer.screen_render
puts "Are you playing with a (F)riend or would you like to challenge (N)ightmaretron?"
input = get_input
player_names = get_names(input)
new_game = Game.new(player_names, renderer)
