require_relative '../spec/spec_helper.rb'

describe Frame do
  describe '#initialize' do
    before :all do
      @frame = Frame.new('10', 1)
    end

    it 'should set rolls' do
      expect(@frame.rolls.first.score).to eq(10)
    end

    it 'should set frame_number' do
      expect(@frame.frame_number).to eq(1)
    end
  end

  describe "#is_full?" do
    it "should return true if frame is a strike" do
      @frame = Frame.new('10', 1)
      expect(@frame.is_full?).to be_truthy
    end
  end

  describe "#is_spare?" do
    before :all do
      @frame = Frame.new('9', 1)
      @frame.add_roll('1')
    end

    it "should return true if sum or rolls scores are == 10" do
      expect(@frame.is_spare?).to be_truthy
    end

    it "should return false if sum or rolls scores are < 10" do
      @frame = Frame.new('8', 1)
      @frame.add_roll('1')
      expect(@frame.is_spare?).to be_falsey
    end

    it "should return false if there is only one roll" do
      @frame = Frame.new('10', 1)
      expect(@frame.is_spare?).to be_falsey
    end
  end

  describe "#is_strike?" do
    before :all do
      @frame = Frame.new('10', 1)
    end

    it "should return true if roll score is 10" do
      expect(@frame.is_strike?).to be_truthy
    end

    it "should return false if roll score is < 10 " do
      @frame = Frame.new('9', 1)
      expect(@frame.is_strike?).to be_falsey
    end

    it "should return false if there is more than one roll" do
      @frame.add_roll('1')
      expect(@frame.is_strike?).to be_falsey
    end
  end

  describe "#max_rolls" do
    before :all do
      @frame = Frame.new('10', 1)
    end

    it "should return 2 if frame number is < 10" do
      expect(@frame.max_rolls).to eq(2)
    end

    it "should return 3 if frame number is 10" do
      @frame.frame_number = 10
      expect(@frame.max_rolls).to eq(3)
    end
  end

  describe "#is_last_frame?" do
    before :all do
      @frame = Frame.new('10', 1)
    end

    it "should return false if frame number is < 10" do
      expect(@frame.is_last_frame?).to be_falsey
    end

    it "should return true if frame number is 10" do
      @frame.frame_number = 10
      expect(@frame.is_last_frame?).to be_truthy
    end
  end

  describe "#display" do
    before :all do
      @frame = Frame.new('10', 1)
      @frame.frame_score = 10
    end

    it "should return frame score" do
      expect(@frame.display).to eq("10\t\t")
    end
  end
end