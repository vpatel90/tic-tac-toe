class Player
  attr_accessor :name, :wins
  def initialize(name)
    @name = name
    @wins = 0
  end

  def turn
    puts "#{@name} its your turn!"
    sleep 1
  end
end

class Human < Player

end

class Computer < Player

end
