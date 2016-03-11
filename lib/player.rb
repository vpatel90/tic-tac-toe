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
    # @table = table
    # @valid_input = @table.empty_spaces
    # puts "#{@name} its your turn!"
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
    ##AI chooses randomly
    @table.change(@valid_input.sample, @sym)
  end

  def normal_mode
    ## AI chooses the win if possible
    ##AI Play's defense if player is about to win
    almost_losing = @table.check_almost_win
    big_threat = []
    my_move = []
    almost_losing.each do |row|
      if row.uniq.length == 2 && (row.include?(@sym) == false)
        big_threat.push(row)
      elsif row.uniq.length == 2 && (row.count(@sym) == 2)
        row.each do |x|
          if x.class == Fixnum
            my_move.push(row)
          end
        end
      end
    end
    if my_move.empty? == false
      num = 0
      my_move[0].each do |x|
        if x.class == Fixnum
          num = x
        end
      end
      @table.change(num, @sym)
    elsif big_threat.empty? == false
      num = 0
      big_threat[0].each do |x|
        if x.class == Fixnum
          num = x
        end
      end
      @table.change(num, @sym)
    else
      @table.change(@valid_input.sample, @sym)
    end
  end

  def nightmare_mode
  end

end
