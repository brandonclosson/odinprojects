class Zombie
  attr_accessor :name, :brains

  def initialize
    @name = "Ash"
    @brains = 0
  end

  def alive?
    false
  end

  def rotting
    true
  end
end