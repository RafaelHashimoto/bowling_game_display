# frozen_string_literal: true

class Player
  attr_accessor :name, :frames

  def initialize(name)
    @name = name
    @frames = []
  end

  def add_score(score)
    if @frames.empty?
      @frames << Frame.new(score, 1)
    elsif @frames.last.is_full?
      if @frames.count + 1 <= 10
        @frames << Frame.new(score, @frames.count + 1)
      else
        raise 'Frame exceeds limit'
      end
    elsif valid_score?(score)
      @frames.last.add_roll(score)
    else
      raise 'Invalid roll value'
    end
  end

  def calculate_score
    @frames.each_with_index do |f, index|
      previous_score = index.positive? ? @frames[index - 1].frame_score : 0
      f.frame_score = if f.is_strike?
                        10 + previous_score + next_two_scores(index).to_i
                      elsif f.is_spare?
                        10 + previous_score + next_score(index)
                      else
                        f.rolls_score_sum + previous_score
                      end
    end
  end

  def next_two_scores(index)
    if @frames[index + 1].is_strike?
      @frames[index + 1].rolls[0].score + next_score(index + 1)
    else
      @frames[index + 1].rolls.first(2).sum(&:score)
    end
  end

  def next_score(index)
    @frames[index + 1].rolls.first.score
  end

  def valid_score?(score)
    last_score = @frames.last.rolls.last.score
    last_score < 10 && last_score + score.to_i > 10 ? false : true
  end
end
