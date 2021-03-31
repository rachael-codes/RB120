# Examples of when to use modules
# Date: 03/31/21 

# Purpose #1 - mix-in common behavior into classes that aren't related to each other in a hierarchical way.
module Runnable 
	def run 
		puts "run"
	end 
end 

class Triathletes
	include Runnable 
end 

class MiddleSchoolers 
	include Runnable 
end 

# Purpose #2 - namespacing 
# In the context of modules, namespacing means grouping related classes together. 
# This makes it easy for us to recognize related classes in our code and helps us avoid namespace collisions.

module Cylon
	class Person
		##
	end 

	class Robot 
		##
	end 
end 

module Human
	class Person
		##
	end 
end 

rachael = Human::Person.new 
number_six = Cylon::Person.new 
p rachael 
p number_six
