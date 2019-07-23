# frozen_string_literal: true

require_relative '../spec/spec_helper.rb'

describe Roll do
  describe '#initialize' do
    before :all do
      @roll = Roll.new('10', 'X')
    end

    it 'should set score' do
      expect(@roll.score).to eq(10)
    end

    it 'should set display score' do
      expect(@roll.display_score).to eq('X')
    end

    it 'should convert any score string to integer' do
      expect(@roll.score.is_a?(Integer)).to be_truthy
    end
  end
end
