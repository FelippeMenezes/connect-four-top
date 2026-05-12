# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) { Board.new }
  let(:sym) { "\u25CB" }

  describe '#win?' do
    it 'returns true for a horizontal win' do
      board.drop_piece(0, sym)
      board.drop_piece(1, sym)
      board.drop_piece(2, sym)
      row, col = board.drop_piece(3, sym)

      expect(board.win?(row, col, sym)).to be true
    end

    it 'returns true for a vertical win' do
      board.drop_piece(0, sym)
      board.drop_piece(0, sym)
      board.drop_piece(0, sym)
      row, col = board.drop_piece(0, sym)

      expect(board.win?(row, col, sym)).to be true
    end

    it 'returns true for an ascending diagonal win' do
      board.drop_piece(0, sym)
      board.drop_piece(1, 'X')
      board.drop_piece(1, sym)
      board.drop_piece(2, 'X')
      board.drop_piece(2, 'X')
      board.drop_piece(2, sym)
      board.drop_piece(3, 'X')
      board.drop_piece(3, 'X')
      board.drop_piece(3, 'X')
      row, col = board.drop_piece(3, sym)

      expect(board.win?(row, col, sym)).to be true
    end

    it 'returns false if there is no win condition' do
      row, col = board.drop_piece(0, sym)
      expect(board.win?(row, col, sym)).to be false
    end
  end

  describe '#full?' do
    it 'returns true when all columns are full' do
      7.times do |c|
        6.times { board.drop_piece(c, sym) }
      end
      expect(board.full?).to be true
    end

    it 'returns false when the board has just started' do
      expect(board.full?).to be false
    end
  end

  describe '#column_available?' do
    it 'returns true for an empty column' do
      expect(board.column_available?(0)).to be true
    end

    it 'returns false for a full column' do
      6.times { board.drop_piece(0, sym) }
      expect(board.column_available?(0)).to be false
    end

    it 'returns false for an out-of-bounds column index' do
      expect(board.column_available?(7)).to be false
      expect(board.column_available?(-1)).to be false
    end
  end
end
