

Two instances of self: 
    self, inside of an instance method, references the instance (object) that called the method - the calling object. Therefore, self.weight= is the same as sparky.weight=, in our example.

    self, outside of an instance method, references the class and can be used to define class methods. Therefore if we were to define a name class method, def self.name=(n) is the same as def GoodDog.name=(n).







# Explain what's happening here:
sparky = GoodDog.new("Sparky")

# Here, the string "Sparky" is being passed from the `new` method through to the `initialize` method, 
# and is assigned to the local variable `name`. Within the constructor (i.e., the initialize method), 
# we then set the instance variable @name to name, which results in assigning the string "Sparky" to 
# the @name instance variable.


All objects of the same class have the same behaviors, though they contain different states.


# we can expose information about the state of the object using instance methods

# puts sparky.speak           # => "Sparky says arf!"
# puts fido.speak             # => "Fido says arf!"

class Dog 
	def initialize(name)
		@name = name 
	end 

	def speak
  "#{@name} says arf!"
end

	def fetch
	end

	def eat 
	end 
end 

fido = Dog.new('Fido')
toto = Dog.new('Toto')


# Why do this instead? Why not just reference the @name instance variable, 
# like we did before? Technically, you could just reference the instance variable, 
# but it's generally a good idea to call the getter method instead.

def speak
  "#{name} says arf!"
end


What if we find a bug in this code, or if someone says we need to change the format to something else? It's much easier to just reference a getter method, and make the change in one place.

the to_s method is called automatically on the object when we use it with puts or when used with string interpolation.



