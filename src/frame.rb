# frozen_string_literal: true

class Frame
  attr_accessor :frame_score, :rolls, :frame_number

  def initialize(score, frame_number)
    @rolls = []
    add_roll(score)
    @frame_number = frame_number
  end

  def add_roll(score)
    @rolls << Roll.new(score, get_display_score(score))
  end

  def is_full?
    return true  if @rolls.count == max_rolls
    return false if is_last_frame?
    is_strike? ? true : false
  end

  def is_strike?
    (@rolls.count == 1) && (rolls_score_sum == 10)
  end

  def is_spare?
    (@rolls.count == max_rolls) && (rolls_score_sum == 10)
  end

  def is_last_frame?
    @frame_number == 10
  end

  def rolls_score_sum
    @rolls.sum(&:score)
  end

  def max_rolls
    is_last_frame? ? 3 : 2
  end

  def get_display_score(score)
    return 'F' if score.capitalize == 'F'
    return 'X' if score.to_i == 10

    if is_last_frame?
      return score if @rolls.empty?
      return @rolls.last.score + score.to_i == 10 ? '/' : score
    else
      return @rolls.count < max_rolls && rolls_score_sum + score.to_i == 10 ? '/' : score
    end
  end

  def display
    "#{@frame_score}\t\t"
  end

  def display_rolls
    display = ''
    if !is_last_frame? && is_strike?
      display = "\t#{rolls.first.display_score}\t"
    else
      @rolls.each { |r| display += "#{r.display_score}\t" }
    end
    display
  end
end
