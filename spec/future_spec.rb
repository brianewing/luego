require 'spec_helper'

describe Luego::Future do
  it "should accept both a block and a thread" do
    sleeper = lambda { sleep 1 }
    Luego::Future.new(&sleeper).should_not be_ready
    Luego::Future.new(Thread.new &sleeper).should_not be_ready
  end

  it "shouldn't be ready until its block returns" do
    future = Luego::Future.new { sleep 0.1 }
    future.should_not be_ready

    sleep 0.2
    future.should be_ready
  end

  it "should 'become' the future object when it's ready" do
    subject = "hello"
    future = Luego::Future.new { subject }

    future.should === subject
    subject.upcase!

    future.should == "HELLO"
  end
end
