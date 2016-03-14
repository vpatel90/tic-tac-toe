class Renderer

  def initialize
    @colors = [:red, :green, :blue, :yellow]
  end
  def screen_render
    system'clear'
    heading
  end

  def heading
    #puts "TIC TAC TOE".rjust(15," ")
    puts Paint[" /$$$$$$$$/$$                 /$$$$$$$$                        /$$$$$$$$
|__  $$__/__/                |__  $$__/                       |__  $$__/
   | $$   /$$  /$$$$$$$         | $$  /$$$$$$   /$$$$$$$         | $$  /$$$$$$   /$$$$$$
   | $$  | $$ /$$_____/         | $$ |____  $$ /$$_____/         | $$ /$$__  $$ /$$__  $$
   | $$  | $$| $$               | $$  /$$$$$$$| $$               | $$| $$  \\ $$| $$$$$$$$
   | $$  | $$| $$               | $$ /$$__  $$| $$               | $$| $$  | $$| $$_____/
   | $$  | $$|  $$$$$$$         | $$|  $$$$$$$|  $$$$$$$         | $$|  $$$$$$/|  $$$$$$$
   |__/  |__/ \\_______/         |__/ \\_______/ \\_______/         |__/ \\______/  \\_______/",@colors.sample]
    puts '-' * 20
  end

  def render_emoji_choice(emoji_arr, name)
    puts "#{name} Please Select your Icon"
    emoji_arr.each_with_index do |emoji, index|
      puts "#{index+1}. #{emoji}"
    end
    puts
    get_input(emoji_arr)
  end

  def get_input(emoji_arr)
    print "> "
    input = validate_input(gets.chomp.to_i, emoji_arr)
    return input
  end

  def validate_input(input,emoji_arr)
    case input.to_i
    when (1..emoji_arr.length)
      return input.to_i
    else
      puts "Please Enter a Valid input!"
      get_input(emoji_arr)
    end
  end
end
