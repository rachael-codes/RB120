# # RB 120 OOP Small Exercises - Exercises 51 - 60 
# # Classification: Easy 2 
# # Date: 03/10/21

# # EXERCISE 1
module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable 

  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable 

  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address
# ------------------------------------------------------------------------------------------------

# # EXERCISE 2
module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
# ------------------------------------------------------------------------------------------------

# EXERCISE 3
class House
  attr_reader :price
  include Comparable

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end 
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2 # => Home 1 is cheaper
puts "Home 2 is more expensive" if home2 > home1 # => Home 2 is more expensive
# ------------------------------------------------------------------------------------------------

# EXERCISE 4 
class Transform
  def initialize(data)
    @data = data
  end 

  def uppercase 
    @data.upcase 
  end 

  def self.lowercase(string)
    string.downcase
  end 
end 

my_data = Transform.new('abc')
puts my_data.uppercase              # ABC 
puts Transform.lowercase('XYZ')     # xyz
# ------------------------------------------------------------------------------------------------

# EXERCISE 5 
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata #"ByeBye"
puts thing.dupdata #HelloHello
# ------------------------------------------------------------------------------------------------

# EXERCISE 6 
class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected 

  attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)

if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

# # ------------------------------------------------------------------------------------------------

# # EXERCISE 7 

# LS's solution: 
# class Pet
#   attr_reader :animal, :name

#   def initialize(animal, name)
#     @animal = animal
#     @name = name
#   end

#   def to_s
#     "a #{animal} named #{name}"
#   end
# end

# class Owner
#   attr_reader :name, :pets

#   def initialize(name)
#     @name = name
#     @pets = []
#   end

#   def add_pet(pet)
#     @pets << pet
#   end

#   def number_of_pets
#     pets.size
#   end

#   def print_pets
#     puts pets
#   end
# end

# class Shelter
#   def initialize
#     @owners = {}
#   end

#   def adopt(owner, pet)
#     owner.add_pet(pet)
#     @owners[owner.name] ||= owner
#   end

#   def print_adoptions
#     @owners.each_pair do |name, owner|
#       puts "#{name} has adopted the following pets:"
#       owner.print_pets
#       puts
#     end
#   end
# end

# My own solution: 
class Owner 
  attr_reader :name
  attr_accessor :number_of_pets

  def initialize(name)
    @name = name 
    @number_of_pets = 0
  end 
end 

class Pet 
  attr_reader :animal_type, :name 

  def initialize(animal_type, name) # Pet class has two string collab objects 
    @animal_type = animal_type 
    @name = name 
  end 
end 

class Shelter 
  def initialize
    @owners_and_pets = {}
  end 

  def adopt(owner, pet)
    if !(@owners_and_pets.include?(owner)) 
      @owners_and_pets[owner] = [pet] 
    else 
      @owners_and_pets[owner] << pet 
    end 
    owner.number_of_pets += 1 
  end 

  def print_adoptions
    @owners_and_pets.each do |owner, pets|
      puts "#{owner.name} has adopted the following pets:" 
      pets.each { |pet| puts "a #{pet.animal_type} named #{pet.name}" } 
      puts 
    end 
  end 
end 


# # This exercise is about collaborator objects; instance variables don't have to be simple variables like numbers and strings, 
# # but can contain any object that might be needed. In our solution, the Pet class has two String collaborator objects, 
# # Owner has a String and an Array of Pet objects that are collaborators, and Shelter has a Hash of Owner objects that's a collaborator.

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester) 
shelter.print_adoptions
# # => P Hanson has adopted the following pets:
# # => a cat named Butterscotch
# # => a cat named Pudding
# # => a bearded dragon named Darwin

# # => B Holmes has adopted the following pets:
# # => a dog named Molly
# # => a parakeet named Sweetie Pie
# # => a dog named Kennedy
# # => a fish named Chester
# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets." #P Hanson has 3 adopted pets.
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets." #B Holmes has 4 adopted pets.

# # Another way to do it 
class Pet
  attr_reader :species, :name
  def initialize(species, name)
    @species = species
    @name = name
  end
end

class Owner
  attr_reader :name, :pets
  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets  
    @pets.size
  end
end

class Shelter
  attr_reader :register
  def initialize
    @register = []
  end

  def adopt(owner, pet)
    if !register.include?(owner)
      @register << owner
      owner.pets << pet
    else
      owner.pets << pet
    end
  end

  def print_adoptions
    @register.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.pets.each do |pet|
        puts "a #{pet.species} named #{pet.name}"
      end
      puts
    end
  end
end

# ------------------------------------------------------------------------------------------------

# EXERCISE 8 
class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

# ------------------------------------------------------------------------------------------------

expander = Expander.new('xyz')
puts expander

# EXERCISES 9 and 10 
module Walkable
  def walk 
    "#{name} #{gait} forward."
  end 
end 

class Person
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :title 

  def initialize(name, title)
    super(name)
    @title = title 
  end 

  def walk 
    title + ' ' + super
  end 

  private

  def gait
    "struts"
  end
end 

class Cat
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah < Cat 
  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
puts mike.walk # => "Mike strolls forward."

kitty = Cat.new("Kitty")
puts kitty.walk # => "Kitty saunters forward."

flash = Cheetah.new("Flash")
puts flash.walk # => "Flash runs forward."

byron = Noble.new("Byron", "Lord")
puts byron.walk # => "Lord Byron struts forward."

# Reason we use a Walkable module rather than define a parent class from which Cat, Cheetah, and Person would inherit:
# because modules are more appropriate with a has-a relationship (i.e. this animal has an ability to walk)
