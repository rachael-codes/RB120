# Practice problems 
# 4/3/21 

# Question 1  
  # What is output and why? 
  # What does this demonstrate about instance variables that differentiates them from local variables?

class Person
  attr_reader :name
  
  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name # => nil b/c we haven't yet invoked the set_name instance method 
# this shows that ivars + local vars are different b/c a local variable is always assigned to 
# a value upon initialization, whereas an instance variable has a `nil` value until an instance 
# method is invoked that initializes the value 

# ------------------------------------------------------------------------------------------------

# Question 2
  # What is output and why? 
  # What does this demonstrate about instance variables? 

module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
p teddy.swim  # `nil`
# b/c even though we mixed in the `Swimmable` module to the `Dog` class,
# we did not call the `enable_swimming` method which would initialize the ivar
# `@can_swim` to true, so right now @can_swim is `nil` 
# This demonstrates that instance variables have the `nil` value until they are initialized

# ------------------------------------------------------------------------------------------------

# Question 3
# What is output and why? 
# What does this demonstrate about constant scope? 
# What does `self` refer to in each of the 3 methods above? 

module Describable
  def describe_shape
    "I am a #{self.class} and have #{self.class::SIDES} sides." # self refers to object 
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES # self refers to class 
  end
  
  def sides
    self.class::SIDES # self refers to object 
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides # 4 b/c `Square` inherits from `Quad` + `Quad` inherits from `Shape` and 
# `Shape` has a class method method that looks for `self::SIDES` in the class 
p Square.new.sides # 4 - again b/c of inheritance chain + the fact that there's a `sides` instance method that 
# you can call on an instance of th class to return the # of sides value to which `SIDES` points 
p Square.new.describe_shape # error b/c constants are lexically scoped, so the program would look for a value
# to which `SIDES` points in the `Describable` module, but it's obv not there. To fix, do `self.class::SIDES`
# This demonstrates that constants are lexically scoped.

# ------------------------------------------------------------------------------------------------

# MISSED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Question 4 
# What is output? Is this what we would expect when using `AnimalClass#+`? 
# If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect 
# the method to return?

class AnimalClass
  attr_accessor :name, :animals
  
  def initialize(name)
    @name = name
    @animals = []
  end
  
  def <<(animal)
    animals << animal                 # change to animal.name
  end
  
  def +(other_class)
    animals + other_class.animals
  end
end

class Animal
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end

mammals = AnimalClass.new('Mammals')
mammals << Animal.new('Human')
mammals << Animal.new('Dog')
mammals << Animal.new('Cat')
# for mammals instance, we want...
# @animals = [Human, Dog, Cat] 
# ...but we get is [Animal<23049823408 @name="Human">, Animal<23409823432 @name="Dog">, Animal<2340982343@name="Cat">]

birds = AnimalClass.new('Birds')
birds << Animal.new('Eagle')
birds << Animal.new('Blue Jay')
birds << Animal.new('Penguin')
# for birds instance, we want...
# @animals = [Eagle, Blue Jay, Penguin] 
# ...but we get is [Animal<23049823408 @name="Eagle">, Animal<23409823432 @name="Blue Jay">, Animal<2340982343@name="Penguin">]


some_animal_classes = mammals + birds

p some_animal_classes # What we get is...
# [#<Animal:0x00007fb43a0fa140 @name="Human">, #<Animal:0x00007fb43a0fa0a0 @name="Dog">, 
  #<Animal:0x00007fb43a0fa000 @name="Cat">, #<Animal:0x00007fb43a0f9ce0 @name="Eagle">, 
  #<Animal:0x00007fb43a0f9c68 @name="Blue Jay">, #<Animal:0x00007fb43a0f9bc8 @name="Penguin">]

# What we want is: # [Human, Dog, Cat, Eagle, Blue Jay, Penguin]

# To fix this, within the `<<` instance method, add `animal.name` instead of just `animal`. 

# ------------------------------------------------------------------------------------------------

# Question 5
  # We expect the code above to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` 
  # Why does our `change_info` method not work as expected?

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    name = n
    height = h
    weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end


sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs') 
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info 
# => Spartacus weighs 10 lbs and is 12 inches tall.

# Within `change_info`, it looks like we're referring to local vars `name`, `height`, and `weight` rather
# than calling our setter methods for each. Use `self` to fix.

# ------------------------------------------------------------------------------------------------

# Question 6 
  # In the code above, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? 
  # How could we adjust this code to output `'BOB'`? 

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def change_name
    name = name.upcase # - Ruby thinks we're referring to a local var rather than a setter.
  end 
end

bob = Person.new('Bob')
p bob.name # => Bob 
bob.change_name # 
p bob.name

# Ruby thinks we're referring to a local var rather than a setter.
# Fix with `self.name` within `change_name` instance method. 

# ------------------------------------------------------------------------------------------------

# Question 7 
  # What does the code output and why? 
  # What does this demonstrate about class variables, 
  # and why we should avoid using class variables when working with inheritance?

class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels # 4                             

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels # 2                           
p Vehicle.wheels # 2                            

class Car < Vehicle; end

p Vehicle.wheels # 2 
p Motorcycle.wheels  # 2                          
p Car.wheels  # 2 

# This demonstrates that class variables are available to classes throughout the inheritance 
# chain, so we should avoid working with them when using inheritance b/c it's easy to reassign
# a class variable like we did when we called `Motorcycle.wheels` and then have this affect other 
# classes like it did to `Vehicle` and `Car`. 

# ------------------------------------------------------------------------------------------------

# Question 8 
  # What is the output and why? 
  # What does this demo about `super`? 


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

bruno = GoodDog.new("brown")       
p bruno

# Animal <numbers @name = brown @color = brown> 
# This demos that when you call super without parentheses, if the # of parameters in the subclass's method matches 
# the # of params in the superclass' method of the same name, the arguments automatically get passed up the chain 
# and used. To avoid this, you should pass in a name to the `GoodDog` constructor like `"Bruno"` + call `super(name)`. 

# ------------------------------------------------------------------------------------------------

# Question 9 
  # What is output and why? What does this demonstrate about `super`? 

class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super
    @color = color
  end
end

bear = Bear.new("black") # argument error 
# This demos that you can call super without parentheses if the superclass method that you are calling 
# takes no arguments AND the subclass method of the same name takes no arguments, but if your subclass takes 
# an argument, you must use `super()` to tell super you aren't passing in any of your subclass's arguments 
# to `super`. 

# ------------------------------------------------------------------------------------------------

# MISSED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Question 10 
# What is the method lookup path used when invoking `#walk` on `good_dog`?

module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

module Danceable
  def dance
    "I'm dancing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

module GoodAnimals
  include Climbable

  class GoodDog < Animal
    include Swimmable
    include Danceable
  end
  
  class GoodCat < Animal; end
end

good_dog = GoodAnimals::GoodDog.new
good_dog.walk

p GoodAnimals::GoodDog.ancestors 

# WRONG = [GoodDog, Danceable, Swimmable, GoodAnimals, Climable, Animal, Walkable]
# RIGHT = [GoodAnimals::GoodDog, Danceable, Swimmable, Animal, Walkable]

# ------------------------------------------------------------------------------------------------

# Question 11 
  # What is output and why? How does this code demonstrate polymorphism? 

class Animal
  def eat
    puts "I eat."
  end
end

class Fish < Animal
  def eat
    puts "I eat plankton."
  end
end

class Dog < Animal
  def eat
    puts "I eat kibble."
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Dog.new]

array_of_animals.each do |animal|
  feed_animal(animal)
end

# I eat. 
# I eat plankton.
# I eat kibble. 

# This demos polymorphism via inheritance.
# Polymorphism is the fact that diff objects instantiated from diff classes can respond to 
# the same method calls, so here we can see that an instance of `Animal`, an instance of `Fish`,
# and an instance of `Dog`, can all respond to the `feed_animal` method. 

# ------------------------------------------------------------------------------------------------

# Question 12 
# We raise an error in the code above. Why? 
# What do `kitty` and `bud` represent in relation to our `Person` object?  

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Pet
  def jump
    puts "I'm jumping!"
  end
end

class Cat < Pet; end

class Bulldog < Pet; end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud                     

bob.pets.jump # jump can't be called on an array of pets; you'd have to call `jump` on each one 
# You'd need to do this instead: bob.pets.each { |pet| pet.jump }`

# `kitty` and `bud` are collaborators of `bob`. 

# ------------------------------------------------------------------------------------------------

# MISSED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Question 13  
# What is output and why?

class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name  
# just "bark! bark!  bark! bark!" b/c we didn't call `super` in the `Dog` class constructor, so it 
# didn't assign the instance variable `@name` to `"Teddy"`, so `@name` would just be `nil` when `dog_name` is invoked. 

# ------------------------------------------------------------------------------------------------

# Question 14 
  # In the code below, we want to compare whether the two objects have the same name. 
  # `Line 11` currently returns `false`. How could we return `true` on `line 11`? 

  # Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` 
  # and `alex`'s `@name` instance variables are the same object? How could we prove our case?

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

al = Person.new('Alexander')
alex = Person.new('Alexander')
p al == alex # => true

# Answer: define a custom `==` method within the `Person` class:
# def ==(other)
#   @name == other.name 
# end

# No, this does not mean the string objects are the same. We could check by outputting object id of each.

# ------------------------------------------------------------------------------------------------

# Question 15 
  # What is output on the final three lines and why?

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name.upcase!}."
  end
end

bob = Person.new('Bob')
puts bob.name # Bob 
puts bob # My name is BOB.
puts bob.name # BOB 


# Why last one -- the mutating `upcase!` method was called when `puts bob` was invoked b/c `puts` 
# automatically calls the `to_s` method, and within the `to_s` method definition from the `Person` class, we can see 
# that `upcase!` is included. This mutated the string object. 

# ------------------------------------------------------------------------------------------------

# Question 16 
# Why is it safer to use `self` than refer to an instance var directly within an instance method within the class?
# Give an example.

# It's important because by referring directly to the ivar, you may not get the actual output you want when 
# calling your method. For example here, if you called the `speak` method, you'd just get `John is speaking`  
# when really you want `King John is speaking`. 

class Person 
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking."
  end
end

class King < Person
  def name
    "King " + super
  end
end

king_john = King.new("John")
p king_john.name  # King John
p king_john.speak # John is speaking 

# So you should fix it like this...

class Person 
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{self.name} is speaking."
  end
end

class King < Person
  def name
    "King " + super
  end
end

king_john = King.new("John")
p king_john.name  # King John
p king_john.speak # King John is speaking 


# ------------------------------------------------------------------------------------------------

# Question 17 
# Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.

# This would make sense when you want to make sure when something is accessed, it always comes out in a particular 
# format. Here's an example below that would just allow you to always output someone's name formatted nicely 
# with proper capitalization. Another example would be if you only wanted to show the last 4 digits of a SSN. 

class Person 
	def initialize(name)
		@name = name 
	end 

	def name 
		@name.capitalize
	end 
end 

rachael = Person.new('rachael')
mike = Person.new('mikE')
puts mike.name # => Mike 
puts rachael.name # => Rachael 

# ------------------------------------------------------------------------------------------------

# Question 18 
  # What can executing `Triangle.sides` return? What can executing `Triangle.new.sides` return? 
  # What does this demonstrate about class variables?

class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end

p Triangle.sides # nil 
p Triangle.new.sides # 3 

# This demonstrates that although class variables are accessible from both class and instance methods,
# if a class variables isn't assigned to a value until an instance of the class is instantiated, then 
# the class variable will return `nil`. This could change if we altered the order as follows in order to 
# first instantiate an object and call the `sides` instance method and THEN call the `sides` class method: 

p Triangle.new.sides # 3 
p Triangle.sides # 3 

# ------------------------------------------------------------------------------------------------

# Question 19 
# What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every 
# instance variable in our class? Give an example.

# The `attr_accessor` method is a getter and a setter combined into one. However, we wouldn't want to use this for 
# every instance variable in our class bc there are some values we don't want to be accessed from outside of the class
# and some values we don't want to be initialized and/or reasssigned from outside of the class. 

# Here's an example that shows some data that we WOULD want to be made accessible by a getter/setter from 
# outside the class... 

class Person 
	attr_accessor :name 

	def initialize(name)
		@name = name 
	end 
end 

rachael = Person.new('rachael')
puts rachael.name 
rachael.name = 'Rachael'
puts rachael.name 

# My name isn't sensitive data, so I don't care if one can see it or change it so it's capitalized correctly. 

# Here's an example that shows what I WOULDN'T want to be accessible from outside of the class or changed. 
class Person 
	attr_accessor :name 

	def initialize(name, ssn)
		@name = name 
		@ssn = ssn
	end 
end 

rachael = Person.new('rachael', 59408888)
puts rachael.name 
rachael.name = 'Rachael'
puts rachael.name 
puts rachael.ssn # error 
rachael.ssn = 234098234 # error

# ------------------------------------------------------------------------------------------------

# Question 20 
  # What is the difference between states and behaviors?

# States describe what an object is made of, and behaviors describe what an object is able to do. 
# Instance variables track states, and instance methods define behaviors that an object is able to perform.
# Objects do not share state amongst other objects instantiated from the same class, but they do share behaviors.

class Person 
	def initialize(name)
		@name = name                # shows state 
	end 

	def run
		puts "I'm running"          # shows behavior 
	end 
end 

# ------------------------------------------------------------------------------------------------

# Question 21 
  # What is the difference between instance methods and class methods? 

# Instance methods can be called by instances of a class (aka objects), whereas class methods can 
# be called by the class itself. Instance methods are for functionality that pertains to individual 
# objects, whereas class methods are for functionality that pertains to the entire class. Class methods
# are prepended by `.self`. 

class Runner
	@@runners = 0 

	def initialize(name)
		@name = name 
		@@runners += 1
	end 

	def run 
		puts "running"
	end 

	def self.display_total_runners
		puts @@runners
	end 
end 

rachael = Runner.new('Rachael')
mike = Runner.new('Mike')
rachael.run # this works 
# Runner.run # This would NOT work. 
Runner.display_total_runners # 2 
# rachael.display_total_runners # Thsi would NOT work. 

# ------------------------------------------------------------------------------------------------

# Question 22 

# What are collaborator objects, and what is the purpose of using them in OOP? 
# Give an example of how we would work with one.

# Collaborator objects are objects that are stored as state within another object. 
# We can tell that something is a collaborator because an instance variable has been assigned to it. 
# The purpose of them is to be able to access instance methods of one object while being inside of another 
# object from another class (see final line of example). 

class Person 
	attr_reader :mom 

	def initialize(name)
		@name = name
		@mom = Mom.new('Cheryl')
	end 
end 

class Mom
	attr_reader :name  

	def initialize(name)
		@name = name
	end 
end 

rachael = Person.new('Rachael')
puts rachael.mom.name # => Cheryl 

# ------------------------------------------------------------------------------------------------

# Question 23 
  # How and why would we implement a fake operator in a custom class? Give an example.

# Ruby comes with many fake operator methods that our custom classes inherit from Ruby's  
# `BasicObject` class, but oftentimes what we actually want to do is not the same as the functionality 
# that's provided to us. For example, the `==` method would check if two objects are the same object,
# but that's usually not what we actually want to check for, so we'd override this method within a custom
# class by defining our own, for example...

class Person
  attr_reader :age 

  def initialize(name, age)
    @name = name
    @age = age 
  end 

  def ==(other_person)
    @age == other_person.age 
  end 
end 

rachael = Person.new('Rachael', 30)
mike = Person.new('Mike', 30) 

puts rachael == mike # true (but if we hadn't defined the `==` method in `Person`, we would've gotten `false`)

# ------------------------------------------------------------------------------------------------

# Question 24 
# What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? 
# Provide examples.

# `self` can be used either to refer to the class itself or the object itself. Here's a class example:
class Person
	def self.display_class 
		puts self 
	end 
end 
# This shows that we used `self.` to prepend class methods, and within a class method, self refers to the class.

# Here's an example within an instance method/where `self` refers to the object itself:
class Person 
	def initialize(name)
		@name = name
	end 

	def say_hi
		puts "Hi from #{self}!"
	end 

	def to_s 
		@name 
	end 
end 

rachael = Person.new('Rachael')
rachael.say_hi # Hi from Rachael 

# And here's an example where we're using `self` within an instance method to clarify that we want to call 
# a setter method on our object rather than initialize a local variable 

class Person 
  attr_accessor :name

  def initialize(name)
    @name = name
  end 

  def change_name=(new_name)
    self.name = new_name 
  end 
end 

rachael = Person.new('Rachael')
puts rachael.name 
rachael.change_name = 'Rachel'
puts rachael.name

# ------------------------------------------------------------------------------------------------

# Question 25 
  # What does the code below demonstrate about how instance variables are scoped?

class Person
  def initialize(n)
    @name = n
  end
  
  def get_name
    @name
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect # => #<Person:0x000055e79be5dea8 @name="bob">
puts joe.inspect # => #<Person:0x000055e79be5de58 @name="joe">

p bob.get_name # => "bob"
# This demonstrates that instance variables are scoped at the object level. 

# ------------------------------------------------------------------------------------------------

# Question 26 
  # How do class inheritance and mixing in modules affect instance variable scope? Give an example.

# Instance variables are scoped at the object level, so they can be accessed by all the methods of its mixins and 
# superclasses/subclasses that are within the method lookup path of the class from which the obj was instantiated.
# Here's an example with modules...

module Runnable 
	def run
		"#{@name} is running."
	end 
end 

class Person 
	include Runnable 

	def initialize(name)
		@name = name 
	end 
end 

rachael = Person.new('Rachael')
puts rachael.run # => "Rachael is running."
# As we can see, ivars are not lexically scoped, or else that wouldn't have worked. 

# Here's an example with class inheritance...
class Person
	def eat 
		"#{@name} is eating."
	end 
end 

class Baby < Person
	def initialize(name)
		@name = name 
	end 
end 

timmy = Baby.new('Timmy')
puts timmy.eat # => "Timmy is eating."
# As we can see, ivars are not lexically scoped, or else that wouldn't have worked. 

# ------------------------------------------------------------------------------------------------

# UNSURE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Question 27 
# How does encapsulation relate to the public interface of a class?
# Encapsulation involves hiding parts of your code and making it unavailable from the rest of the code base in 
# order to limit dependencies, so we only expose info from our classes and make it publicly available 
# when we NEED to (aka when there's a good reason to) through defining public instance methods within in the class. 

# ------------------------------------------------------------------------------------------------

# Question 28 

class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky

# What is output and why? How could we output a message of our choice instead?

# The output is the name of the class `GoodDog` plus object id plus @name = "Sparky" and @age = 28. 
# We could change this by overriding the `to_s` method. 

# How is this different than this below? Why? 

class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky

# Here, we just get the name of the class plus the object id. This is because `p` automatically calls `inspect`. 

# ------------------------------------------------------------------------------------------------

# Question 29 
# When does accidental method overriding occur, and why? Give an example.

# Accidental overrides occurs when you accidentally give a subclass a name that is the same name as one in 
# a module or superclass, but your intention was NOT to override the module or superclass's method. 
# Example...

class Creature 
  def eat
    puts "I'm eating."
  end 
end 

class Person < Creature; end 

class Baby < Person; end 

class OneYearOld < Baby
  def eat
  	puts "Yum"
  end 
end 

timmy = OneYearOld.new 
sally = Person.new 
jimmy = Baby.new 
people = [timmy, sally, jimmy]

people.each { |person| person.eat }  
# Let's say what we wanted is "I'm eating" outputted 3 times, but what we get is "Yum" then "I'm eating" twice.

# This is contrived, but basically, let's say after subclassing from a custom class that subclasses from another 
# custom class that subclasses from another custom class (which is the case for `OneYearOld`, we forgot we had 
# defined an `eat` method in a parent class up the chain, and we made another `eat` method of the same name by accident. 
# This would be accidental method overriding. To avoid it, we should use unique names. In this case, we could change 
# the `eat` method in the `OneYearOld` class to `says_yum`. 

# ------------------------------------------------------------------------------------------------

# Question 31 
  # Describe the distinction between modules and classes.

# Objects can't be instantiated from modules. 

# ------------------------------------------------------------------------------------------------

# Question 34 
# What is returned/output in the code? 
# Why did it make more sense to use a module as a mixin vs. defining a parent class and using class inheritance?

module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

mike = Person.new("Mike")
p mike.walk # Mike strolls forward. 

kitty = Cat.new("Kitty")
p kitty.walk # Kitty saunters forward. 

# It made more sense to use a module because a cat isn't a type of person, nor is a person a type of cat. 
# They're two separate things that can both walk, so it makes more sense to host a `walk` method in a module 
# and just mix that into each class.

# ------------------------------------------------------------------------------------------------

# Question 35 
  # What is Object Oriented Programming, and why was it created? 
  # What are the benefits of OOP, and examples of problems it solves?

# It's a programming paradigm, and it was created as a result of software systems becoming more complex. 
# Some major benefits to OOP are that you can abstract away complexity, reduce redundancy + increase reuseability,
# increase flexibilty thanks to polymorphism, and increase security and therefore reduce the possibility of one 
# small change in code having giant ripple effects and changing your code in ways you didn't intend (which also
# leads to easier debugging/trouble-shooting). 

# For example, in procedural programming, if one method is dependent on another is dependent on another, etc., and
# I change one thing, this could break the entire program. But in OOP, if I change one method, and that method 
# is only available to instances of that one class from which it was defined, I could just debug within this class/
# this section of the code rather than having to search in a bunch of different places to debug. 

# ------------------------------------------------------------------------------------------------

# Question 36 
		# What is the relationship between classes and objects in Ruby?

# An object is an instance of a class (aka objects are instantiated from classes). 
# The class is the blueprint that defines what an object is made of and what it should be able to do (its 
# instance methods). 

# Objects keep track of state (aka what the object is made of), and classes contain behaviors that are 
# available to the objects instantiated from that class (modules and parent classes also contain behaviors
# that can be made available to the objects via mixins and class inheritance, respectively). 

# ------------------------------------------------------------------------------------------------

# Question 37 
  # When should we use class inheritance vs. interface inheritance.

# We use class inheritance when there's an "is a" relationship. For example, a corgi is a dog, so a `Corgi` 
# class could inherit from a `Dog` superclass via class inheritance. 

# We use interface interitance when there's a "has a" relationship. For example, a corgi has the ability to 
# run, as does as a triathlete and a middleschooler, but there's no "is a" relationship between these three 
# groups, so it'd make sense to create three separate classes: `Corgi`, `MiddleSchooler`, and `Triathlete` as
# well as a `Runnable` module that contains a `run` method and to just mix in `Runnable` to each of the 3 classes.

# ------------------------------------------------------------------------------------------------

# Question 38 
  # If we use `==` to compare the individual `Cat` objects in the code above, will the return value be `true`? 
  # Why or why not? 
  # What does this demonstrate about classes and objects in Ruby, as well as the `==` method?

class Cat
end

whiskers = Cat.new
ginger = Cat.new
paws = Cat.new
puts whiskers == ginger # false 
puts paws == ginger # false 

# No because these are three different objects, and `==` compares whether objects are the same object. 
# This demonstrates that even though an object is instantiated from a class, this does not mean it's the 
# same object as a different object instantiated from that same class. 

# This also demonstrates that Ruby has built-in methods like `==` in its `BasicObject` class, and our custom
# classes are able to access such methods via the method lookup chain. Thus, here, we'd get `false` rather than 
# an error. This also means we should override certain methods in our custom classes if we want different 
# functionality from what is provided by methods in Ruby's `BasicObject` class. 

# ------------------------------------------------------------------------------------------------

# Question 39 
  # Describe the inheritance structure in the below, and identify all the superclasses.

class Thing
end

class AnotherThing < Thing
end

class SomethingElse < AnotherThing
end

# The `SomethingElse` class inherits from `AnotherThing` which inherits from `Thing` which inherits from
# `Object` which inherits from `Kernel` which inherits from `BasicObject`. 

# ------------------------------------------------------------------------------------------------

# Question 40 

# What is the method lookup path that Ruby will use as a result of the call to the `fly` method? 
# Explain how we can verify this.

module Flight
  def fly; end
end

module Aquatic
  def swim; end
end

module Migratory
  def migrate; end
end

class Animal
end

class Bird < Animal
end

class Penguin < Bird
  include Aquatic
  include Migratory
end

pingu = Penguin.new
pingu.fly

# [Penguin, Migratory, Aquatic, Bird, Animal, Object, Kernel, BasicObject]
# We can verify this with the `ancestors` class method. 

# ------------------------------------------------------------------------------------------------

# Question 41 
  # What does this code output and why?

class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts sound
  end

  def sound
    "#{@name} says "
  end
end

class Cow < Animal
  def sound
    super + "moooooooooooo!"
  end
end

daisy = Cow.new("Daisy")
daisy.speak # Daisy says mooooooooo! 
# This works because we have a constructor that sets the instance variable @name to the argument that 
# gets passed in upon instantiation of a new instance of `Cow` (because `Cow` has access to its parent 
# class's constructor), and the `Cow` class's `sound` instance method appropriate calls `super` to get the 
# value to which the instance variable points and `"says "` from the `Animal` class's `sound` instance method 
# plus `moooooooooooooo!`. Finally, again, because all instances of the `Cow` class also have access to all the 
# methods from the `Animal` class--including the `speak` instance method--one can call `speak` on `daisy` w/o issue. 

# ------------------------------------------------------------------------------------------------

# Question 42 
  # Do `molly` and `max` have the same states and behaviors in the code above? 
  # Explain why or why not, and what this demonstrates about objects in Ruby.

class Cat
  def initialize(name, coloring)
    @name = name
    @coloring = coloring
  end

  def purr; end

  def jump; end

  def sleep; end

  def eat; end
end

max = Cat.new("Max", "tabby")
molly = Cat.new("Molly", "gray")

# `molly` and `max` have different states but the same behaviors.
# This demonstrates that objects encapsulate state and don't share state amongst each other, but 
# they do share behaviors because objects instantiated from a class share the behaviors that are 
# defined by the class itself or accessible via inheritance (aka the class's and superclass's instance methods 
# and any instance methods included via mixins) with all of the other objects instantiated from the same class.

# ------------------------------------------------------------------------------------------------

# Question 43 
  # In the above code snippet, we want to return `”A”`. 
  # What is actually returned and why? How could we adjust the code to produce the desired result?

class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end
  
  def change_grade(new_grade)
    grade = new_grade           #change to self.grade = new_grade 
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
p priya.grade # nil 
# `nil` is returned because we haven't actually used the setter method to initialize Priya's grade to A. 
# Instead, we just initialized a local variable `grade` to A within the `change_grade` instance method. 
# For this to work, we'd need to change `grade` to to `self.grade` to actually call the setter, or use
# the instance variable `@grade` directly (`@grade = new_grade`). 

# ------------------------------------------------------------------------------------------------

# Question 44 
  # What does each `self` refer to in the above code snippet?

class MeMyselfAndI
  self # refers to the class itself b/c it's not within an instance method 

  def self.me # refers to class itself 
    self # refers to class itself b/c it's within a class method + class methods can only be called 
         # by classes
  end

  def myself
    self # refers to object b/c it's within an instance method and instance methods can only be called
         # by objects 
  end
end

i = MeMyselfAndI.new
puts i.myself 

# ------------------------------------------------------------------------------------------------

# Question 45 
  # Running the following code will not produce the output shown on the last line. Why not? 
  # What would we need to change, and what does this demonstrate about instance variables?

class Student
  attr_accessor :grade

  def initialize(name, grade=nil)
    @name = name
  end 
end

ade = Student.new('Adewale')
p ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">

# Instead, it would be <Student:0x00000002a88ef8 @name="Adewale"> because when instance variables haven't 
# yet been initialized, `to_s` doesn't output them since we could say they don't yet really exist. 

# ------------------------------------------------------------------------------------------------

# Question 46 
  # What is output and returned, and why? 
  # What would we need to change so that the last line outputs `”Sir Gallant is speaking.”`? 

class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking."
  end
end

class Knight < Character
  def name
    "Sir " + super
  end
end

sir_gallant = Knight.new("Gallant")
p sir_gallant.name  # Sir Gallant 
p sir_gallant.speak # Gallant is speaking 

# "Gallant is speaking" is outputted beecause within the `speak` instance method of the `Character` class,
# we're rerferring the `@name` ivar directly rather than calling the `name` getter method defined in the `Knight` 
# class. We could fix this by changing `@name` to `name` or `self.name` within the `speak` instance method. 

# ------------------------------------------------------------------------------------------------

# Question 47 
  # What is output and why? 

class FarmAnimal
  def speak
    "#{self} says "
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!"
  end
end

class Lamb < Sheep
  def speak
    super + "baaaaaaa!"
  end
end

class Cow < FarmAnimal
  def speak
    super + "mooooooo!"
  end
end

p Sheep.new.speak # <Sheep 004982309483> says baa!               #b/c `self` refers to object itself + baa! is added
p Lamb.new.speak # <Lamb 0049823093383> says baa!baaaaaaaa!      #b/c it inherits "self + says baa!" from FarmAnimal from Sheep then baaaaa!
p Cow.new.speak # <Cow 0049823093383> says moooooooo!            #b/c `self` refers to object itself + mooooooo is added

# ------------------------------------------------------------------------------------------------

# Question 48 
  # What are the collaborator objects in the above code snippet, and what makes them collaborator objects?

class Person
  def initialize(name)
    @name = name
  end
end

class Cat
  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end

sara = Person.new("Sara")
fluffy = Cat.new("Fluffy", sara)

# The string object "Sara" is a collaborator of `sara`, and the string object "Fluffy" as well as the 
# `Person` object `sara` are collaborators of the `Cat` object `fluffy`. 
# What makes them collaborators is that they are objects from one class to which instance variables of 
# another class get assigned. 

# ------------------------------------------------------------------------------------------------

# Question 49 
  # What methods does this `case` statement use to determine which `when` clause is executed?

number = 42

case number
when 1          then 'first'
when 10, 20, 30 then 'second'
when 40..49     then 'third'
end

# It uses`===`, which is a built-in Ruby method to define equality in the context of a case statement. 

# ------------------------------------------------------------------------------------------------

# Question 50 
  # What are the scopes of each of the different variables in the code?
class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  @@total_people = 0

  def initialize(name)
    @name = name
  end

  def age
    @age
  end
end

# `TITLES` is a constant variable, so it has lexical scope.
# '@@total_people' is a class variable, so it's scoped at the class level, and it's available 
# throughout the class and any subclasses that inherit from the `Person` class.
# `@age` and `@name` are scoped at the object level, meaning they're not shared between objects. 

# ------------------------------------------------------------------------------------------------

# Question 51

# The following is a short description of an application that lets a customer place an order for a meal:

# - A meal always has three meal items: a burger, a side, and drink.
# - For each meal item, the customer must choose an option.
# - The application must compute the total cost of the order.

# 1. Identify the nouns and verbs we need in order to model our classes and methods.
# 2. Create an outline in code (a spike) of the structure of this application.
# 3. Place methods in the appropriate classes to correspond with various verbs.

# NOUNS 
# meal - class 
# -burger options 
# -side options 
# -drink options 

# -create customer selection 

# customer - class 
# -choices 
# -choose items verb 


# order - class 
# -cost 
# -meal items (collab w/ meal class)

# total the order verb 

class Customer 
  attr_reader :name 

  def initialize(name)
    @name = name 
  end 

  def pay(amount) 
    puts "#{name} paid $#{amount}."
  end 

  def to_s
    @name 
  end 
end 

class Order 
  PRICES = { 'hamburger' => 3.05, 'cheeseburger' => 3.55, 'fries' => 2.25, 
             'salad' => 2.55, 'Coke' => 1.05, 'Sprite' => 1.05 }

  attr_accessor :burger, :side, :drink 
  attr_reader :customer, :order_price

  def initialize(customer)
    @customer = customer 
    @burger = nil
    @side = nil 
    @drink = nil
  end 

  def self.display_meal_options 
    puts "Welcome to Fast Foodery!"
    puts "Your options are:"
    puts "  Burger choices: hamburger ($#{PRICES['hamburger']}) or cheeseburger ($#{PRICES['cheeseburger']})"
    puts "  Side choices: fries ($#{PRICES['fries']}) or salad ($#{PRICES['salad']})" 
    puts "  Drink choices: Coke or Sprite ($#{PRICES['Coke']} each)"
    puts
  end 

  def choose_burger
    choice = nil 
    loop do 
      puts "What kind of burger do you want (hamburger of cheeseburger)?"
      choice = gets.chomp 
      break if choice.downcase == 'hamburger' || choice.downcase == 'cheeseburger'
      puts "Invalid. Choose again."
    end 
    self.burger = choice
  end 

  def choose_side
    choice = nil 
    loop do 
      puts "What kind of side do you want (fries or salad)?"
      choice = gets.chomp 
      break if choice.downcase == 'fries' || choice.downcase == 'salad'
      puts "Invalid. Choose again."
    end 
    self.side = choice 
  end 

  def choose_drink
    choice = nil 
    loop do 
      puts "What kind of drink do you want (Coke or Sprite)?"
      choice = gets.chomp 
      break if choice.capitalize == 'Coke' || choice.capitalize == 'Sprite'
    end 
    self.drink = choice
  end 

  def calculate_price 
    items = [burger, side, drink]
    total = 0
    items.each { |item| total += PRICES[item] } 
    total.round(2) 
  end 

  def display_total
    puts "Your total: $#{calculate_price}"
  end 
end 

# Helpers 
def choose_options(order)
  order.choose_burger 
  order.choose_side
  order.choose_drink
end 

def pay(order)
  price = order.calculate_price
  order.display_total
  order.customer.pay(price) 
end 

# Main Action
puts "What is your name?"
name = gets.chomp 
order = Order.new(Customer.new(name))
Order.display_meal_options 
choose_options(order) 
pay(order)

# ------------------------------------------------------------------------------------------------

# Question 52
  # In the `make_one_year_older` method we have used `self`. 
  # What is another way we could write this method so we don't have to use the `self` prefix?
  # Which use case would be preferred according to best practices in Ruby, and why?

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1													# @age 
  end
end

# Both work. Since we have a setter method for `@age`, it makes sense to just use it here (and thus
# use `self.age`. This may be preferred, but using `@age += 1` would also be valid. 


# ------------------------------------------------------------------------------------------------

# Question 53 
  # What is output and why? What does this demonstrate about how methods need to be defined in modules, and why?

module Drivable
  def self.drive
  	puts "I'm driving"
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive # error - you defined a class method within a module (wrong) + are trying to call a class method 
# on an object (wrong)
Car.drive # also still an error b/c the `self` would refer to the module, which wouldn't make sense 
# Fix by removing the `self` prefix from the `drive` method to make it an instance method.

# ------------------------------------------------------------------------------------------------

# Question 54 
# What module/method could we add to the above code snippet to output the desired output on the last 2 lines, and why?

class House
  # Answer part 1 = include Comparable 

  attr_reader :price

  def initialize(price)
    @price = price
  end

  # Answer part = include this method 
  # def <=>(other_home)
  #   price <=> other_home.price
  # end 
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2 # => Home 1 is cheaper
puts "Home 2 is more expensive" if home2 > home1 # => Home 2 is more expensive






