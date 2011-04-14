require File.join(File.dirname(__FILE__), "spec_helper")

describe Velomemo::Ride do
  describe "when data has no attribute 'date'" do
    subject { Velomemo::Ride.new(:distance => 28) }
    its(:date) { should be_nil}
  end

  describe "when data has an attribute 'date'" do
    subject { Velomemo::Ride.new("date" => Date.today, :distance => 28) }
    its(:date) { should == Date.today }
  end

  describe "with line_width=78" do
    subject { Velomemo::Ride.new({ :notes => "foo", :distance => 30 }, 78) }

    describe "#to_s" do
      it "displays each label-value pair separated by a newline" do
        subject.to_s.should =~ /^\s*notes:\s+foo$/
        subject.to_s.should =~ /^\s*distance:\s+30$/
      end

      it "right-aligns each label at column 20" do
        subject.to_s.should =~ /^               notes: foo$/
        subject.to_s.should =~ /^            distance: 30$/
      end

      it "wraps long values at 78 columns" do
        ride = Velomemo::Ride.new({ :notes => ("foo " * 14) + "bar" }, 78)
        ride.to_s.should =~ /^ {15}notes: (foo ){13}foo\n {20}  bar$/
      end
    end
  end
end
