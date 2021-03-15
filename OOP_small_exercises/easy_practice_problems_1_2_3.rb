# LESSON 4 PRACTICE PROBLEMS - EASY 1, EASY 2, EASY 3

# Lesson 4: OOP Practice Problems
# Practice Problems Easy 1 (Questions 1-10)
# Date: 03/14/21

# Question 1
# Which of the following are objects in Ruby? 
# If they are objects, how can you find out what class they belong to? - call .class

# 1. true - TrueClass object 
# 2. 'hello' - String object
# 3. [1, 2, 3, "happy days"] - Array object 
# 4. 142 - Integer object 

# Question 2
# If we have a Car class and a Truck class and we want to be able to go_fast, 
# how can we add the ability for them to go_fast using the module Speed? 
# How can you check if your Car or Truck can now go fast?

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
	include Speed 

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
	include Speed 

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

truck = Truck.new 
car = Car.new 

truck.go_fast 
car.go_fast 

#--------------------------------------------------------------------------------------------------------

# Question 3 
# When we called the go_fast method from an instance of the Car class (as shown below) you might have 
# noticed that the string printed when we go fast includes the name of the type of vehicle we are using. 
# How is this done?

# ANSWER 
# We use self.class in the method and this works the following way:

#     self refers to the object itself, in this case either a Car or Truck object.
#     We ask self to tell us its class with .class. It tells us.
#     We don't need to use to_s here because it is inside of a string and is interpolated which means it will 
#     take care of the to_s for us.

#--------------------------------------------------------------------------------------------------------

# Question 4
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

furious_cat = AngryCat.new 

#--------------------------------------------------------------------------------------------------------

# Question 5
# How could you check if each class has instance variables?
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Answer - make a new instance of each then call the `instance_variables` method on each.
hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")
puts hot_pizza.instance_variables # => [:@name]
puts orange.instance_variables    # => []

#--------------------------------------------------------------------------------------------------------

# Question 6 
# What could we add to the class below to access the instance variable `@volume`?

class Cube
  def initialize(volume)
    @volume = volume
  end
end

# Question 6 Answer
def get_volume
  @volume
end

#--------------------------------------------------------------------------------------------------------

# Question 7 
# What is the default return value of to_s when invoked on an object? Where could you go to find out if you want to be sure?
# By default, the to_s method will return the name of the object's class and an encoding of the object id.

#--------------------------------------------------------------------------------------------------------

# Question 8 
# You can see in the make_one_year_older method we have used self. What does self refer to here?
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
# Answer: self refers to the calling object. 

#--------------------------------------------------------------------------------------------------------

# Question 9
# In the name of the cats_count method we have used self. What does self refer to in this context?

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
# Answer: the Cat class 

# Question 10
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

Bag.new('brown', 'leather')

#--------------------------------------------------------------------------------------------------------

# Lesson 4: OOP Practice Problems
# Practice Problems Easy 2 (Questions 1-10)
# Date: 03/14/21

# Question 1
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of executing the following code:
oracle = Oracle.new
oracle.predict_the_future
# Answer: "You will eat a nice lunch" or "You will take a nap soon" or "You will stay at work late"

#--------------------------------------------------------------------------------------------------------

# Question 2
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of executing the following code:
trip = RoadTrip.new
trip.predict_the_future
# Answer: "You will visit Vegas" or "You will fly to Fiji" or "You will romp in Rome"

#--------------------------------------------------------------------------------------------------------

# Question 3
# How do you find where Ruby will look for a method when that method is called? - think of the method lookup chain 
# How can you find an object's ancestors? - call .ancestors on the object 

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# What is the lookup chain for Orange? -> Orange, Taste, Object, Kernel, BasicObject
# What is the lookup chain for HotSauce? -> HotSauce, Taste, Object, Kernel, BasicObject

#--------------------------------------------------------------------------------------------------------

# Question 4 
# What could you add to this class to simplify it and remove two methods from the class 
# definition while still maintaining the same functionality?
# Answer -> add attr_accessor :type and within `describe_type`, change `@type` to just `type`...
# "This is much cleaner, and it is standard practice to refer to instance variables inside the class without @ 
# if the getter method is available."

class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

#--------------------------------------------------------------------------------------------------------

# Question 5 
# There are a number of variables listed below. What are the different types and how do you know which is which?
excited_dog = "excited dog"       # local variable; we know because there's nothing prefixing the var name 
@excited_dog = "excited dog"      # instance var; we know because there's one @ symbol prefixing the var name 
@@excited_dog = "excited dog"     # class var; we know because there are two @ symbols prefixing the var name 

#--------------------------------------------------------------------------------------------------------

# Question 6 
# Which one of these is a class method (if any) and how do you know? How would you call a class method?

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Answer - `manufacturer` is a class method, and we know bc it starts w/ `self`. `self` is how you'd call one.

#--------------------------------------------------------------------------------------------------------

# Question 7 
# Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Answer - the `@@cats_count` var is a class variable that can be accessed anywhere in the `Cat` class. 
# It gets incremented by one every time a new obj is instantiated from the `Cat` class because of this 
# line in the constructor: `@@cats_count += 1`. 
# To test this theory, we'd just call the `cats_count` class method on `Cat` at any point to see how many
# new objects have been instantiated from `Cat`. 

#--------------------------------------------------------------------------------------------------------

# Question 8 
# What can we add to the Bingo class to allow it to inherit the play method from the Game class?

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game 
  def rules_of_play
    #rules of play
  end
end
#--------------------------------------------------------------------------------------------------------

# Question 9
# What would happen if we added a play method to the Bingo class, keeping in mind that there is already a 
# method of this name in the Game class that the Bingo class inherits from.
# Answer - it'd just overwrite the `play` method in the `Game` class. 

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

#--------------------------------------------------------------------------------------------------------

# Question 10
# What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

# MY ANSWERS...
# -reduces redundancy
# -allows for better organized code 
# -reduces risk of one bug having huge ripple effects and/or one change having huge ripple effects
# -allows for data protection via encapsulation
# -allows us to hide/abstract away complexity

# LS OFFICIAL ANSWERS 
# -creating objects allows programmers to think more abstractly about the code they are writing. 
# -objects are represented by nouns, so they're easier to conceptualize 
# -we can build faster by using pre-written code
# -as software becomes more complex, this complexity can be more easily managed
# -allows us to easily give functionality to different parts of an application without duplication 
# -allows us to only expose functionality to the parts of code that need it, meaning namespace issues 
# are much harder to come across. 

#--------------------------------------------------------------------------------------------------------

# Lesson 4: OOP Practice Problems
# Practice Problems Easy 3 (Questions 1-7)
# Date: 03/14/21

# Question 1
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# What happens in each of the following cases:

# case 1:
hello = Hello.new
hello.hi # => 'Hello'

# case 2:
hello = Hello.new
hello.bye # => NoMethodError

# case 3:
hello = Hello.new
hello.greet # => Error -- expected one argument but got zero

# case 4 
hello = Hello.new
hello.greet("Goodbye") # => 'Goodbye'

# case 5 *** MISSED 
Hello.hi # => NoMethodError
# An undefined method hi is reported for the Hello class. This is because the hi method is defined for 
# instances of the Hello class, rather than on the class itself. Since we are attempting to call hi on 
# the Hello class rather than an instance of the class, Ruby cannot find the method on the class definition.

#--------------------------------------------------------------------------------------------------------

# Question 2 - how would you fix the `Hello.hi` issue?

# For this to work, `line 13` would have to be `def self.hi` instead of just `def hi`. 
# But then, note that we cannot simply call greet in the self.hi method definition because the Greeting class 
# itself only defines greet on its instances, rather than on the Greeting class itself.
# So it'd have to be this...
class Hello
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

#--------------------------------------------------------------------------------------------------------

# Question 3 
# When objects are created they are a separate realization of a particular class.
# Given the class below, how do we create two different instances of this class with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

cat_one = AngryCat.new(4, 'Felix')
cat_two = AngryCat.new(3, 'Jean')

#--------------------------------------------------------------------------------------------------------

# Question 4 
# How could we go about changing the to_s output on this method to look like this: 
# I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).

class Cat
  def initialize(type)
    @type = type
  end
end

# Answer - add in these two things...
attr_reader :type 

def to_s
  "I am a #{type} cat."
end 

#--------------------------------------------------------------------------------------------------------

# Question 5 

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?
tv = Television.new
tv.manufacturer # We'd get an error since `manufacturer` is a class method. 
tv.model # We'd get some info. 

Television.manufacturer # We'd get some info. 
Television.model # We'd get an error since `model` is an instance method. 

#--------------------------------------------------------------------------------------------------------

# Question 6

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# In the make_one_year_older method we have used self. 
# What is another way we could write this method so we don't have to use the self prefix?
# Answer: @age

# Why? - self in this case is referencing the setter method provided by attr_accessor - this means that 
# we could replace `self` with `@`; in this case, `self` and `@` are the same thing and can be used interchangeably.

#--------------------------------------------------------------------------------------------------------

# Question 7
# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end

# LS answer (tricky): The answer here is the return in the information method. Ruby automatically returns 
# the result of the last line of any method, so adding return to this line in the method does not add any value 
# and so therefore should be avoided. We also never use the attr_accessor for brightness and color. 
# Though, these methods do add potential value, as they give us the option to alter brightness and color outside 
# the Light class.

#--------------------------------------------------------------------------------------------------------

