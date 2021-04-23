class Card
  attr_reader :suit, :value, :point_card

  SUIT = ['heart - ♥', 'diamond - ♦', 'club - ♣', 'spade - ♠']
  VALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
  POINT_CARD = [[2], [3], [4], [5], [6], [7], [8], [9], [10], [10], [10], [10], [1, 11]]

  def initialize (suit, value, point_card)
  @suit = suit
  @value = value
  @point_card = point_card
  end

  def output_card
    puts "Масть: #{suit} ,  Карта: #{value}, Очки карты: #{point_card}"
  end
end
