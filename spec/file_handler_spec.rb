# frozen_string_literal: true

require_relative '../spec/spec_helper.rb'

describe FileHandler do
  describe '#file_exists?' do
    it "should return false if file doesn't exist" do
      @file_handler = FileHandler.new('./spec/files/hello.txt')
      expect(@file_handler.file_exists?).to be_falsey
    end

    it 'should return true if file exists' do
      @file_handler = FileHandler.new('./spec/files/valid_file.txt')
      expect(@file_handler.file_exists?).to be_truthy
    end
  end

  describe '#valid_file_extension?' do
    it 'should return false if file extension is different from .txt' do
      @file_handler = FileHandler.new('./spec/files/invalid_file_extension.tx')
      expect(@file_handler.valid_file_extension?).to be_falsey
    end
    it 'should return true if file extension is .txt' do
      @file_handler = FileHandler.new('./spec/files/valid_file.txt')
      expect(@file_handler.valid_file_extension?).to be_truthy
    end
  end

  describe '#valid_score_format?' do
    it 'should return false if score is negative' do
      @file_handler = FileHandler.new('./spec/files/invalid_negative_score.txt')
      expect(@file_handler.valid_score_format?).to be_falsey
    end
    it 'should return false if score is more than 10' do
      @file_handler = FileHandler.new('./spec/files/invalid_positive_score.txt')
      expect(@file_handler.valid_score_format?).to be_falsey
    end
    it "should return false if score is a letter different from 'F'" do
      @file_handler = FileHandler.new('./spec/files/invalid_letter_score.txt')
      expect(@file_handler.valid_score_format?).to be_falsey
    end
    it 'should return true if score is valid' do
      @file_handler = FileHandler.new('./spec/files/valid_file.txt')
      expect(@file_handler.valid_score_format?).to be_truthy
    end
  end

  describe '#file_is_empty?' do
    it 'should return true if file is empty' do
      @file_handler = FileHandler.new('./spec/files/empty_file.txt')
      expect(@file_handler.is_empty_file?).to be_truthy
    end
    it 'should return false if file is not empty' do
      @file_handler = FileHandler.new('./spec/files/valid_file.txt')
      expect(@file_handler.is_empty_file?).to be_falsey
    end
  end

  describe '#is_valid_file?' do
    it 'should return false if file is invalid' do
      @file_handler = FileHandler.new('./spec/files/invalid_letter_score.txt')
      expect(@file_handler.valid_score_format?).to be_falsey
    end
    it 'should set error in errors array' do
      @file_handler = FileHandler.new('./spec/files/invalid_letter_score.txt')
      @file_handler.is_valid_file?
      expect(@file_handler.errors.empty?).to be_falsey
    end
    it 'should return true if score is valid' do
      @file_handler = FileHandler.new('./spec/files/valid_file.txt')
      expect(@file_handler.valid_score_format?).to be_truthy
    end
    it 'should return true if score is valid' do
      @file_handler = FileHandler.new('./spec/files/valid_file.txt')
      @file_handler.is_valid_file?
      expect(@file_handler.errors.empty?).to be_truthy
    end
  end
end
