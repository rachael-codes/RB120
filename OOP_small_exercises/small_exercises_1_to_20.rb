# RB 120 OOP Small Exercises - Exercises 1-20 
# Date: 03/08/21

# EXERCISE 1 
puts "Hello".class
puts 5.class
puts [1, 2, 3].class

# # EXERCISES 2-10 
module Walkable 
  def walk 
    puts "Let's go for a walk!"
  end 
end 

class Cat 
  include Walkable 

  attr_accessor :name 

  def initialize(name)
    @name = name 
  end 

  def greet 
    puts "Hello! My name is #{name}!"
  end 
end 

kitty = Cat.new("Sophie")
kitty.name = "Luna"
kitty.greet 
kitty.walk 

# RB 120 OOP Small Exercises - Exercises 11-20  
# EXERCISES 11-17
class Cat
  CAT_COLOR = 'purple'

  attr_accessor :name

  @@total_cats = 0


  def initialize(name)
    @name = name
    @@total_cats += 1
  end

  def greet 
    puts "Hello! My name is #{name} and I'm a #{CAT_COLOR} cat!"
  end 

  def self.total
    puts "#{@@total_cats}"
  end 

  def self.generic_greeting
    puts "Hello! I'm a cat!" 
  end 

  def personal_greeting
    puts "Hello! My name is #{name}!"
  end 

  def to_s
    "I'm #{name}!"
  end 
end

# EXERCISES 18-20
class Person
  attr_writer :secret

  def compare_secret(person2)
    secret == person2.secret
  end 

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)
