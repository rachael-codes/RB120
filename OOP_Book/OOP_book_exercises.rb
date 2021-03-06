# OOP Book Exercises 
# Date: 03/06/21 

# PART 1 EXERCISE 1: How do we create an object in Ruby? Give an example of the creation of an object.

# We create an object in Ruby by first defining a class then creating an instance of the class
# and storing it in a variable. The entire process of creating a new object or instance from a class
# is called instantiation. 

module HairFlip 
	def hair_flip(hair_type)
		puts "#{hair_type} has been flipped!"
	end 
end 

class People
	include HairFlip 
end 
# Above, I've defined the class `People` and mixed in the module `HairFlip`. 

rachael = People.new
# Above, I've instantiated an object called `rachael` from the class `People`. 

# PART 1 EXERCISE 2: What is a module? What is its purpose? How do we use them with our classes? 
# Create a module for the class you created in exercise 1 and include it properly.

# A module is a collection of behaviors that is usable in other classes. Its purpose is for the 
# objects instantiated from a class to be able to access methods that are defined within modules.
# We can use modules with our classes by "mixing in" the modules via the `include` method invocation
# followed by the module name. 

# Official LS answer: "A module allows us to group reusable code into one place or "extend functionality to a class."
# We use modules in our classes by using the include method invocation, followed by the module name.
# Modules are also used as a namespace."

rachael.hair_flip("Long hair") # "Long hair has been flipped!"

# Practice w/ #ancestors method 
puts People.ancestors
# People
# HairFlip
# Object
# Kernel
# BasicObject


# PART 2 EXERCISES 1, 2 and 3 
# Create a class called MyCar. When you initialize a new instance or object of the class, 
# allow the user to define some instance variables that tell us the year, color, and model of the car. 
# Create an instance variable that is set to 0 during instantiation of the object to track the current 
# speed of the car as well. 
# Create instance methods that allow the car to speed up, brake, and shut the car off.
# Allow the year to be displayed but not changed with attr method.
# Create a method that changes the color. 

class MyCar 
	attr_accessor :color
	attr_reader :year 

	def initialize(year, color, model)
		@year = year  
		@color = color 
		@model = model
		@speed = 0 
	end 

	def info 
		puts "This #{@color} #{@model} was made in #{@year}." 
	end 

	def speed_up(number)
		@speed += number 
		puts "You pushed the gas pedal. The car has increased its speed by #{number} mph."
	end 

	def brake(number)
		@speed -= number 
		puts "You hit the brakes. The car has decreased its speed by #{number} mph."
	end 

	def shut_off
		@speed = 0
		puts "You have turned the ignition off."
	end 

	def current_speed
		puts "Your current speed is #{@speed} mph." 
	end 

	def spray_paint(color)
		self.color = color 
		puts "You have painted your car #{color}!"
	end 
end 

# EXERCISE 1 
beetle = MyCar.new(2000, 'red', 'VW Beetle')
# beetle.info 
# beetle.current_speed
# beetle.speed_up(40)
# beetle.current_speed
# beetle.brake(30)
# beetle.current_speed
# beetle.shut_off
# beetle.current_speed

# EXERCISE 2 + 3 
# puts beetle.year # => 2000 
# beetle.spray_paint('blue') # => You have painted your car blue!
