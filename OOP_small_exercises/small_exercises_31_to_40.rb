
# RB 120 OOP Small Exercises - Exercises 31-40 
# Topic: Accessor Methods
# Date: 03/09/21

# EXERCISE 31
class Person
  attr_accessor :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name
# ------------------------------------------------------------------------------------------------

# EXERCISE 32
class Person
  attr_accessor :name 
  attr_writer :phone_number
end

person1 = Person.new
person1.name = 'Jessica'
person1.phone_number = '0123456789'
puts person1.name
# ------------------------------------------------------------------------------------------------

# # EXERCISE 33 
class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end
end

person1 = Person.new(1234567899)
puts person1.phone_number

person1.phone_number = 9987654321
puts person1.phone_number
# ------------------------------------------------------------------------------------------------

#EXERCISE 34 - RE-DO THIS ONE!!! ----------------------------------------------------------------
# Instructions: add the appropriate accessor methods. 
# Keep in mind that the last_name getter shouldn't be visible outside the class, while the 
# first_name getter should be visible outside the class.

class Person
  attr_accessor :first_name
  attr_writer :last_name

  def first_equals_last?
    first_name == last_name
  end

  private 

  attr_reader :last_name
end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last? # => false 
# ------------------------------------------------------------------------------------------------

# EXERCISE 35
class Person
  attr_writer :age 

  def older_than?(other)
    age > other.age
  end

  protected 

  attr_reader :age 
end

person1 = Person.new
person1.age = 17

person2 = Person.new
person2.age = 26

puts person1.older_than?(person2) # => false 
# ------------------------------------------------------------------------------------------------

# EXERCISE 36
# INSTRUCTIONS - add the appropriate accessor methods so that @name is capitalized upon assignment
class Person
  attr_reader :name

  def name=(name)
    @name = name.capitalize 
  end 
end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name # => "Elizabeth"

# Point of this above - shows us that normally, we would use Ruby's built in accessor methods, 
# but since we have to add extra functionality to the method, we're forced to implement our own.
# ------------------------------------------------------------------------------------------------

# EXERCISE 37
# INSTRUCTIONS - add the prefix 'Mr.'
class Person
  attr_reader :writer  

  def name
    "Mr. #{name}"
  end 
end

person1 = Person.new
person1.name = 'James'
puts person1.name # => Mr. James

# Point of this above - shows us same thing as in previous example but that we can also do this 
# in lieu of `attr_reader` if we want to read/present something a certan way. 
# ------------------------------------------------------------------------------------------------

# EXERCISE 38
# Fix the code so that it returns a copy of @name instead of a reference to it.

class Person
  def initialize(name)
    @name = name 
  end

  def name
    @name.clone 
  end 
end

person1 = Person.new('James')
person1.name.reverse!
puts person1.name # => James (not 'semaJ')

# To prevent a destructive method from changing the argument that's passed in, we can invoke the #clone 
# method on @name, which returns a copy of @name instead of a reference to it. This means that any 
# modifications done to the return value won't affect the value of @name. 
# We also don't need the attr_reader line since we are providing a customized getter method.

# ------------------------------------------------------------------------------------------------

# EXERCISE 39 
# Multiply @age by 2 upon assignment, then multiply @age by 2 again when @age is returned by the getter method.

class Person
  def age=(age)
    @age = age * 2 
  end 

  def age 
    @age * 2 
  end 
end

person1 = Person.new
person1.age = 20
puts person1.age # => 80 

# Another way 
class Person
  def age=(age)
    @age = double(age)
  end

  def age
    double(@age)
  end

  private

  def double(value)
    value * 2
  end
end

# EXERCISE 40 
class Person
  def name=(name)
    @first = name.split.first 
    @last = name.split.last 
  end 

  def name 
    "#{@first} #{@last}"
  end 
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name # => 'John Doe'
