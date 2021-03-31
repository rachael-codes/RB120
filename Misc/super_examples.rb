
# Examples using `super` with class inheritance 
# Date: 03/31/21
# --------------------------------------------------------------------------------------------------

# Ruby provides us with the super keyword to call methods earlier in the method lookup path. 
# When you call super from within a method, it searches the method lookup path for a method with 
# the same name, then invokes it.

# Example 1
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class"
  end
end

sparky = GoodDog.new
sparky.speak        # => "Hello! from GoodDog class"

# In the above example, we've created a simple Animal class with a speak instance method. 
# We then created GoodDog which subclasses Animal also with a speak instance method to override the 
# inherited version. However, in the subclass' speak method we use super to invoke the speak method 
# from the superclass, Animal, and then we extend the functionality by appending some text to the 
# return value.
# --------------------------------------------------------------------------------------------------

# Example 2
# Another more common way of using super is with initialize. 
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")        # => #<GoodDog:0x007fb40b1e6718 @color="brown", @name="brown">
# super automatically forwards the arguments that were passed to the method from which super is called...
# which is why @name now points to the string "brown" for the `bruno` object 

# To make this work, you'd have to do this...
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(name, color)
    super(name)
    @color = color
  end
end

bruno = GoodDog.new('Bruno', 'brown') 
# --------------------------------------------------------------------------------------------------

# Example 3 
#  If you call super() exactly as shown -- with parentheses -- it calls the method in the superclass 
# with no arguments at all. If you have a method in your superclass that takes no arguments, 
# this is the safest -- and sometimes the only -- way to call it:

class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super()
    @color = color
  end
end

bear = Bear.new("black")        # => #<Bear:0x007fb40b1e6718 @color="black">

