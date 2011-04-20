require File.join(File.dirname(__FILE__), "spec_helper")

describe Velomemo::Report do
  describe "#rides_in_period" do
    let(:ride)   { double("ride") }
    let(:period) { double("period") }
    subject { Velomemo::Report.new([ride], period, ["distance"]) }

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

  describe '#to_s' do
    let(:rides) do
      rides  = [double, double, double]
      rides.each do |r|
        r.stub(:date)
        r.stub(:to_s) { "foo\n" }
      end
      rides
    end

    let(:period) do
      period = double("period")
      period.stub(:includes?) { true }
      period
    end

    subject { Velomemo::Report.new(rides, period, ["distance", "time"]) }

    it 'uses the string representation of each ride' do
      rides.each { |r| r.should_receive(:to_s).with(["distance", "time"]) }
      subject.to_s
    end

    it 'separates each ride by a newlines' do
      subject.to_s.should == rides.map(&:to_s).join("\n")
    end
  end
end
