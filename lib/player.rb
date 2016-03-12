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
  def initialize(name, sym)
    @name = name
    @wins = 0
    @sym = sym
    @is_ai = true
  end

  def set_difficulty(difficulty)
    @difficulty = difficulty
    puts @difficulty
  end

  def gloat(winner)
    ##Called when AI wins
    puts "#{winner.name} > I WIN!"
    `say You cannot defeat me! Will you dare to challenge Nightmaretron again!`
  end

  def rematch(winner)
    puts "#{winner.name}, you got lucky"
    `say you got lucky, challenge #{@name} again if you dare!`
  end

  def smack_talk
    smack_talk_arr = ["Is that the best you got?",
                      "Ha! I got you now",
                      "My cat is smarter than you",
                      "How did you survive this long",
                      "Your existence is a curse for humanity",
                      "Shrek is love, Shrek is life",
                      "Perhaps you should try an easier game",
                      "You are smart enough to be republican candidate",
                      "Do your friends know how stupid you are? Do you even have friends?",
                      "Your parents must be sooo..... disappointed",
                      "DIE DIE DIE muah HA HA HA HA HA",
                      "This just isn't your day"]
    smack_talk = smack_talk_arr.sample
    return smack_talk
  end
  def turn(table)
    super
    unless @table.empty
      talk = smack_talk
      puts talk
      #`say #{talk}`
    end
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
    almost_losing = @table.get_rows_cols_diag
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
      easy_mode
    end
  end


  def get_player(player)
    @human = player
  end

  def nightmare_mode
    original_emptyspaces = @table.empty_spaces
    empty_spaces = []

    original_emptyspaces.map do |space|
      empty_spaces.push([0,space])
    end

    depth = empty_spaces.length
    best_cell = []
    @counter = 0
    empty_spaces.each do |index|
      points = index[0]
      cell = index[1]
      points = negamax(cell, @table, depth, points, @name)

      original_emptyspaces.each do |space|
        @table.change_in_secret(space, space)
      end

      best_cell.push([points,cell])


    end

    best_cell = best_cell.sort


    @table.change(best_cell.last[1],@sym)

  end

  def negamax(cell, table, depth, points, player)
    @counter += 1
    if player == @name
      sym = @sym
    else
      sym = @human.sym
    end

    table.change_in_secret(cell, sym)
    if table.check_table == true
      if player == @name
        return points = 10
      else
        return points = -10
      end
    else
      points = points
    end


    if depth == 0
      return points
    end
    depth -= 1

    if player == @name
      player = @human.name
    else
      player = @name
    end

    original_emptyspaces = table.empty_spaces
    empty_spaces = []

    original_emptyspaces.map do |space|
      empty_spaces.push([0,space])
    end
    original_points = points
    best_cell = []

    empty_spaces.each do |index|
      points = index[0]
      cell = index[1]
      points = points + negamax(cell, table, depth, points, player)
      original_emptyspaces.each do |space|
        @table.change_in_secret(space, space)
      end
      best_cell.push([points,cell])
    end

    points_to_return = 0
    best_cell.each do |index|
      points_to_return = points_to_return + index[0]
    end
    return points_to_return
  end


end
