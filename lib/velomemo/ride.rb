module Velomemo

  class Ride

    def initialize(data)
      @data = data
    end

    def to_s
      @data.map { |k,v| "#{k}: #{v}" }.join("\n")
    end

  end

end
