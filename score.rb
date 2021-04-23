# frozen_string_literal: true

require_relative 'deck'

# :nodoc:
class Score
  attr_accessor :cards
  attr_reader :point

  def initialize
    @cards = []
    @point = 0
  end

  def pull_in_card(deck)
    @cards << deck.pull_out_card
  end

  def points
    @point = 0
    @cards.each do |card|
      value = card.point_card
      @point += if @point + value.max > 21
                  value.min
                else
                  value.max
                end
    end
    @point
  end
end
