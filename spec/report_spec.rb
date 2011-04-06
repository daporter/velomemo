require File.join(File.dirname(__FILE__), "spec_helper")

describe Velomemo::Report do
  describe "#rides_in_period" do
    describe "when period is nil" do
      it "returns all rides" do
        rides = [{ :date => Date.today - 2, :distance => 32 },
                 { :date => Date.today,     :distance => 54 }]
        report = Velomemo::Report.new(rides, nil)
        report.rides_in_period.should == rides
      end
    end

    describe "when period is non-nil" do
      it "returns rides included in period" do
        ride = double("ride")
        ride.stub(:date) { Date.today }
        period = double("period")
        period.stub(:includes?) { true }
        report = Velomemo::Report.new([ride], period)
        report.rides_in_period.should include(ride)
      end

      it "does not return rides not included in period" do
        ride = double("ride")
        ride.stub(:date) { Date.today }
        period = double("period")
        period.stub(:includes?) { false }
        report = Velomemo::Report.new([ride], period)
        report.rides_in_period.should_not include(ride)
      end
    end
  end

  describe '#to_s' do
    before(:each) do
      @rides  = [double, double, double]
      @report = Velomemo::Report.new(@rides)
    end

    it 'uses the string representation of each ride' do
      @rides.each { |r| r.should_receive(:to_s) }
      @report.to_s
    end

    it 'separates each ride by a newlines' do
      @report.to_s.should == @rides.map(&:to_s).join("\n")
    end
  end
end
