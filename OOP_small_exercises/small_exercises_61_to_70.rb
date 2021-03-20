# RB 120 Small Exercises "Medium 1" problems (1-10)
# Date: 03/19/21

# Question 1: Privacy (Further Exploration)
# Modify this class so both flip_switch and the setter method switch= are private methods.
# Add a private getter for @switch to the Machine class, and add a method to Machine that shows how to use that getter.

class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def display_state
  	case switch 
  		when :on then "The switch is on."
  		else 					"The switch is off."
  	end 
  end 

  private 
  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

cylon1 = Machine.new 
cylon1.start 
cylon1.stop
# puts cylon1.display_state

#-----------------------------------------------------------------------------------------------------------------------

# Question 2 Fixed Array
# A fixed-length array is an array that always has a fixed number of elements. 
# Write a class that implements a fixed-length array, and provides the necessary methods to support the following code:

# class FixedArray
# 	attr_reader :array 

# 	def initialize(array_length)
# 		@array = Array.new(array_length) #here we use a collaborator object 
# 	end 

# 	def [](index)
# 		array.fetch(index) # `fetch` raises an IndexError exception if the index is out range
# 	end 

# 	def []=(index, value)
# 		array[index] = value
# 	end 

# 	def to_a
# 		array.clone # we clone bc we don't want the caller doing something to that Array that will make our FixedArray inconsistent
# 	end 

# 	def to_s
# 		to_a.to_s
# 	end 
# end 

# fixed_array = FixedArray.new(5)
# puts fixed_array[3] == nil
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts fixed_array[3] == 'a'
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

# fixed_array[1] = 'b'
# puts fixed_array[1] == 'b'
# puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

# fixed_array[1] = 'c'
# puts fixed_array[1] == 'c'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

# fixed_array[4] = 'd'
# puts fixed_array[4] == 'd'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
# puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

# puts fixed_array[-1] == 'd'
# puts fixed_array[-4] == 'c'

# begin
#   fixed_array[6]
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[-7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

#-----------------------------------------------------------------------------------------------------------------------

# Question 3: Students 
# Fill in the missing implementation details so that the following requirements are fulfilled:
# 1 . Graduate students have the option to use on-campus parking, while Undergraduate students do not.
# 2. Graduate and Undergraduate students both have a name and year associated with them. 
# ** alter no more than 5 lines of code

# Further exploration: Can you think of a way to use super() in another Student related class?

# class StudentBody                               # Further exploration class 
#   @@total_students = 0

#   def initialize
#     @@total_students += 1
#     @student_number = @@total_students
#   end

#   def self.display_size
#   	@@total_students
#   end 
# end

# class Student < StudentBody
#   def initialize(name, year)
#     @name = name
#     @year = year
#     super()                                     # Further exploration 
#   end
# end

# class Graduate < Student 
#   def initialize(name, year, parking)
#   	super(name, year)
#   	@parking = parking 
#   end
# end

# class Undergraduate < Student 
#   def initialize(name, year)
#   	super 
#   end
# end

# rachael = Graduate.new('Rachael', 2008, 501)
# p rachael 

# nihar = Undergraduate.new('Nihar', 2008)
# p nihar
# puts StudentBody.display_size

#-----------------------------------------------------------------------------------------------------------------------

# Exercise 4: Circular Queue
# A circular queue is a collection of objects stored in a buffer that is treated as though it is connected end-to-end 
# in a circle. 
# Your task is to write a CircularQueue class that implements a circular queue for arbitrary objects. 
# The class should obtain the buffer size with an argument provided to CircularQueue::new
# Provide the following methods:
# 		enqueue to add an object to the queue
# 		dequeue to remove (and return) the oldest object in the queue. It should return nil if the queue is empty

class CircularQueue 
	def initialize(max_size)
		@array = []
		@max_size = max_size
	end 

	def enqueue(int)
		if @array.size < @max_size 
			@array << int 
		else 
			dequeue && @array.push(int)
		end 
	end 

	def dequeue
		@array.shift 
	end 
end 

# queue = CircularQueue.new(3)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# queue = CircularQueue.new(4)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

#-----------------------------------------------------------------------------------------------------------------------

# Exercise 5 - Stack Machine Interpretation
require 'set'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(program)
    @program = program
  end

  def eval
    @stack = []
    @register = 0
    @program.split.each { |token| eval_token(token) }
  rescue MinilangError => error
    puts error.message
  end

  private

  def eval_token(token)
    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    @stack.push(@register)
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end

  def add
    @register += pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def mult
    @register *= pop
  end

  def sub
    @register -= pop
  end

  def print
    puts @register
  end
end

#-----------------------------------------------------------------------------------------------------------------------

# Exercise 6 - Number Guesser Part 1 
# Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses 
# per game. The game should play like this:

class GuessingGame
	RANGE = 1..100
	MAX_GUESSES = 7 

	ROUND_RESULT_MESSAGE = { 
		high: "Your number is too high.",
		low: "Your number is too low.",
		match: "That's the number!"
	}.freeze

	FINAL_RESULT_MESSAGE = {
    win:  "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize
    @guesses = MAX_GUESSES 
    @target_num = rand(RANGE)
    @current_guess = nil 
    @num_guessed = false 
  end 

  def play 
    loop do 
      display_remaining_num_guesses
      prompt_for_number
      display_round_result
      decrement_guesses unless @num_guessed 
      break if @num_guessed || @guesses == 0 
    end 
    display_final_result 
  end 

  private

  def display_remaining_num_guesses
    if @guesses == 1 
      puts "You have #{@guesses} guess remaining."
    else 
      puts "You have #{@guesses} guesses remaining."
    end 
  end 

  def prompt_for_number
    choice = nil 
    loop do 
      puts "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      choice = gets.chomp.to_i
      break if RANGE.include?(choice)
      puts "Invalid guess. "
    end 
    @current_guess = choice 
  end 

  def decrement_guesses
    @guesses -= 1 
  end 

  def display_round_result
    if @target_num == @current_guess 
      puts ROUND_RESULT_MESSAGE[:match]
      @num_guessed = true 
    elsif @current_guess < @target_num
      puts ROUND_RESULT_MESSAGE[:low]
    else 
      puts ROUND_RESULT_MESSAGE[:high]
    end 
  end

  def display_final_result
    if @guesses == 0 
      puts FINAL_RESULT_MESSAGE[:lose]
    else 
      puts FINAL_RESULT_MESSAGE[:win]
    end 
    puts "The number was #{@target_num}."
  end 
end 

game = GuessingGame.new
game.play

#-----------------------------------------------------------------------------------------------------------------------

# Exercise 7 - see separate "OOP_number_guessing_game.rb" file 

#-----------------------------------------------------------------------------------------------------------------------

# Exercise 8 - Highest and Lowest Ranking Cards
# Update this class so you can use it to determine the lowest ranking and highest ranking cards in an Array of Card objects:

class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
  	"#{rank} of #{suit}"
  end 
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards 
# 2 of Hearts 
# 10 of Diamonds
# Ace of Clubs

# puts cards.min == Card.new(2, 'Hearts') # true 
# puts cards.max == Card.new('Ace', 'Clubs') # true 

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts') # true 
# puts cards.max == Card.new(5, 'Hearts') # true 

# cards = [Card.new(4, 'Hearts'),
#          Card.new(4, 'Diamonds'),
#          Card.new(10, 'Clubs')]
# puts cards.min.rank == 4 # true 
# puts cards.max == Card.new(10, 'Clubs') # true 

# cards = [Card.new(7, 'Diamonds'),
#          Card.new('Jack', 'Diamonds'),
#          Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds') # true 
# puts cards.max.rank == 'Jack' # true 

# cards = [Card.new(8, 'Diamonds'),
#          Card.new(8, 'Clubs'),
#          Card.new(8, 'Spades')]
# puts cards.min.rank == 8 # true 
# puts cards.max.rank == 8 # true 

#-----------------------------------------------------------------------------------------------------------------------

# Exercise 9 
class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize 
    reset
  end 

  def draw
    reset if @deck.empty?
    @deck.pop 
  end 

  private 

  def reset
    @deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end
    @deck.shuffle!
  end 
end

class Card < Deck 
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end 

  def value
    VALUES.fetch(rank, rank)
  end 

  def <=>(other_card)
    value <=> other_card.value
  end     
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.

#-----------------------------------------------------------------------------------------------------------------------

# Exercise 10 - Poker 

class PokerHand
  def initialize(cards)
    @cards = []
    @rank_count = {}

    5.times do 
      card = cards.draw 
      @cards << card 
      @rank_count[card.rank] += 1
    end 
  end 

  def print
    puts @cards  
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def n_of_a_kind?(number)
    @rank_count.one? { |_, count| count == number }
  end 

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def pair?
    n_of_a_kind?(2)
  end

  def full_house?
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end

  def royal_flush?
    straight_flush? && @cards.min.rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def flush?
    target_suit = @cards.first.suit 
    @cards.all? { |card| card.suit == target_suit }
  end

  def straight?
    return false if @rank_count.any? { |_, count| count > 1 }
    @cards.min.value == @cards.max.value - 4 
  end

  def two_pair?
    @rank_count.select { |_, count| count == 2 }.size == 2
  end
end 

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize 
    reset
  end 

  def draw
    reset if @deck.empty?
    @deck.pop 
  end 

  private 

  def reset
    @deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end
    @deck.shuffle!
  end 
end

class Card < Deck 
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end 

  def value
    VALUES.fetch(rank, rank)
  end 

  def <=>(other_card)
    value <=> other_card.value
  end     
end

