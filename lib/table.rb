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

end
