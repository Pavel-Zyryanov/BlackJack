class Interface

  Start_Menu = %(
   1. Начать игру;
   2. Показать правила игры;
   3. Выйти из игры.
  )

  def start_menu
    puts Start_Menu
  end

  Rules = %(
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

  def rules
    puts Rules
  end

  User_Menu = %(
   1. Пропустить ход;
   2. Добавить карту;
   3. Открыть карты;
   4. Выйти из игры.
  )

  def user_menu
    puts User_Menu
  end

  Menu_Next = %(
    Выберите действие:
    1. Новая игра;
    2. Выйти из игры.
  )

  def menu_next
    puts Menu_Next
  end
end