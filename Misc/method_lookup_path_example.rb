# Example that shows the method lookup path w/ mixed in modules to an object's class and a mixed in 
# module in its parent class 

# Date: 03/31/21

module Walkable; end 
module Swimmable; end 
module Climbable; end 

class Animal
	include Walkable 

  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
	include Swimmable
  include Climbable

  def initialize(name, color)
    super(name)
    @color = color
  end
end

puts GoodDog.ancestors
# GoodDog
# Climbable
# Swimmable
# Animal
# Walkable
# Object
# Kernel
# BasicObject