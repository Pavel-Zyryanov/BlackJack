# frozen_string_literal: true

require_relative 'card'

# :nodoc:
class Deck
  attr_reader :cards

  def initialize
    @cards = []
    create_deck
  end

  def create_deck
    Card::SUIT.each do |suit|
      Card::VALUE.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def pull_out_card
    pull_out_card = @cards[rand(@cards.size)]
    @cards.delete(pull_out_card)
  end
end
