require 'spec_helper'

describe Luego::Future do
  it "should accept both a block and a thread" do
    Luego::Future.new{sleep 1}.ready?.should == false
    Luego::Future.new(Thread.new{sleep 1}).ready?.should == false
  end

  it "shouldn't be ready until its block returns" do
    future = Luego::Future.new {sleep 0.1}
    future.ready?.should == false

    sleep 0.2
    future.ready?.should == true
  end

  it "should 'become' the future object when it's ready" do
    subject = "hello"
    future = Luego::Future.new{subject}

    future.should === subject
    subject.upcase!

    future.should == "HELLO"
  end
end
