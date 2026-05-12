# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Match class
class Match
  def initialize
    @board = Board.new
    @player1 = Player.new('Player 1', "\u25CB")
    @player2 = Player.new('Player 2', "\u25CF")
    @current_player = @player1
  end

  def play
    welcome_message
    loop do
      @board.display
      column = move
      row, col = @board.drop_piece(column, @current_player.symbol)

      if @board.win?(row, col, @current_player.symbol)
        @board.display
        puts "\nCongratulations! #{@current_player.name} wins!"
        break
      elsif @board.full?
        @board.display
        puts "\nDraw! The board is full."
        break
      end

      switch_player
    end
  end

  private

  def welcome_message
    puts 'Welcome to Connect Four!'
    puts "#{@player1.name}: #{@player1.symbol} vs #{@player2.name}: #{@player2.symbol}"
  end

  def move
    loop do
      print "\n#{@current_player.name}, choose a column (1-7): "
      input = gets.chomp.to_i - 1
      return input if @board.column_available?(input)

      puts 'Invalid move! Try again.'
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
