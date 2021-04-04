# Examples to help explain constants and lexical scope 
# Date: 03/31/21 
# Source 1: https://launchschool.com/posts/49bb94e9
# Source 2: https://launchschool.com/posts/5b6964e1

# OVERVIEW 
# Lexical scope means that the scope of the object is determined by the area of the code in which it was defined. 

# With Ruby, the only place this comes into play is with CONSTANTS.

# CONSTANTS have different scoping rules than other variables (they have lexical scope), and this becomes more 
# apparent and important in the case of inheritance w/ CONSTANTS (both class and modular inheritance). 

# Basic example that illustrates lexical scope 
ABC = 'hello' # CONSTANT 
              # vs. 
defg = 'bye'  # local variable 

def example_method
  puts ABC       # ABC is in lexical scope since it is a constant, so this would output 'hello'
  puts defg      # defg is out of scope since methods define their own scope; this would throw an error
end

example_method # method call 

# ----------------------------------------------------------------------------------------------------------------

# EXAMPLE WITH CLASS INHERITANCE 
class Car
  WHEELS = 4

  def wheels
    WHEELS
  end
end

class Motorcycle < Car
  WHEELS = 2
end

civic = Car.new
puts civic.wheels # => 4

bullet = Motorcycle.new
puts bullet.wheels # => 4, when you expect the out to be 2

# The unexpected output on line 24 is due to lexical scoping of the constant WHEELS initialized on line 9. 
# When inheriting the Car::wheels method, Motorcycle class also seems to inherit the value of the constant. 
# This is because for the Car::wheels method, the lexical scope of the WHEELS constant remains limited to 
# the Car class, despite the inheritance.

# Thus, for the code to work, we'd have to do this below, which isn't very DRY...

class Car
  WHEELS = 4

  def wheels
    WHEELS
  end
end

class Motorcycle < Car
  WHEELS = 2

  def wheels
    WHEELS
  end
end

civic = Car.new
puts civic.wheels # => 4

bullet = Motorcycle.new
puts bullet.wheels # => 2

# Instead, we could do use `self.class` so that the WHEELS constant always gets accessed via its own class...
class Car
  WHEELS = 4

  def wheels
    self.class::WHEELS
  end
end

class Motorcycle < Car
  WHEELS = 2
end

civic = Car.new
puts civic.wheels # => 4

bullet = Motorcycle.new
puts bullet.wheels # => 2

# ----------------------------------------------------------------------------------------------------------------

# SIMILAR EXAMPLE WITH MODULAR INHERITANCE 

# Bad code...
module Wheelable 
	WHEELS = 4
	def attach_wheels
		puts "attaching #{WHEELS} wheels"
	end 
end 

class Car
	include Wheelable 
end

class Motorcycle < Car
  WHEELS = 2
end

civic = Car.new
puts civic.attach_wheels # => "attaching 4 wheels"

bullet = Motorcycle.new
puts bullet.attach_wheels # => "attaching 4 wheels", when you expect "attaching 2 wheels"

# vs. fixed code... 
module Wheelable 
	WHEELS = 4
	def attach_wheels
		puts "attaching #{self.class::WHEELS} wheels"
	end 
end 

class Car
	include Wheelable 
end

class Motorcycle < Car
  WHEELS = 2
end

civic = Car.new
puts civic.attach_wheels # => "attaching 4 wheels"

bullet = Motorcycle.new
puts bullet.attach_wheels


