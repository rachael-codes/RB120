class WeddingGuest
  @@num_of_people = 0
  
  def self.num_of_people
    @@num_of_people
  end
  
  def initialize
    @@num_of_people += 1
  end
end
  
p WeddingGuest.num_of_people #=> 0 
WeddingGuest.new
WeddingGuest.new
p WeddingGuest.num_of_people #=> 2 

class BridesGuest < WeddingGuest
  @@num_of_people = 10
end
  
class GroomsGuest < WeddingGuest
  def initialize
    @@num_of_people = 15
  end
end
  
BridesGuest.new
p WeddingGuest.num_of_people # => very confusing b/c by calling BridesGuest on previous line, `@@num_of_people` was reassigned to 10
# then by calling `WeddingGuest.num_of_people` on this line, `@@num_of_people` was incremented by 1, which results in 11. 
p GroomsGuest.num_of_people # => Here, the number is still 11 because a new instance of the `GroomsGuest` class hasn't been called
# to reassign the number to 15. 
GroomsGuest.new 
p GroomsGuest.num_of_people # => 15 



module Armable 
  def attach_armor
    puts "Attaching armor"
  end 

  def remove_armor
    puts "Removing armor"
  end 
end 

module CastSpellable 
  def cast_spell(spell)
    puts "Casting #{spell}"
  end 
end 

class Player 
  attr_reader :name, :health, :strength, :intelligence 

  def initialize(name)
    @name = name 
    @health = 100
    @strength = roll_dice 
    @intelligence = roll_dice
  end 

  def heal(amount_of_change)
    @health += amount_of_change
  end 

  def hurt(amount_of_change)
    @health -= amount_of_change
  end 

  def to_s
    "Name: #{name} \nClass: #{self.class}\nHealth: #{health} \nStrength: #{strength}\nIntelligence: #{intelligence}"
  end 

  private 

  def roll_dice 
    (2..12).to_a.sample
  end 
end 

class Warrior < Player 
  include Armable 

  def initialize(name)
    super(name)
    @strength = roll_dice + 2 
  end 
end 

class Magician < Player 
  include CastSpellable 

  def initialize(name)
    super(name)
    @intelligence = roll_dice + 2 
  end 
end 

class Paladin < Player 
  include Armable 
  include CastSpellable 
end 

class Bard < Player 
  include CastSpellable 

  def create_potion
    puts "Concocting potion"
  end 
end 


rachael = Bard.new('Rachael')
puts rachael



