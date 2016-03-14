class Human < Player
  def turn(table)
    super
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
