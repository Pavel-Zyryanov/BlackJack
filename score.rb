require_relative 'deck'

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
      if @point + value.max > 21
        @point += value.min
      else
        @point += value.max
      end
    end
    @point
  end
end
