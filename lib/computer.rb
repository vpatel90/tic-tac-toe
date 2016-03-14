class Computer < Player
  def initialize(name, sym)
    @name = name
    @wins = 0
    @sym = sym
    @is_ai = true
  end

  def set_difficulty(difficulty)
    @difficulty = difficulty

  end

  def gloat
    ##Called when AI wins
    puts "#{@name} > I WIN!"
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
                      "DIE DIE DIE muah HA HA HA HA HA"]
    smack_talk = smack_talk_arr.sample
    return smack_talk
  end
  def turn(table)
    super
    unless @table.empty
      talk = smack_talk
      puts talk
      `say #{talk}`
    else
      if @difficulty == 3
        `say You are not prepared to face me!`
      end
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
      gloat
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

  def win_if_possible
    almost_losing = @table.get_rows_cols_diag
    my_move = []
    almost_losing.each do |row|
      if row.uniq.length == 2 && (row.count(@sym) == 2)
        row.each do |x|
          if x.class == Fixnum
            my_move.push(row)
          end
        end
      end
    end
    num = 0
    if my_move.empty? == false
      my_move[0].each do |x|
        if x.class == Fixnum
          num = x
        end
      end
    end
    if num == 0
      return nil
    else
      return num
    end
  end

  def stop_enemy_from_winning
    almost_losing = @table.get_rows_cols_diag
    big_threat = []
    almost_losing.each do |row|
      if row.uniq.length == 2 && (row.include?(@sym) == false)
        big_threat.push(row)
      end
    end
    num = 0
    if big_threat.empty? == false
      big_threat[0].each do |x|
        if x.class == Fixnum
          num = x
        end
      end
    end
    if num == 0
      return nil
    else
      return num
    end

  end

  def nightmare_mode
    best_move = win_if_possible
    second_best_move = stop_enemy_from_winning
    if best_move == nil && stop_enemy_from_winning == nil
      original_emptyspaces = @table.empty_spaces
      empty_spaces = []

      original_emptyspaces.map do |space|
        empty_spaces.push([0,space])
      end

      depth = empty_spaces.length
      nodearr = []

      @counter = 0
      empty_spaces.each do |index|
        points = index[0]
        cell = index[1]
        node = Neganode.new(cell, [], points, @name, depth)
        negamax(node, @table, depth, points, @name)
        original_emptyspaces.each do |space|
          @table.change_in_secret(space, space)
        end
        nodearr.push(node)
      end
      best_node = nil
      nodearr.each do |node|
        if best_node == nil
          best_node = node
        elsif best_node.score < node.score
          best_node = node
        end
      end
      @table.change(best_node.cell, @sym)
    else
      if best_move != nil
        gloat
        @table.change(best_move, @sym)
      elsif second_best_move != nil
        @table.change(second_best_move, @sym)
      end
    end
  end

  def negamax(node, table, depth, points, player)
    cell = node.cell
    @counter += 1
    if player == @name
      sym = @sym
    else
      sym = @human.sym
    end

    table.change_in_secret(cell, sym)
    if table.check_table == true
      if player == @name
        return node.score = 10
      else
        return node.score = -10
      end
    else
      node.score = 0
    end

    depth -= 1
    if depth == 0
      return node.score = 0
    end


    if player == @name
      player = @human.name
    else
      player = @name
    end

    parent_node = node
    original_emptyspaces = table.empty_spaces
    empty_spaces = []

    original_emptyspaces.map do |space|
      empty_spaces.push([0,space])
    end
    original_points = points
    nodearr = parent_node.child_nodes

    empty_spaces.each do |index|
      points = index[0]
      cell = index[1]
      node = Neganode.new(cell,[],points,player,depth,parent_node)
      negamax(node, table, depth, points, player)
      original_emptyspaces.each do |space|
        @table.change_in_secret(space, space)
      end
      nodearr.push(node)
    end

    nodearr.each do |node|
      parent_node.score =  parent_node.score + node.score
      if (parent_node.state == @name || parent_node.state == nil )&& node.score > parent_node.score
        parent_node.score =  parent_node.score + node.score
      elsif parent_node.state == @human.name && node.score < parent_node.score
        parent_node.score = parent_node.score - node.score
      elsif
        parent_node.score = parent_node.score
      end
    end
  end

end
