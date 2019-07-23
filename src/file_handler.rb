# frozen_string_literal: true

class FileHandler
  attr_accessor :file_path, :errors, :players
  ALLOWED_FILE_EXTENSIONS = ['.txt'].freeze
  ONLY_NUMBER_REGEX = /\d+/.freeze

  def initialize(file_path)
    @file_path = file_path
    @players = {}
  end

  def get_file
    File.open(file_path)
  end

  def is_valid_file?
    self.errors = []
    begin
      raise "File doesn't exist" unless file_exists?
      raise 'File is empty' if is_empty_file?
      raise 'Invalid file extension' unless valid_file_extension?
      raise 'File has invalid score' unless valid_score_format?
    rescue StandardError => e
      errors << e.message
    end
    errors.empty?
  end

  def valid_file_extension?
    ALLOWED_FILE_EXTENSIONS.include? File.extname(file_path)
  end

  def file_exists?
    File.file?(file_path)
  end

  def is_empty_file?
    File.zero?(file_path)
  end

  def valid_score_format?
    self.errors = []
    File.open(file_path).each_with_index do |line, index|
      if line.split(' ').size < 2
        errors << "Invalid input at line #{index + 1}"
      else
        name  = line.split(' ')[0]
        score = line.split(' ')[1]
        if score[ONLY_NUMBER_REGEX].nil?
          errors << "Invalid score at line #{index + 1}" if score.capitalize != 'F'
        else
          errors << "Score out of range at line #{index + 1}" if score.to_i < 0 || score.to_i > 10
        end
      end
    end
    errors.empty?
  end
end
