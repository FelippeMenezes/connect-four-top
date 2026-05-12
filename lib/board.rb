# frozen_string_literal: true

# board class
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def display
    puts "\n 1 2 3 4 5 6 7"
    @grid.each do |row|
      print '|'
      row.each { |cell| print cell.nil? ? ' |' : "#{cell}|" }
      puts
    end
    puts '---------------'
  end

  def drop_piece(column, symbol)
    return false unless column_available?(column)

    5.downto(0) do |row|
      if @grid[row][column].nil?
        @grid[row][column] = symbol
        return [row, column]
      end
    end
  end

  def column_available?(column)
    column.between?(0, 6) && @grid[0][column].nil?
  end

  def full?
    @grid.all? { |row| row.none?(&:nil?) }
  end

  def win?(row, col, symbol)
    check_direction?(row, col, symbol, 0, 1) ||
      check_direction?(row, col, symbol, 1, 0) ||
      check_direction?(row, col, symbol, 1, 1) ||
      check_direction?(row, col, symbol, 1, -1)
  end

  private

  def check_direction?(row, col, symbol, row_delta, col_delta)
    count = 1
    count += count_in_direction(row, col, symbol, row_delta, col_delta)
    count += count_in_direction(row, col, symbol, -row_delta, -col_delta)
    count >= 4
  end

  def count_in_direction(row, col, symbol, row_delta, col_delta)
    count = 0
    r = row + row_delta
    c = col + col_delta

    while valid_position?(r, c) && @grid[r][c] == symbol
      count += 1
      r += row_delta
      c += col_delta
    end
    count
  end

  def valid_position?(row, col)
    row.between?(0, 5) && col.between?(0, 6)
  end
end
