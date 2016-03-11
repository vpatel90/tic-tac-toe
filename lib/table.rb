class Table

  def initialize
    @table_arr = [[1,2,3],[4,5,6],[7,8,9]]
  end

  def empty_spaces
    empty_spaces = []
    @table_arr.each do |row|
      row.each do |num|
        if num.is_a? Fixnum
          empty_spaces.push(num)
        end
      end
    end
    return empty_spaces
  end

  def display_table
    system'clear'
    puts "-" * 14
    @table_arr.each do |row|
      row.each do |num|
        print "| #{num} "
      end
      puts "|"
      puts "-" * 14
    end
  end

  def change(change_value, symbol)
    index1=(change_value - 1)/3
    index2=(change_value - 1)%3
    @table_arr[index1][index2] = symbol
    display_table
  end

  def check_table
    possibilities = check_almost_win
    possibilities.each do |arr|
      return true if arr.uniq.length == 1
    end
    # #checks each row
    # @table_arr.each do |row|
    #   return true if row.uniq.length == 1
    # end
    # #checks each column
    # col = @table_arr[0].length
    # col.times do |index|
    #   holder = []
    #   @table_arr.each do |row|
    #     holder.push(row[index])
    #   end
    #   return true if holder.uniq.length == 1
    # end
    # #checks top left to bottom right diagonals
    # holder = []
    # col.times do |index|
    #   holder.push(@table_arr[index][index])
    # end
    # return true if holder.uniq.length == 1
    # #checks top right to bottom left diagonals
    # holder = []
    # col.times do |index|
    #   holder.push(@table_arr[index][-index-1])
    # end
    # return true if holder.uniq.length == 1
  end

  def check_almost_win
    #checks each row
    arr = []
    @table_arr.each do |row|
      arr.push(row)
    end
    #checks each column
    col = @table_arr[0].length
    col.times do |index|
      holder = []
      @table_arr.each do |row|
        holder.push(row[index])
      end
      arr.push(holder)
    end
    #checks top left to bottom right diagonals
    holder = []
    col.times do |index|
      holder.push(@table_arr[index][index])
    end
    arr.push(holder)
    #checks top right to bottom left diagonals
    holder = []
    col.times do |index|
      holder.push(@table_arr[index][-index-1])
    end
    arr.push(holder)
    return arr
  end
end
