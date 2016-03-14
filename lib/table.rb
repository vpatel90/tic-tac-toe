class Table
  attr_accessor :empty
  def initialize
    @table_arr = [[1,2,3],
                  [4,5,6],
                  [7,8,9]]
    @empty = true
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
    puts
    puts Paint[" -  -  -  -  -  -  - ", :green]
    @table_arr.each do |row|
      row.each do |num|
        print Paint[" |",:green]
        print "#{num} ".rjust(4, " ")
      end
      puts Paint["|".rjust(2, " "), :green]
      puts Paint[" -  -  -  -  -  -  - ", :green]
    end
  end

  def change_in_secret(change_value, symbol)
    @empty = false
    index1=(change_value - 1)/3
    index2=(change_value - 1)%3
    @table_arr[index1][index2] = symbol
  end

  def change(change_value, symbol)
    @empty = false
    index1=(change_value - 1)/3
    index2=(change_value - 1)%3
    @table_arr[index1][index2] = symbol
    display_table
  end

  def check_table
    possibilities = get_rows_cols_diag
    possibilities.each do |arr|
      return true if arr.uniq.length == 1
    end
    return false
  end

  def get_rows_cols_diag
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
