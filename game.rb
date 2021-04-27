# frozen_string_literal: true

require_relative 'card'
require_relative 'diler'
require_relative 'interface'
require_relative 'player'
require_relative 'user'

# :nodoc:
class Game
  attr_accessor :user, :deck, :diler

  SCORE_VICTORY = 21

  def initialize
    @user = User.new
    @diler = Diler.new
    @deck = Deck.new
    @interface = Interface.new
  end

  def start
    @interface.start_menu
    choice = gets.chomp.to_i
    case choice
    when 1
      @interface.input_user_name
      game
    when 2
      @interface.rules
      choice = gets.chomp.to_i
      case choice
      when 1
        start
      end
    when 3
      exit
    end
  end

  def distribution_cards
    2.times { @user.hand.pull_in_card(@deck) }
    2.times { @diler.hand.pull_in_card(@deck) }
    @diler.hand.pull_in_card(@deck) if @diler.hand.points < 17
  end

  def process
    loop do
      if @user.hand.cards.size == 3 || @diler.hand.cards.size == 3
        @interface.open_cards(@user, @diler)
        game_over
      else
        @interface.show_cards(@user, @diler)
        @interface.user_menu
        choose = gets.chomp.to_i
        case choose
        when 1 then skip_turn
        when 2 then add_card
        when 3 then @interface.open_cards(@user, @diler)
        when 4 then exit
        end
      end
    end
  end

  def rate_change
    if @diler.bank.zero?
      @interface.bank_zero_diler
      exit
    elsif @user.bank.zero?
      @interface.bank_zero_user
      exit
    else
      @user.rate
      @diler.rate
      @interface.rate_text
    end
  end

  def skip_turn
    @diler.hand.pull_in_card(@deck)
  end

  def add_card
    @user.hand.pull_in_card(@deck)
  end

  def game
    @interface.bank(@user, @diler)
    rate_change
    distribution_cards
    process
  end

  def game_over
    if ((@user.hand.points <= SCORE_VICTORY) && (@user.hand.points > @diler.hand.points)) || (@diler.hand.points > SCORE_VICTORY)
      @interface.win_text
      win
    elsif (@user.hand.points > SCORE_VICTORY) || ((@diler.hand.points <= SCORE_VICTORY) && (@diler.hand.points > @user.hand.points))
      @interface.lose_text
      lose
    else
      @interface.draw_text
      draw
    end
    @interface.bank(@user, @diler)
    clear
    next_game
  end

  def win
    @user.get_bet(@user.bet)
    @user.bank += 10
    @user.bet = 0
    @diler.bet = 0
  end

  def lose
    @diler.get_bet(@diler.bet)
    @diler.bank += 10
    @diler.bet = 0
    @user.bet = 0
  end

  def draw
    @user.bank += 10
    @diler.bank += 10
    @user.bet = 0
    @diler.bet = 0
  end

  def clear
    @user.hand.cards = []
    @diler.hand.cards = []
    @deck = Deck.new
  end

  def next_game
    @interface.menu_next
    choose = gets.chomp.to_i
    case choose
    when 1
      game
    when 2
      exit
    end
  end
end
