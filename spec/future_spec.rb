require 'spec_helper'

describe Luego::Future do
  it "should accept both a block and a thread" do
    sleeper = lambda { sleep 1 }
    Luego::Future.new(&sleeper).should_not be_ready
    Luego::Future.new(Thread.new &sleeper).should_not be_ready
  end

  it "shouldn't be ready until its block returns" do
    thread = Thread.new { sleep 0.05 }

    future = Luego::Future.new(thread)
    future.should_not be_ready

    thread.join
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
