# frozen_string_literal: true

# :nodoc:
class Interface
  attr_accessor :user_name

  START_MENU = %(
   1. Начать игру;
   2. Показать правила игры;
   3. Выйти из игры.
  )

  RULES = %(
    Выигрывает игрок, у которого сумма очков ближе к 21.
    1. Если у игрока сумма очков больше 21, то он проиграл;
    2. Если сумма очков у игрока и дилера одинаковая, то объявляется ничья
    и деньги из банка возвращаются игрокам;
    3. Если игрок выиграл, то сумма из банка игры переходит к игроку;
    Сумма очков по номиналу карт:
    1. От 2 до 10 - по номиналу карты;
    2. Валет, Дама, Король - по 10;
    3. Туз - 1 или 11, в зависимости от того,
    какое значение будет ближе к 21 и что не ведет к проигрышу (сумме более 21).
    Для выхода назад в меню нажмите 1.
  )

  USER_MENU = %(
   1. Пропустить ход;
   2. Добавить карту;
   3. Открыть карты;
   4. Выйти из игры.
  )

  MENU_NEXT = %(
    Выберите действие:
    1. Новая игра;
    2. Выйти из игры.
  )

  def start_menu
    puts 'Игра BlackJack'
    puts START_MENU
  end

  def rules
    puts RULES
  end

  def user_menu
    puts "\n#{@user_name}, ваш ход."
    puts 'Выберите действие:'
    puts USER_MENU
  end

  def menu_next
    puts MENU_NEXT
  end

  def input_user_name
    print 'Введите ваше имя:'
    @user_name = gets.chomp.capitalize!
    puts "\nПриветствую, #{@user_name}!"
    raise StandardError, 'Ошибка. Имя не содержит символов.' if @user_name.nil?
  rescue StandardError => e
    puts e.message
    retry
  end

  def bank(user, diler)
    puts ''
    puts "Ваш банк #{user.bank}$"
    puts "Банк дилера: #{diler.bank}$"
  end

  def rate_text
    puts "#{@user_name} и Дилер сделали ставки по 10$ "
  end

  def open_cards(user, diler)
    puts ''
    puts 'Ваши карты: '
    user.hand.cards.each { |user_cards| puts "Масть: #{user_cards.suit} ,  Карта: #{user_cards.value}" }
    puts "Ваши очки: #{user.hand.points}"
    puts ''
    puts 'Карты дилера: '
    diler.hand.cards.each { |diler_cards| puts "Масть: #{diler_cards.suit} ,  Карта: #{diler_cards.value}" }
    puts "Очки дилера: #{diler.hand.points}"
  end

  def show_cards(user, diler)
    puts 'Ваши карты:'
    user.hand.cards.each { |user_cards| puts "Масть: #{user_cards.suit} ,  Карта: #{user_cards.value}" }
    puts "Ваши очки: #{user.hand.points}"
    puts ''
    puts 'Карты дилера:'
    diler.hand.cards.each { |_diler_cards| puts '...................................' }
  end

  def win_text
    puts "\nВы выиграли!"
  end

  def lose_text
    puts "\nВы проиграли..."
  end

  def draw_text
    puts 'Ничья.'
    puts 'Всем возвращается по 10$'
  end

  def bank_zero_diler
    puts 'У Дилера нет необходимого количества денег (10$) для ставки.'
    end_game
  end

  def bank_zero_user
    puts "У #{@user_name} нет необходимого количества денег (10$) для ставки."
    end_game
  end

  def end_game
    puts 'Конец игры.'
  end
end
