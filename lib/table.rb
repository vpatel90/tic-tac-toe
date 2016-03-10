class Table

  def initialize
    @table_arr = [[1,2,3],[4,5,6],[7,8,9]]
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
    #checks each row
    @table_arr.each do |row|
      return true if row.uniq.length == 1
    end
    #checks each column
    col = @table_arr[0].length
    col.times do |index|
      holder = []
      @table_arr.each do |row|
        holder.push(row[index])
      end
      return true if holder.uniq.length == 1
    end
    #checks top left to bottom right diagonals
    holder = []
    col.times do |index|
      holder.push(@table_arr[index][index])
    end
    return true if holder.uniq.length == 1
    #checks top right to bottom left diagonals
    holder = []
    col.times do |index|
      holder.push(@table_arr[index][-index-1])
    end
    return true if holder.uniq.length == 1
  end

end
