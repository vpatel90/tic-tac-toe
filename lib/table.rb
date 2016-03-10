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

  def change_cell(change_value,symbol)
    index1=(change_value - 1 )/3
    index2=(change_value - 1)/3
    @table_arr[index1][index2] = symbol
  end

end
