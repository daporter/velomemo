require File.join(File.dirname(__FILE__), "spec_helper")

describe Velomemo::Period do
  describe "#new" do
    it "accepts nil as first argument" do
      expect { Velomemo::Period.new(nil, Date.today) }.to_not raise_error
    end

    it "accepts nil as second argument" do
      expect { Velomemo::Period.new(Date.today, nil) }.to_not raise_error
    end

    it "raises an error when beginning is before end" do
      expect do
        Velomemo::Period.new(Date.today, Date.today - 1)
      end.to raise_error(ArgumentError)
    end
  end

  describe "#includes?" do
    describe "when both beginning and end are nil" do
      subject { Velomemo::Period.new(nil, nil) }

      it "returns true" do
        subject.includes?(Date.today).should be_true
      end
    end

    describe "when beginning is nil and end is not nil" do
      subject { Velomemo::Period.new(nil, Date.today) }

      it "returns true when arg <= end" do
        subject.includes?(Date.today - 1).should be_true
      end

      it "returns false when arg > end" do
        subject.includes?(Date.today + 1).should be_false
      end
    end

    describe "when both beginning and end are not nil" do
      subject { Velomemo::Period.new(Date.today - 2, Date.today) }

      it "returns true when arg is nil" do
        subject.includes?(nil).should be_true
      end

      it "returns false when arg is before beginning of period" do
        subject.includes?(subject.beginning - 1).should be_false
      end

      it "returns true when arg is equal to beginning of period" do
        subject.includes?(subject.beginning).should be_true
      end

      it "returns true when arg is between beginning and end of period" do
        subject.includes?(subject.beginning + 1).should be_true
      end

      it "returns true when arg is equal to end of period" do
        subject.includes?(subject.end).should be_true
      end

      it "returns false when arg is after end of period" do
        subject.includes?(subject.end + 1).should be_false
      end
    end

    describe "when beginning is not nil and end is nil" do
      subject { Velomemo::Period.new(Date.today, nil) }

      it "returns false when arg < beginning" do
        subject.includes?(Date.today - 1).should be_false
      end

      it "returns true when arg >= beginning" do
        subject.includes?(Date.today).should be_true
      end
    end
  end
end
