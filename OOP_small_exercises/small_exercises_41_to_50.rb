# RB 120 OOP Small Exercises - Exercises 41-50 
# Classification: Easy 1 
# Date: 03/09/21

# EXERCISE 1
# Complete this class so that the test cases shown below work as intended. You are free to add any methods 
# or instance variables you need. However, do not make the implementation details public.

# Example 1 (w/ string)
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

# Example 2 (w/ empty string)
# +--+
# |  |
# |  |
# |  |
# +--+

class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    '+-' + ('-' * @message.size) + '-+'
  end

  def empty_line
    '| ' + (' ' * @message.size) + ' |'
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner 

banner = Banner.new('')
puts banner
# ------------------------------------------------------------------------------------------------

# EXERCISE 2 
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s # to_s creates a new object; connection to local variable `name` is lost
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

# # Further exploration 
# # This code "works" because of that mysterious to_s call in Pet#initialize. 
# # However, that doesn't explain why this code produces the result it does. Can you?
# # My answer - two reasons (both are in comments on code itself)

# name = 42
# fluffy = Pet.new(name)
# name += 1 # re-assigned local variable `name` to another integer object
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name
# ------------------------------------------------------------------------------------------------

# EXERCISE 3
class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.) # The author of "Snow Crash" is Neil Stephenson.
puts %(book = #{book}.) # book = "Snow Crash", by Neil Stephenson.
# ------------------------------------------------------------------------------------------------

# EXERCISE 4
class Book
  attr_accessor :title, :author 

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.) # The author of "Snow Crash" is Neil Stephenson.
puts %(book = #{book}.) # book = "Snow Crash", by Neil Stephenson.
# ------------------------------------------------------------------------------------------------

# EXERCISE 5 
class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def first_name=(first_name)
    @first_name = first_name.capitalize
  end 

  def last_name=(last_name)
    @last_name = last_name.capitalize
  end 

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person # John Doe 

person.first_name = 'jane'
person.last_name = 'smith'
puts person # Jane Smith 
# ------------------------------------------------------------------------------------------------

# EXERCISE 6
class Flight
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# ------------------------------------------------------------------------------------------------

# EXERCISE 7 
class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678

# ------------------------------------------------------------------------------------------------

# EXERCISE 8 
class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle 
  def initialize(height_and_width)
    @height = height_and_width
    @width = height_and_width
  end
end 

square = Square.new(5)
puts "area of square = #{square.area}"

# ------------------------------------------------------------------------------------------------

# EXERCISE 9 
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color 
  end 

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@color} fur."
  end 
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch
# Expected => My cat Pudding is 7 years old and has black and white fur.
# Expected => My cat Butterscotch is 10 years old and has tan and white fur.

# ------------------------------------------------------------------------------------------------

# EXERCISE 10
class Vehicle 
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end 

class Car < Vehicle 
  def wheels
    4
  end
end

class Motorcycle < Vehicle 
  def wheels
    2
  end
end

class Truck < Vehicle 
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end
