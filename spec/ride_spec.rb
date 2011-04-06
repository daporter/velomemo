require File.join(File.dirname(__FILE__), "spec_helper")

describe Velomemo::Ride do
  describe "#date" do
    it "should return nil if no value is labeled 'date'" do
      ride = Velomemo::Ride.new(:distance => 28)
      ride.date.should be_nil
    end

    it "should return the value whose label is 'date'" do
      ride = Velomemo::Ride.new(:date => "2011-04-05", :distance => 28)
      ride.date.should == Date.parse("2011-04-05")
    end
  end

  describe "#to_s" do
    subject { Velomemo::Ride.new(:notes => "foo", :distance => 30) }

    it "displays each label-value pair separated by a newline" do
      subject.to_s.should =~ /^\s*notes:\s+foo$/
      subject.to_s.should =~ /^\s*distance:\s+30$/
    end

    describe "with line_width of 78" do
      it "right-aligns each label at column 20" do
        ride = Velomemo::Ride.new({ :notes => "foo", :distance => 30 }, 78)
        ride.to_s.should =~ /^               notes: foo$/
        ride.to_s.should =~ /^            distance: 30$/
      end

      it "wraps long values at 78 columns" do
        ride = Velomemo::Ride.new({ :notes => ("foo " * 14) + "bar" }, 78)
        ride.to_s.should =~ /^ {15}notes: (foo ){13}foo\n {20}  bar$/
      end
    end
  end
end
