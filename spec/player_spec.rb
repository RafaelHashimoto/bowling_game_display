require_relative '../spec/spec_helper.rb'

describe Player do
  describe '#initialize' do
    before :all do
      @player = Player.new('tester')
    end

    it 'should set name' do
      expect(@player.name).to eq('tester')
    end

    it 'should set empty frames' do
      expect(@player.frames.empty?).to be_truthy
    end
  end

  describe "#add_score" do
    before :all do
      @player = Player.new('tester')
    end

    it "should create a new frame if frames is empty" do
      @player.add_score('1')
      expect(@player.frames.count).to eq(1)
    end

    it "should create a new roll if the sum of frame scores is less or equal to 10" do
      @player.add_score('9')
      expect(@player.frames.first.rolls.count).to eq(2)
    end
  end

  describe "#calculate_score" do
    before :all do
      @bowling_match = BowlingMatch.new(File.open('./spec/files/strikes.txt'))
    end

    it "should set frame score" do
      expect(@bowling_match.players.first.frames.last.frame_score).to eq(300)
    end
  end
end