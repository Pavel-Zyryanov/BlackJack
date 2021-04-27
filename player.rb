# frozen_string_literal: true

require_relative 'deck'
require_relative 'hand'

# :nodoc:
class Player
  attr_accessor :bank, :hand, :bet

  def initialize
    @hand = Hand.new
    @bank = 100
    @point = 0
    @bet = 0
  end

  def rate
    if @bank >= 10
      @bank -= 10
      @bet += 10
    else
      exit
    end
  end

  def get_bet(win)
    @bank += win
  end
end
