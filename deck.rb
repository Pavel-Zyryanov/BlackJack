require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    create_deck
  end

 def create_deck
   Card::SUIT.each do |suit|
     Card::VALUE.each_with_index do |value, i|
       @cards << Card.new(suit, value, Card::POINT_CARD[i])
    end
  end
 end

 def pull_out_card
   pull_out_card = @cards[rand(@cards.size)]
   @cards.delete(pull_out_card)
 end
end
