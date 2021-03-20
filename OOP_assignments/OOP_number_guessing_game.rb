# RB 120 Small Exercises "Medium 1" Question #7 - Number Guesser Part 2
# Date: 03/20/21 

# Followed basic instructions and added some bonus features: 
# 	-keep track of numbers already guessed so user can't accidentally make the same choice twice 
#   -play again (multiple rounds) option
#   -extract messages to separate module 

module Messagable 
    ROUND_RESULT_MESSAGE = { 
    high: "Your number is too high.",
    low: "Your number is too low.",
    match: "That's the number!"
  }.freeze

  FINAL_RESULT_MESSAGE = {
    win:  "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  INVALID_MESSAGE = { invalid_yes_or_no: "That's not a valid choice. Choose y or n.",
    already_chose_number: "You already guessed that number. Choose a different number.",
    invalid_number: "Invalid guess. Choose again." 
  }.freeze

  def display_welcome_message
    puts "Welcome to the Number Guesser game."
    puts ''
  end 

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end 
end 

class GuessingGame
  include Messagable 

  def initialize(start_range, end_range)
    @start_range = start_range
    @end_range = end_range 
    @guesses = Math.log2((start_range..end_range).to_a.size).to_i + 1 
    @target_num = (start_range..end_range).to_a.sample
    @current_guess = nil 
    @num_guessed = false 
    @already_guessed = []
  end 

  def play 
    display_welcome_message
    loop do 
      main_game_play
      display_final_result 
      reset 
      break unless play_again?  
    end 
    display_goodbye_message
  end 

  private

  def main_game_play
    loop do 
      display_remaining_num_guesses
      prompt_for_number
      display_round_result
      add_to_guessed_list
      decrement_guesses unless @num_guessed 
      break if @num_guessed || @guesses == 0 
    end 
  end 

  def play_again?
    choice = nil
    loop do 
      puts "Would you like to play again? (y or n)"
      choice = gets.chomp 
      break if choice.downcase == 'y' || choice.downcase == 'n'
      puts INVALID_MESSAGE[:invalid_yes_or_no]
    end 
    choice == 'y' 
  end 

  def reset
    @target_num = (@start_range..@end_range).to_a.sample
    @current_guess = nil 
    @num_guessed = false 
    @guesses = Math.log2((@start_range..@end_range).to_a.size).to_i + 1
    @already_guessed = []
  end 

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
      puts "Enter a number between #{@start_range} and #{@end_range}: "
      choice = gets.chomp.to_i
      break if (@start_range..@end_range).include?(choice) && !(@already_guessed.include?(choice))
      display_why_choice_invalid(choice)
    end 
    @current_guess = choice 
  end 

  def display_why_choice_invalid(choice)
    if @already_guessed.include?(choice) 
      puts INVALID_MESSAGE[:already_chose_number]
    else 
      puts INVALID_MESSAGE[:invalid_number]
    end 
  end 

  def decrement_guesses
    @guesses -= 1 
  end 

  def add_to_guessed_list
    @already_guessed << @current_guess
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

game = GuessingGame.new(1, 500)
game.play