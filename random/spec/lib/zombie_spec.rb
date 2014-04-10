require 'spec_helper'
require 'zombie'

describe Zombie do
  it "is named Ash" do
    z = Zombie.new
    z.name.should == "Ash"
  end

  it "has no brains" do
    z = Zombie.new
    z.brains.should be < 1
  end

  it "should be rotting" do
    z = Zombie.new
    z.rotting.should be_true
  end

  xit "should not be alive" do
    z = Zombie.new
    z.should_not be_alive
  end
end