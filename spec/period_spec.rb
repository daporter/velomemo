require File.join(File.dirname(__FILE__), "spec_helper")

describe Velomemo::Period do
  describe "#new" do
    it 'raises an error when beginning is before end' do
      expect do
        Velomemo::Period.new(Date.today, Date.today - 1)
      end.to raise_error(ArgumentError)
    end
  end

  describe "#includes?" do
    subject { Velomemo::Period.new(Date.today - 2, Date.today) }

    it "returns true when arg is nil" do
      subject.includes?(nil).should be_true
    end

    it "returns false when arg is before beginning of period" do
      subject.includes?(subject.begin - 1).should be_false
    end

    it "returns true when arg is equal to beginning of period" do
      subject.includes?(subject.begin).should be_true
    end

    it "returns true when arg is between beginning and end of period" do
      subject.includes?(subject.begin + 1).should be_true
    end

    it "returns true when arg is equal to end of period" do
      subject.includes?(subject.end).should be_true
    end

    it "returns false when arg is after end of period" do
      subject.includes?(subject.end + 1).should be_false
    end
  end
end
