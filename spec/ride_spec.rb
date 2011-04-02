require "velomemo"

describe Velomemo::Ride do
  describe "#to_s" do
    it "displays each key-value pair separated by a newline" do
      ride = Velomemo::Ride.new(:notes => "foo", :distance => 30)
      ride.to_s.should =~ /^\s*notes:\s+foo$/
      ride.to_s.should =~ /^\s*distance:\s+30$/
    end
  end
end
