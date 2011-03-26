module Velomemo

  class Parser
    def initialize(data)
      @data = data
    end

    def parse
      @data.lines
    end
  end

end
