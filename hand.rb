# frozen_string_literal: true

require_relative 'deck'

# :nodoc:
class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def pull_in_card(deck)
    @cards << deck.pull_out_card
  end

  def points
    point = 0
    @cards.each do |card|
      value = card.value
      case value
      when 'jack' then point += 10
      when 'queen' then point += 10
      when 'king' then point += 10
      when 'ace'
        point += 11 if point + 11 < 21
        point += 1 if point + 1 > 21
      else
        point += value.to_i
      end
    end
    point
  end
end
