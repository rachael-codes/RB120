# COLLABORATORS 
# Date: 03/31/21 

# OVERVIEW
# A collaborator object is an object that is stored as state within another object. 
# Collaborator objects can be of any type: custom class object, Array, Hash, String, Integer, etc. 
# Within a class definition, anything to which an instance variable gets assigned is technically a 
# collaborator.

# PURPOSE
# The purpose of using them in OOP is so that we can access instance methods of one object from one 
# class while being inside another object of another class

# EXAMPLE 1 
class Person 
	attr_reader :name 

	def initialize(name)
		@name = name 
	end 
end 

me = Person.new('Rachael')
# The string object `Rachael` is a collaborator of the `me` object. 

# EXAMPLE 2
class Person 
	attr_reader :dog 

	def initialize(name)
		@name = name 
		@dog = Dog.new('Toto')
	end 
end 

class Dog 
	attr_reader :name 

	def initialize(name)
		@name = name 
	end 

	def bark 
		puts "Bark!"
	end 
end 

me = Person.new('Rachael')
me.dog.bark # => Bark!
puts me.dog.name # => Toto 

# EXAMPLE 3 
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

	def say_hi 
		puts "Hi from #{name}."
	end 
end 

me = Person.new('Rachael')
me.mom.say_hi # => "Hi from Cheryl"
puts me.mom.name # => Cheryl


