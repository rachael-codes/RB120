# DUCK TYPING, EXPLAINED
# Date: 03/09/21

# EXPLANATION
# Chef, Decorator, and Musician all have an instance
# method called prepare_wedding.
# We can reference the prepare_wedding method inside of
# the Wedding class's prepare method, without specifically
# needing to specify which version of prepare_wedding
# we're referring to during each iteration.

# We do not need to know if the preparer is a Chef,
# Decorator, or Musician.
# All preparers have the ability to prepare a wedding
# whether they are a Chef, Decorator, or a Musician

# In other words, we don't need to check if the Chef,
# Decorator, or Musician is a preparer. It's good enough
# to know that Chef, Decorator, and Musician acts and
# behaves like a preparer, and we can trust them to do
# the job of prepare_wedding.

# In the duck idiom, we don't need to check whether it is a
# duck, but it's good enough to know it quacks like a duck,
# walks like a duck, and etc. As long as it behaves like a
# duck, it is as good as if it were a real duck.
# In the preparer example, as long as Chef, Decorator or
# Musician behaves like a preparer, we can put a broad label
# on them and call them preparers to do the prepare_wedding
# job.

class Wedding
  attr_reader :guests, :flowers, :songs

  def initialize
    @guests = ["Billy", "Jessica"]
    @flowers = ["lilies", "tulips"]
    @songs = ["Eye of the Tiger", "Africa"]
  end

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    puts "Preparing food for #{guests[0]} and #{guests[1]}."
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    puts "Placing the #{flowers[0]} and #{flowers[1]} on the tables."
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    puts "Queueing up #{songs[0]} and #{songs[1]}."
  end
end

joe = Chef.new
bob = Decorator.new
linda = Musician.new
staff = [joe, bob, linda]
sean_and_dyani = Wedding.new
sean_and_dyani.prepare(staff)
