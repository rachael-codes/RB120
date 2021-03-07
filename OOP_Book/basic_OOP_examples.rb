# Basic OOP fundamentals examples that I have created to practice 
# Date created: 03/07/21 

# EXAMPLE 1 - shows how you'd create a module to include in the `GoodDog` class 
module Speak 
  def speak
    puts "Woof!"
  end
end 

class GoodDog
  attr_reader :name 
  include Speak

  def initialize(name)
    @name = name 
  end 
end 

patrick = GoodDog.new("Patrick")
patrick.speak #=> Woof! 