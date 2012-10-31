require 'spec_helper'

describe Luego::Delegate do
  it "should take an object when initialised" do
    Luego::Delegate.new("hello")
  end

  it "should not delegate methods until delegate! is called" do
    string = Luego::Delegate.new("hello world")
    lambda { string.upcase }.should raise_error NoMethodError

    string.delegate!
    string.upcase.should == "HELLO WORLD"
  end

  it "should offer its own methods for handling the delegation" do
    d = Luego::Delegate.new(nil)
    d.delegating?.should == false

    d.delegate!
    d.delegating?.should == true

    d.undelegate!
    d.delegating?.should == false
  end

  it "should stop delegating when undelegate! is called" do
    string = Luego::Delegate.new("hello world")
    string.delegate!

    string.should be_a String
    string.should_not be_a Luego::Delegate
  end

  it "should be equal to the child object when delegating" do
    child = "hello world"
    delegate = Luego::Delegate.new(child)
    delegate.delegate!

    delegate.should === child
    delegate.should eql child
    delegate.should be_equal child
  end

  it "should completely delegate all methods" do
    s = "hello world"
    clone = Luego::Delegate.new(s.dup)
    clone.delegate!

    s.public_methods.each do |m|
      s.should be_a_kind_of clone.method(m).owner # ensure method comes (a superclass of) String
    end
  end
end
