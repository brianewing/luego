describe "Kernel#future" do
  it "should not be defined before requiring 'luego/kernel'" do
    Kernel.instance_methods.should_not include(:future)
  end

  it "should define Kernel#future" do
    require 'luego/kernel'

    Kernel.instance_methods.should include(:future)
  end

  it "should work like using Luego::Future.new" do
    future { 5 }.should == 5
    future { sleep 5 }.should_not be_ready
  end
end