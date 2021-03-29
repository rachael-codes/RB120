# Assignment: OOP 21 
# Date: 03/29/21

require 'yaml'
MESSAGES = YAML.load_file('twenty_one_messages.yml')

DEALER_MAX = 17 
TARGET_POINTS = 21
FACE_CARD_VALUE = 10 
ACE_HIGH_VALUE = 11
ACE_LOW_VALUE = 1

module GameBasics 
	def prompt(msg)
  	puts "=> #{msg}"
	end

	def messages(message)
  	MESSAGES[message]
	end 

	def clear_screen
  	system('clear')
  	system('cls')
	end 

	def enter_to_continue
    prompt("Press enter to continue")
    STDIN.gets
  end

	def welcome_user
  	clear_screen
  	prompt(messages('welcome'))
  	enter_to_continue
  	clear_screen
  	prompt(messages('start_instructions'))
  	enter_to_continue
  	clear_screen
	end 

	def display_goodbye
		prompt "Thanks for playing Twenty One. Goodbye!"
	end 
end 

module Hand 
	def show_hand 
		puts "---- #{name}'s Hand ----"
		puts 
		cards.each { |card| puts "=> #{card}"}
		puts "=> Total: #{total}"
		puts
	end 

	def total
		total = 0
		cards.each do |card|
			if (card.split[0] == 'Ace') && (total + ACE_HIGH_VALUE <= TARGET_POINTS) 
				total += ACE_HIGH_VALUE
			elsif card.split[0] == 'Ace'
				total += ACE_LOW_VALUE
			elsif card.split[0] == 'Jack' || card.split[0] == 'Queen' || card.split[0] == 'King'
				total += FACE_CARD_VALUE
			else 
				total += card.split[0].to_i 
			end 
		end 
		total 
	end 

	def add_card(new_card)
		cards << new_card 
	end 

	def busted?
		total > TARGET_POINTS 
	end 
end 


class Participant
	include Hand 

	attr_accessor :name, :cards 

	def initialize 
		@cards = []
		set_name 
	end 
end

class Player < Participant
	include GameBasics 

  def set_name 
  	name = ''
  	loop do 
  		prompt "What's your name?"
  		name = gets.chomp
  		break unless name.empty?
  		prompt "Sorry, you must enter a value."
  	end 
  	self.name = name
	end

	def show_flop
		show_hand 
	end 
end 

class Dealer < Participant 
	include GameBasics 

	ROBOTS = ['Number Six', 'Hal', 'R2D2']

	def set_name
		self.name = ROBOTS.sample 
	end 

	def show_flop
		puts "---- #{name}'s Hand ----"
		puts 
		prompt "#{cards.first}"
		prompt '???'.center(cards.first.size)
	end 
end

class Deck
	attr_accessor :cards 

	SUITS = ['hearts', 'spades', 'diamonds', 'clubs']
	FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

  def initialize
    @cards = start_new_deck
  end

  def start_new_deck 
  	deck = []
  	SUITS.each { |suit| FACES.each { |face| deck << "#{face} of #{suit}" } } 
  	deck.shuffle
  end 

  def deal_one 
  	cards.pop
  end 
end


class TwentyOne
	include GameBasics 

	attr_accessor :deck, :player, :dealer 

	def initialize 
		@deck = Deck.new 
		@player = Player.new 
		@dealer = Dealer.new 
	end 

	def reset 
		self.deck = Deck.new 
		player.cards = []
		dealer.cards = []
	end 

	def deal_cards 
		2.times do 
			player.add_card(deck.deal_one)
			dealer.add_card(deck.deal_one)
		end 
	end 

	def show_flop
		player.show_flop
		dealer.show_flop
	end 

	def player_turn 
		puts 
		prompt "#{player.name}'s turn..."
		puts 

		loop do 
			prompt "Would you like to hit (h) or stay (s)?"
			puts 
			answer = nil 
			loop do 
				answer = gets.chomp.downcase 
				break if ['h', 's'].include?(answer)
				prompt "Sorry, you must enter 'h' to hit or 's' to stay."
			end

			if answer == 's'
				prompt "#{player.name} stays."
				enter_to_continue 
				clear_screen
				break 
			elsif player.busted? 
				break 
			else 
				player.add_card(deck.deal_one)
				puts
				prompt "#{player.name} hits!"
				puts
				player.show_hand 
				break if player.busted?
			end 
			puts 
			enter_to_continue
		end 
	end 

	def dealer_turn 
		prompt "#{dealer.name}'s turn..."

		loop do 
			if dealer.total >= DEALER_MAX && !dealer.busted?
				prompt "#{dealer.name} stays."
				break 
			elsif dealer.busted?
				break 
			else 
				prompt "#{dealer.name} hits!"
				dealer.add_card(deck.deal_one)
			end 
			puts 
		end 
	end 

	def show_busted
		if player.busted?
			prompt "It looks like #{player.name} busted. #{dealer.name} wins!"
		elsif dealer.busted?
			prompt "It looks like #{dealer.name} busted. #{player.name} wins!"
		end
		puts 
	end 

	def show_cards 
		player.show_hand
		dealer.show_hand
	end 

	def show_result
		if player.total > dealer.total
			prompt "It looks like #{player.name} wins!"
		elsif player.total == dealer.total 
			puts "It's a tie."
		else 
			prompt "It looks like #{dealer.name} wins!"
		end
		puts 
	end 

	def play_again?
		answer = nil
		loop do 
			prompt "Would you like to play again (y/n)?"
			answer = gets.chomp.downcase
			break if ['y', 'n'].include?(answer)
			prompt "Sorry, you must enter 'y' for yes or 'n' for no."
		end 

		answer == 'y' 
	end 

  def start
  	welcome_user
  	loop do 
  		clear_screen
  		deal_cards 
  		show_flop 

  		player_turn 
  		clear_screen
  		if player.busted?
  			show_busted
  			if play_again?
  				reset 
  				next 
  			else 
  				break
  			end 
  		end 

  		dealer_turn 
  		clear_screen
  		if dealer.busted?
  			show_busted
  			enter_to_continue
  			if play_again?
  				reset 
  				next 
  			else 
  				break
  			end 
  		end 

  		#both stayed
  		show_cards 
  		show_result
  		play_again? ? reset : break 
  	end 

  	display_goodbye
  end 
end

TwentyOne.new.start


