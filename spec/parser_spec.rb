require File.dirname(__FILE__) + '/spec_helper'

describe Velomemo::Parser do
  describe '#parse' do
    it 'returns a Ride for each YAML item' do
      yaml = <<-END
        - date: 2011-03-10
          distance: 22
        - date: 2011-03-11
          distance: 31
      END
      Velomemo::Parser.parse(yaml).should have(2).items
    end
  end
end
