require_relative 'card'
require_relative 'diler'
require_relative 'interface'
require_relative 'player'
require_relative 'user'

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
    puts 'Игра BlackJack'
    @interface.start_menu
    choice = gets.chomp.to_i
    case choice
    when 1
      input_user_name
      puts "\nПриветствую, #{@user_name}!"
      bank
      rate
      distribution_cards
      process
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

  def input_user_name
    print 'Введите ваше имя:'
    @user_name = gets.chomp.capitalize!
    raise StandardError, 'Ошибка. Имя не содержит символов.' if @user_name.nil?
    rescue StandardError => e
    puts e.message
    retry
  end

  def bank
    puts "Ваш банк #{@user.bank}$"
    puts "Банк дилера: #{@diler.bank}$"
  end

  def rate
    @user.rate
    @diler.rate
    puts "#{@user_name} и Дилер сделали ставки по 10$ "
  end

  def distribution_cards
    2.times { @user.score.pull_in_card(@deck) }
    2.times { @diler.score.pull_in_card(@deck) }
    @diler.score.pull_in_card(@deck) if @diler.score.points < 17
  end

  def process
    loop do
      open_cards if @user.score.cards.size == 3 || @diler.score.cards.size == 3
      show_cards
      puts "\n#{@user_name}, ваш ход."
      puts 'Выберите действие:'
      @interface.user_menu
      choose = gets.chomp.to_i
      case choose
      when 1 then skip_turn
      when 2 then add_card
      when 3 then open_cards
      when 4 then exit
      end
    end
  end

  def open_cards
     puts ''
     puts 'Ваши карты: '
     user.score.cards.each { |user_cards| puts"#{user_cards.output_card}" }
     puts "Ваши очки: #{user.score.points}"
     puts ''
     puts 'Карты дилера: '
     diler.score.cards.each { |diler_cards| puts "#{diler_cards.output_card}" }
     puts "Очки дилера: #{diler.score.points}"
     game_over
   end

   def show_cards
     puts 'Ваши карты:'
     @user.score.cards.each { |user_cards| puts user_cards.output_card }
     puts "Ваши очки: #{user.score.points}"
     puts ''
     puts 'Карты дилера:'
     @diler.score.cards.each { |diler_cards| puts '...................................' }
   end

   def skip_turn
     @diler.score.pull_in_card(@deck)
   end

   def add_card
     @user.score.pull_in_card(@deck)
   end

   def game_over
    if ((@user.score.points <= SCORE_VICTORY) && (@user.score.points > @diler.score.points)) || (@diler.score.points > SCORE_VICTORY)
      puts "\nВы выиграли!"
      win
    elsif (@user.score.points > SCORE_VICTORY) || ((@diler.score.points <= SCORE_VICTORY) && (@diler.score.points > @user.score.points))
      puts "\nВы проиграли..."
      lose
    else
      puts 'Ничья.'
      puts 'Всем возвращается по 10$'
      draw
    end
    puts ''
    bank
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
    @user.score.cards = []
    @diler.score.cards = []
    @deck = Deck.new
  end

  def next_game
    @interface.menu_next
    choose = gets.chomp.to_i
    case choose
    when 1
      bank
      rate
      distribution_cards
      process
    when 2
      exit
    end
  end
end
