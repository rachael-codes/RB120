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