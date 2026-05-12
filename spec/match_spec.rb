# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/match'

RSpec.describe Match do
  let(:board) { instance_double('Board') }
  let(:player1) { instance_double('Player', name: 'Player 1', symbol: "\u25CB") }
  let(:player2) { instance_double('Player', name: 'Player 2', symbol: "\u25CF") }

  before do
    allow(Board).to receive(:new).and_return(board)
    allow(Player).to receive(:new).with('Player 1', "\u25CB").and_return(player1)
    allow(Player).to receive(:new).with('Player 2', "\u25CF").and_return(player2)

    allow($stdout).to receive(:puts)
  end

  subject(:match) { Match.new }

  describe '#switch_player' do
    it 'switches between player 1 and player 2' do
      expect(match.instance_variable_get(:@current_player)).to eq(player1)
      match.send(:switch_player)
      expect(match.instance_variable_get(:@current_player)).to eq(player2)
      match.send(:switch_player)
      expect(match.instance_variable_get(:@current_player)).to eq(player1)
    end
  end

  describe '#move' do
    before do
      allow(match).to receive(:print)
    end

    it 'returns the column index (input - 1) when the move is valid' do
      allow(match).to receive(:gets).and_return("3\n")
      allow(board).to receive(:column_available?).with(2).and_return(true)

      expect(match.send(:move)).to eq(2)
    end

    it 'prompts for new input if the first column is full' do
      allow(match).to receive(:gets).and_return("1\n", "2\n")
      allow(board).to receive(:column_available?).with(0).and_return(false)
      allow(board).to receive(:column_available?).with(1).and_return(true)

      expect(match.send(:move)).to eq(1)
    end
  end

  describe '#play' do
    before do
      allow(board).to receive(:display)
      allow(match).to receive(:move).and_return(0)
      allow(board).to receive(:drop_piece).and_return([5, 0])
      allow(board).to receive(:full?).and_return(false)
    end

    it 'ends the game when there is a winner' do
      allow(board).to receive(:win?).and_return(false, true)

      expect($stdout).to receive(:puts).with("\nCongratulations! Player 2 wins!")
      match.play
    end

    it 'ends the game in a draw when the board is full' do
      allow(board).to receive(:win?).and_return(false)
      allow(board).to receive(:full?).and_return(true)

      expect($stdout).to receive(:puts).with("\nDraw! The board is full.")
      match.play
    end

    it 'handles invalid input for column selection by re-prompting' do
      allow(match).to receive(:move).and_call_original
      allow(match).to receive(:print)
      allow(match).to receive(:gets).and_return("invalid\n", "9\n", "1\n")
      allow(board).to receive(:column_available?).and_return(false, false, true)
      allow(board).to receive(:win?).and_return(true)

      allow($stdout).to receive(:puts).with('Welcome to Connect Four!')
      allow($stdout).to receive(:puts).with('Player 1: ○ vs Player 2: ●')
      expect($stdout).to receive(:puts).with('Invalid move! Try again.').twice
      expect($stdout).to receive(:puts).with("\nCongratulations! Player 1 wins!")
      allow(board).to receive(:display)

      match.play
    end
  end
end
