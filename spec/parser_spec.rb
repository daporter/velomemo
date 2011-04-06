require File.join(File.dirname(__FILE__), "spec_helper")

describe Velomemo::Parser do
  subject { Velomemo::Parser }
  describe '#parse' do
    let(:yaml) do
      <<-END
        - date: 2011-03-10
          distance: 22
        - date: 2011-03-11
          distance: 31
      END
    end

    it 'returns a Ride for each YAML item' do
      subject.parse(yaml).should have(2).items
    end
  end
end
