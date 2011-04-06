require File.join(File.dirname(__FILE__), "spec_helper")

describe Velomemo::Report do
  describe "#rides_in_period" do
    describe "when period is nil" do
      let(:rides) { double("rides") }
      subject { Velomemo::Report.new(rides, nil) }
      its(:rides_in_period) { should == rides }
    end

    describe "when period is non-nil" do
      let(:ride)   { double("ride") }
      let(:period) { double("period") }
      subject { Velomemo::Report.new([ride], period) }

      it "returns rides included in period" do
        ride.stub(:date) { Date.today }
        period.stub(:includes?) { true }
        subject.rides_in_period.should include(ride)
      end

      it "does not return rides not included in period" do
        ride.stub(:date) { Date.today }
        period.stub(:includes?) { false }
        subject.rides_in_period.should_not include(ride)
      end
    end
  end

  describe '#to_s' do
    let(:rides) do
      rides  = [double, double, double]
      rides.each { |r| r.stub(:to_s) { "foo\n" } }
      rides
    end

    subject { Velomemo::Report.new(rides) }

    it 'uses the string representation of each ride' do
      rides.each { |r| r.should_receive(:to_s) }
      subject.to_s
    end

    it 'separates each ride by a newlines' do
      subject.to_s.should == rides.map(&:to_s).join("\n")
    end
  end
end
