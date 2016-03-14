class Player
  attr_accessor :name, :wins, :sym, :is_ai
  def initialize(name, sym)
    @name = name
    @wins = 0
    @sym = sym
    @is_ai = false
  end

  def turn(table)
    @table = table
    @valid_input = @table.empty_spaces
    puts "#{@sym}: #{@name} its your turn!"
  end
end
