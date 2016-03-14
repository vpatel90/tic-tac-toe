class Game
  def initialize(player_names, renderer)
    @renderer = renderer
    @renderer.screen_render
    emoji = ["👻","👽","🕵","😸","🐸","🐶","😀"]
    @players = []
    player_names.each do |name|
      player_emoji = emoji[@renderer.render_emoji_choice(emoji, name) - 1]
      emoji.delete(player_emoji)
      @players.push(Human.new(name, player_emoji))
    end
    if player_names.at(1) == nil
      @players.push(Computer.new("Nightmaretron","🤖"))
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
