# :nodoc:
# frozen_string_literal: true

# :nodoc:
class Card
  attr_reader :suit, :value, :point_card

  SUIT = ['heart - ♥', 'diamond - ♦', 'club - ♣', 'spade - ♠'].freeze
  VALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace'].freeze

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end
