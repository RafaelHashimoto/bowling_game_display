# frozen_string_literal: true

class BowlingMatch
  attr_accessor :players, :errors
  def initialize(game_file)
    @players = []
    @errors  = []
    process_game_file(game_file)
    @players.each(&:calculate_score) if @errros.nil?
  end

  def process_game_file(game_file)
    game_file.each do |line|
      player_name, score  = line.split(' ')
      player = get_player(player_name)
      player.add_score(score)
    end
  rescue StandardError => e
    @errors << e.message
  end

  def display
    puts "\n"
    frames = "Frame\t\t"
    10.times { |i| frames += "#{i + 1}\t\t" }
    puts frames.yellow
    @players.each do |player|
      display_frames = ''
      display_rolls = ''

      player.frames.each do |f|
        display_frames += f.display
        display_rolls += f.display_rolls
      end
      puts player.name.yellow
      puts "Pinfalls\t#{display_rolls}".yellow
      puts "Score\t\t#{display_frames}".yellow
    end
    puts "\n"
  end

  private

  def get_player(player_name)
    player = @players.detect { |player| player.name == player_name }
    if player.nil?
      player = Player.new(player_name)
      @players << player
    end
    player
  end
end
