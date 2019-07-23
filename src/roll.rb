# frozen_string_literal: true

class Roll
  attr_accessor :score, :display_score
  def initialize(score, display_score)
    @display_score = display_score
    @score = score.capitalize == 'F' ? 0 : score.to_i
  end
end
