require "velomemo"

describe Velomemo::Ride do
  describe "#to_s" do
    before(:each) do
      @ride = Velomemo::Ride.new(:notes => "foo", :distance => 30)
    end

    it "displays each label-value pair separated by a newline" do
      @ride.to_s.should =~ /^\s*notes:\s+foo$/
      @ride.to_s.should =~ /^\s*distance:\s+30$/
    end

    it "right-aligns each label at column 20" do
      @ride.to_s.should =~ /^               notes: foo$/
      @ride.to_s.should =~ /^            distance: 30$/
    end

    it "wraps long values at 78 columns" do
      notes = ("foo bar " * 7) + "baz bat"
      ride = Velomemo::Ride.new(:notes => notes, :distance => 30)
      lw = Velomemo::Ride::LABEL_WIDTH
      ride.to_s.should =~ /^ {#{lw-5}}notes: (foo bar ){6}foo bar\n {#{lw}}  baz bat$/
    end
  end
end
