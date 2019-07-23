# frozen_string_literal: true

require './src/file_handler.rb'
require './src/bowling_match.rb'
require './src/player.rb'
require './src/roll.rb'
require './src/frame.rb'
require 'pry'
require 'colorize'

@continue   = true
@file_path  = './files/'

# METHODS - BEGIN
def display_header
  puts "\n\n"
  puts ('* ' * 85).green
  puts ('*' * 170).green
  puts 'BOWLING SCORE DISPLAY'.center(170).green
  puts ('*' * 170).green
  puts ('* ' * 85).green
  puts "\n\n"
end

def display_footer
  puts "\n\n"
  puts ('* ' * 85).green
  puts ('*' * 170).green
  puts 'BYE!!!'.center(170).green
  puts ('*' * 170).green
  puts ('* ' * 85).green
  puts "\n\n"
end

def display_errors(errors)
  puts "\n\n"
  puts ('*' * 170).red
  puts 'ERRORS'.center(170).red
  puts "\n"
  errors.each do |error|
    puts "-> #{error}".center(170).red
  end
  puts "\n"
  puts ('*' * 170).red
  puts "\n\n"
end

def set_file_handler
  puts "\n"
  puts 'Please enter the name of the file you want to load: '.blue
  file_name = gets.chomp.to_s
  FileHandler.new(@file_path + file_name)
end

def show_files
  puts "\n\n"
  puts ('*' * 170).green
  puts 'AVAILABLE FILES'.center(170).green
  Dir[@file_path + '*'].each do |file_name|
    puts file_name.center(170).green
  end
  puts ('*' * 170).green
  puts "\n\n"
end

def user_options
  keep_loop = true
  load_file = true
  while keep_loop
    puts "\n"
    puts 'Do you want to load a file?(y/n):'.blue
    user_choice = gets.chomp.to_s
    keep_loop = false if user_choice.capitalize == 'Y'
    load_file = true if user_choice.capitalize == 'Y'
    if keep_loop
      puts 'Do you want to quit?(y/n):'.yellow
      user_choice = gets.chomp.to_s
      load_file = !(user_choice.capitalize == 'Y')
      keep_loop = load_file
    end
  end
  load_file
end

def load_file
  file_handler = set_file_handler
  if file_handler.is_valid_file?
    bowling_game = BowlingMatch.new(file_handler.get_file)
    if bowling_game.errors.empty?
      bowling_game.display
    else
      display_errors bowling_game.errors
    end
  else
    display_errors file_handler.errors
  end
end
# METHODS - END

display_header

while @continue
  show_files
  @continue = user_options
  load_file if @continue
end

display_footer
