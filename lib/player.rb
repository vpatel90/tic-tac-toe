class Player
  attr_accessor :name, :wins, :sym
  def initialize(name)
    @name = name
    @wins = 0
    @sym = ""
  end

  def turn(table)
    @table = table
    @valid_input = @table.empty_spaces
    puts "#{@name} its your turn!"
  end
end

class Human < Player
  def turn(table)
    super
    #require 'pry' ; binding.pry
    print "> "
    input = validate(gets.chomp)
    @table.change(input.to_i,@sym)
  end

  def validate(input)
    case
    when @valid_input.include?(input.to_i)
      input.to_i
    else
      puts "Please enter a valid input"
      print "> "
      input=validate(gets.chomp)
    end
  end
end

class Computer < Player
  def set_difficulty(difficulty)
    @difficulty = difficulty
    puts @difficulty
  end
  def turn(table)
    super
    puts "I am thinking"
    sleep 1
    case @difficulty
    when 1
      easy_mode
    when 2
      normal_mode
    when 3
      nightmare_mode
    end
  end

  def easy_mode
  end

  def normal_mode
  end

  def nightmare_mode
  end

end
