require_relative 'deck'
require_relative 'score'


class Player
  attr_accessor :bank, :score, :bet

  @@bet = 0

  def initialize
    @score = Score.new
    @bank = 100
    @point = 0
    @bet = 0
  end

  def rate
    if @bank >= 10
      @bank -= 10
      @bet += 10
    else
      puts 'У игрока нет необходимого количества денег (10 $) для ставки. Конец игры.'
      exit
    end
  end

 def get_bet(win)
    @bank += win
 end

end
