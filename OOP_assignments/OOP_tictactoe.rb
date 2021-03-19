# Assignment: OOP Tic Tac Toe
# Date: 03/19/21

module Formattable
  def joinor(arr, punc =', ', conj = 'or ')
    count = 1
    stopper = (arr.size * 2 - 1)

    if arr.size == 1
      arr[0]
    elsif arr.size == 2
      arr.insert(1, " #{conj}")
    else 
      until count == stopper
        arr.insert(count, punc)
        count += 2
      end 
      arr.insert(-2, conj)
    end
    arr.join('')
  end 

  def clear
    system "clear"
  end
end 

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset_squares
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked? }
  end

  def tie?
    unmarked_keys.empty?
  end

  def someone_won_round?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset_squares
    (1..9).each {|key| @squares[key] = Square.new}
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end

end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class TTTPlayer
  attr_reader :marker, :wins, :name, :board 

  def initialize(board)
    @board = board
    @wins = 0 
    set_name
    set_marker
  end

  def won_round
    @wins += 1
  end

  def won_game?(max = TTTGame::ROUNDS_TO_WIN)
    @wins >= max
  end
end

class Human < TTTPlayer 
  include Formattable 

  attr_reader :board

  def choose_move
    square = nil 
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    square
  end

  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "That's not a valid choice."
    end
    @name = n
  end

  def set_marker
    m = nil
    loop do
      puts "Choose a game marker (such as 'X' or 'O')"
      m = gets.chomp.chr
      break unless m.empty? || m == '-'
      puts "That's not a valid choice."
    end
    @marker = m
  end
end

class Computer < TTTPlayer 
  def set_name 
    @name = 'Computer'
  end 

  def set_marker
    @marker = '@'
  end
end 


class TTTGame
  include Formattable

  ROUNDS_TO_WIN = 3 

  def initialize
    @board = Board.new
    @human = Human.new(@board)
    @computer = Computer.new(@board)
    @round = 1
    set_first_move
  end

  def play
    display_rules_message
    loop do
      players_move
      display_round_results
      break if someone_won_game? || !continue_to_next_round?
      reset
    end
    display_game_results if someone_won_game?
    display_goodbye_message
  end

  private

  attr_accessor :board
  attr_reader :human, :computer

  def main_game
    loop do
      display_board
      player_move
      display_result
      increment_win_totals
      break unless play_again?
      reset
      display_num_of_wins
      display_play_again_message
    end
  end 

  def set_first_move
    @current_marker = @round.odd? ? human.marker : computer.marker
  end

  def players_move
    loop do
      current_player_moves
      break if board.someone_won? || board.tie?
    end
  end 

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_rules_message
    puts ""
    puts "Welcome #{human.name}!"
    puts "You will be playing against the computer."
    puts "The first to win #{ROUNDS_TO_WIN} rounds wins the game!"
    puts "Press enter to begin."
    gets.chomp
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    clear_screen
    puts "You (#{human.name}) are #{human.marker}s. " \
         "The computer is #{computer.marker}s."
    puts ""
    board.display
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def players_move
    loop do
      current_player_moves
      break if board.someone_won_round? 
    end
  end

  def display_score
    puts "#{human.name}: #{human.wins}, Computer: #{computer.wins}."
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_board
    puts ""
    board.draw
    puts ""
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def current_player_moves
    case @current_marker
    when human.marker
      display_board
      human_moves
      @current_marker = computer.marker 
    when computer.marker
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_moves
    choice = human.choose_move
    board[choice] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def human_wins
    human.won_round
    puts "#{human.name} wins this round!"
  end

  def computer_wins
    computer.won_round
    puts "The computer wins this round!"
  end

  def display_round_results
    display_board
    case board.winning_marker
    when human.marker     then human_wins
    when computer.marker  then computer_wins
    else                  puts "It's a tie!"
    end
    display_score
  end

  def continue_to_next_round?
    answer = nil
    loop do
      puts "Continue to the next round? (y or n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "That's not a valid choice."
    end
    answer == 'y' || answer == 'yes'
  end

  def someone_won_game?
    human.won_game? || computer.won_game?
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomtiep.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def display_game_results
    case human.wins <=> computer.wins
    when 1  then puts "You won the game!"
    when -1 then puts "Computer won the game!"
    else         puts "Error, we tiredddd, we give up!"
    end
  end

  def reset
    @round += 1
    set_first_move
    board.reset_squares
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
