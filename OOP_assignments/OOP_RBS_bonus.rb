# RB120 OOP Assignment #1: OO Rock Paper Scissors Bonus Features
# Date: 03/13/21

RULES = <<-MSG
Here are the rules to win:
    -Rock crushes scissors and lizard.
    -Paper covers rock and disproves Spock.
    -Scissors cuts paper and decapitates lizard.
    -Lizard poisons Spock and eats paper.
    -Spock vaporizes rock and smashes scissors.
    
    You will go first. Each time you win, you will get one point.
    The first to reach five points will be the grand winner of the game.
MSG

CHOICES_SHORTHAND = <<-MSG 
Please make a selection:
  1) 'r' for rock
  2) 'p' for paper
  3) 'sc' for scissors
  4) 'l' for lizard
  5) 'sp' for spock
MSG

ROUNDS_TO_WIN = 5

module GameBasics 
  def clear_screen
    (system 'clear') || (system 'cls')
  end

  def prompt(message)
    puts "==> #{message}"
    puts 
  end 

  def pause 
    sleep(4)
  end 

  def enter_to_continue
    prompt("Press enter to continue")
    STDIN.gets
  end
end 

module Displayable 
  def invalid_input
    prompt("Sorry, the input is invalid. Try again.")
  end 

  def read_game_rules
    prompt(RULES)
  end 

  def display_choices
    prompt(CHOICES_SHORTHAND)
  end 

  def display_robot 
    prompt("In this game, you will battle #{computer.name}.")
  end 

  def display_welcome_message
    center_value = 61 + human.name.size
    line_length = 55 + human.name.size
    puts
    puts "  |" + "-" * line_length + "|"
    puts ("|  Welcome to Rock, Paper, Scissors, Lizard, Spock, #{human.name}!   |").center(center_value)
    puts "  |" + "-" * line_length + "|"
    puts 
  end

  def display_goodbye_message
    puts 
    prompt("Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!")
  end

  def display_game_winner
    case human.wins <=> computer.wins
    when -1
      puts "#{computer.name} won the game!"
    when 1
      puts "#{human.name} won the game!"
    else
      puts "Error, we tiredddd, we give up!"
    end
    puts
  end

  def display_move_history
    puts "Game Summary:"
    puts "#{human.name} played: #{human.move_history}."
    puts "#{computer.name} played: #{computer.move_history}."
  end

  def display_game_results
    display_game_winner
    display_move_history
  end

  def display_moves
    puts 
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_round_winner
    case human.move <=> computer.move
    when -1
      computer.won_round
      puts "#{computer.name} won this round!"
    when 1
      human.won_round
      puts "#{human.name} won this round!"
    else
      puts "It's a tie this round!"
    end
    puts 
  end

  def display_round_results
    display_moves
    display_round_winner
    display_game_score
  end

  def display_game_score
    puts "The score is #{human.name}: #{human.wins}, " \
         "#{computer.name}: #{computer.wins}"
    puts 
  end
end 

class Player
  include GameBasics
  include Displayable 

  attr_accessor :move, :name
  attr_reader :wins 

  def initialize
    @wins = 0
    @move_history = []
  end

  def to_s
    @name
  end

  def won_round
    @wins += 1
  end

  def won_game?
    @wins == ROUNDS_TO_WIN
  end

  def move_history
    @move_history.join(', ')
  end

  def save_last_move
    @move_history << move if !!move
    nil
  end

  def reset
    @wins = 0
    @move_history = []
    @move = nil
  end
end

class Human < Player
  def initialize 
    super 
    set_name
  end 

  def set_name
    n = ''
    loop do
      prompt("What's your name?")
      n = gets.chomp
      break unless n.empty?
      invalid_input
    end
    self.name = n
  end

  def choose
    choice = nil

    loop do
      display_choices
      choice = gets.chomp
      break if Move.valid?(choice)
      invalid_input
    end

    choice = Move.longhand(choice)
    self.move = Move.new(choice)
  end
end

class Computer < Player
  NAMES = ['NumberSix', 'R2D2', 'WALL-E']
  TENDENCIES = { 'NumberSix' => ['scissors', 'scissors', 'scissors', 'scissors', 'spock', 'lizard', 'paper'],
                 'R2D2' => ['rock'],
                 'WALL-E' => ['rock', 'paper', 'scissors', 'lizard', 'spock'] }

  def initialize
    super 
    @name = set_name
    @tendency = set_tendency
  end 

  def set_name
    NAMES.sample
  end

  def set_tendency
    TENDENCIES[@name]
  end

  def choose
    self.move = Move.new(@tendency.sample)
  end

  def reset
    super 
    initialize
  end
end

class Move
  HANDS = ['rock', 'paper', 'scissors', 'spock', 'lizard']
  SHORT_HANDS = { 'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors',
                  'sp' => 'spock', 'l' => 'lizard' }
  WINNING_COMBOS = { 'rock' => ['scissors', 'lizard'],
                     'paper' => ['rock', 'spock'],
                     'scissors' => ['paper', 'lizard'],
                     'spock' => ['scissors', 'rock'],
                     'lizard' => ['spock', 'paper'] }

  attr_reader :hand 

  def initialize(hand)
    @hand = hand
  end

  def <=>(other_move)
    other_hand = other_move.hand
    return 0 if hand == other_hand
    return 1 if WINNING_COMBOS[hand].include?(other_hand)
    return -1 if WINNING_COMBOS[other_hand].include?(hand)
    nil
  end

  def to_s
    @hand
  end

  def self.valid?(choice)
    HANDS.include?(choice) || SHORT_HANDS.keys.include?(choice)
  end

  def self.longhand(choice)
    return nil if !valid?(choice)

    if SHORT_HANDS.keys.include?(choice)
      return SHORT_HANDS[choice]
    end

    choice
  end

  def to_longhand!
    return nil if !valid?(@hand)

    if SHORT_HANDS.keys.include?(@hand)
      @hand = SHORT_HANDS[@hand]
    end

    self
  end
end

# Game Orchestration Engine
class RPSGame
  include GameBasics
  include Displayable

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play
    welcome 
    loop do
      clear_screen
      loop do
        display_robot
        player_turns
        display_round_results
        break if a_game_winner?
      end
      display_game_results
      break unless play_again?
      reset_game
    end
    goodbye 
  end

  private 

  attr_reader :human, :computer

   def welcome 
    clear_screen
    display_welcome_message
    enter_to_continue
    read_game_rules
    enter_to_continue
    clear_screen
  end 

  def goodbye 
    clear_screen
    display_goodbye_message
    pause 
    clear_screen
  end 

  def player_turns
    human.choose
    human.save_last_move
    computer.choose
    computer.save_last_move
  end

  def a_game_winner?
    human.won_game? || computer.won_game?
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include? answer
      invalid_input
    end
    answer == 'y' || answer == 'yes'
  end

  def reset_game
    human.reset
    computer.reset
  end
end

RPSGame.new.play

