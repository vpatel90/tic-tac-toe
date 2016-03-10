class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

class Human < Player

end

class Computer < Player

end
