# RB 120 OOP Small Exercises - Exercises 21-30 
# Topic: Inheritance 
# Date: 03/08/21

# EXERCISES 21-23
class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  attr_reader :bed_type 

  def initialize(year, bed_type)
    super(year)
    @bed_type = bed_type
  end 
end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type

EXERCISE 24 
class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')

# EXERCISES 25-26
module Towable
  def tow
    puts "I can tow a trailer!"
  end 
end 

class Vehicle 
  attr_reader :year 

  def initialize(year)
    @year = year 
  end 
end 

class Truck < Vehicle 
  include Towable
end

class Car < Vehicle 
end

truck1 = Truck.new(1994)
puts truck1.year
puts truck1.tow

car1 = Car.new(2006)
puts car1.year

# EXERCISES 27-28
# Question: what's the method lookup path for invoking `cat1.color`? 

# Method lookup path
# Cat (checked)
# Animal (checked and found)
# Object (not checked)
# Kernel (not checked)
# BasicObject (not checked)

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color

#EXERCISE 29
# Question: what's the method lookup path used when invoking `bird1.color`? Only include what actually gets checked. 

# Method lookup path
# Bird 
# Flyable *When a module is included in a class, the class is searched before the module. But, the module is searched before the superclass. 
# Animal 

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color

#EXERCISE 30
module Transportation
  class Vehicle 
  end 

  class Truck < Vehicle
  end 

  class Car < Vehicle 
  end 
end 

Transportation::Truck.new # how we instantiate a class that's contained in a module 
