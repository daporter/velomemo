module Velomemo

  class Ride
    LABEL_WIDTH = 20

    def initialize(data)
      @data = data
    end

    def to_s
      @data.map { |k,v| sprintf("%#{LABEL_WIDTH}s: %s", k, v) }.join("\n")
    end
  end

end
