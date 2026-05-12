# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/player'

RSpec.describe Player do
  subject(:player) { Player.new('Alice', "\u25CB") }

  describe '#initialize' do
    it 'assigns the correct name' do
      expect(player.name).to eq('Alice')
    end

    it 'assigns the correct symbol' do
      expect(player.symbol).to eq("\u25CB")
    end
  end
end
